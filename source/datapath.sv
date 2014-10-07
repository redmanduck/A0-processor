/*

  ssabpisa@purdue.edu, hxiong@purdue.edu

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/
//TODO: Should we Stall when JAL, or store the PC in pipeline latch
// data path interface
`include "datapath_cache_if.vh"
`include "control_unit_if.vh"
`include "register_file_if.vh"
`include "ru_cu_if.vh"
`include "pc_if.vh"
`include "pipereg_if.vh"
`include "hazard_unit_if.vh"
`include "forward_unit_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;
  parameter PC_INIT = 0;

  control_unit_if cuif();
  register_file_if rfif();
//  ru_cu_if rqif();
  pc_if pcif();
  pipereg_if_id ifid();
  pipereg_id_ex idex();
  pipereg_ex_mem xmem();
  pipereg_mem_wb mweb();
  hazard_unit_if hzif();
  forward_unit_if fwif();

  //ALU logics
  aluop_t alu_op;
  word_t alu_a;
  word_t alu_b;
  word_t alu_a_fwd, alu_b_fwd;
  word_t writeback;
  logic alu_nf;
  logic alu_vf;
  word_t alu_output;
  logic alu_zf;
  word_t fwd_rdat1, fwd_rdat2;

  logic stall;

  logic ihit; //not used
  logic dhit; //not used
  //sub-blocks
  hazard_unit HZU(hzif);
  pl_if_id IFID(CLK, nRST, ifid);
  pl_id_ex IDEX(CLK, nRST, idex);
  pl_ex_mem EXMEM(CLK, nRST, xmem);
  pl_mem_wb MEMWB(CLK, nRST, mweb);
  control_unit CU(CLK, nRST, cuif);
  register_file RF(CLK, nRST, rfif);
  program_counter PC(CLK, nRST, pcif);
  forward_unit FWU(fwif);

  alu ALU(.ALUOP(alu_op), .Port_A(alu_a_fwd), .Port_B(alu_b_fwd), .negative(alu_nf), .overflow(alu_vf), .output_port(alu_output), .zero(alu_zf));

  always_comb begin : OPERAND_FORWARD_A
     casez(fwif.forwardA)
        1: alu_a_fwd = xmem.alu_output_out;
        2: alu_a_fwd = writeback;
        3: alu_a_fwd = dpif.dmemload;
        default: alu_a_fwd = alu_a;
     endcase
  end
  always_comb begin : OPERAND_FORWARD_B
     casez(fwif.forwardB)
        1: alu_b_fwd = xmem.alu_output_out;
        2: alu_b_fwd = writeback;
        3: alu_b_fwd = dpif.dmemload;
        default: alu_b_fwd = alu_b;
     endcase
  end

  assign fwif.ex_rs = idex.rs_out;
  assign fwif.ex_rt = idex.rt_out;
  assign fwif.ex_rd = idex.rd_out;
  assign fwif.mem_rd  = xmem.reg_instr_out; //why is mem_rd and wb_rd coming from same place
  assign fwif.wb_rd = mweb.reg_instr_out;//xmem.reg_instr_out; //why do you call this wb_rd if its comming from xmem  ******************
  assign fwif.regWr = mweb.WB_RegWrite_out || xmem.WB_RegWrite_out;//cuif.RegWr;
  assign fwif.regRd = 1'b1;
  assign fwif.memWr = idex.M_MemWrite_out;
  assign fwif.memRegWr = xmem.WB_RegWrite_out;
  assign fwif.exRegWr = idex.WB_RegWrite_out; 
  assign fwif.exMemWr = idex.M_MemWrite_out;//cuif.MemWr;

  assign xmem.alu_output_in = alu_output;
  //PIPELINED
  assign rfif.rsel1 = cuif.rs;
  assign rfif.rsel2 = cuif.rt;
  assign rfif.WEN = mweb.WB_RegWrite_out;

  assign ifid.flush = hzif.flush_ifid;
  assign idex.flush = hzif.flush_idex;
  assign xmem.flush = hzif.flush_xmem;
  assign mweb.flush = 0;

  //PIPELINED rfif wdat
  always_comb begin : RFIF_WRITE
    casez (mweb.WB_MemToReg_out)
      1: writeback = mweb.dmemload_out;
      2: writeback = mweb.pcn_out;  //pcif.imemaddr + 4;
      default: writeback = mweb.alu_output_out;
    endcase
  end
  assign rfif.wdat = writeback;

  always_comb begin : MUX_RGDST
    casez (idex.EX_RegDst_out) 
      1: xmem.reg_instr_in = idex.rd_out;
      2: xmem.reg_instr_in = 31; //JAL
      default: xmem.reg_instr_in = idex.rt_out;
    endcase
  end
  assign fwif.ex_RegDst = idex.EX_RegDst_out;

  assign dpif.dmemREN = xmem.M_MemRead_out;
  assign dpif.dmemWEN = xmem.M_MemWrite_out;

  assign dpif.imemREN = 1'b1;//rqif.imemREN;
  assign dpif.dmemstore = xmem.regfile_rdat2_out; //;  //strange
  assign dpif.dmemaddr = xmem.alu_output_out;

  assign pcif.ihit = ihit; //not used TODO:remove
  assign pcif.dhit = dhit; //not used
  assign pcif.immediate26 = cuif.immediate26;
  assign pcif.immediate = cuif.immediate;
  assign pcif.rdat1 = rfif.rdat1;
  assign pcif.pc_en = hzif.pc_en & nRST & !cuif.halt & dpif.ihit & !dpif.dhit; //dhit
 //mweb-> cuif.halt
  //assign pcif.PCSrc =  cuif.PCSrc;
  assign dpif.imemaddr = pcif.imemaddr;

  assign cuif.instruction = ifid.instruction_out;
  assign cuif.alu_zf = alu_zf; //change this..... latch

  //PIPELINED
  assign alu_op = idex.EX_ALUOp_out;//cuif.ALUctr;
  assign alu_a = idex.rdat1_out;//rfif.rdat1;

  //PIPELINED
  word_t shamt_extended;

  always_comb begin : MUX_ALU_B2
      if(idex.EX_ALUSrc2_out == 0) begin
          shamt_extended = idex.immediate_out;
      end else begin
          shamt_extended = {27'b0, idex.shamt_out};
      end
  end

  always_comb begin : MUX_ALU_B
       if(idex.EX_ALUSrc_out == 0) begin
          alu_b = idex.rdat2_out;
       end else if (idex.EX_ALUSrc_out == 2) begin
          alu_b = {idex.immediate_out, 16'b0}; //ok
       end else begin
          alu_b = shamt_extended;
       end
  end


 //PIPELINED (ID)
 always_comb begin : INSTR
       if(cuif.ExtOp) begin //sign Extended
          idex.immediate_in = {16'hFFFF, cuif.immediate}; //TODO: $signed(cuif.immediate);
       end else begin //zero Extended
          idex.immediate_in = {16'h0000, cuif.immediate};
       end
 end

  //PIPELINED Data memory  (MEM stage)
  //Dcache
//  always_comb
  assign idex.immediate26_in = cuif.immediate26;
  assign idex.rt_in = cuif.rt;
  assign idex.rd_in = cuif.rd;
  assign idex.rs_in = cuif.rs;
  assign dpif.halt = mweb.halt_out; //[pass along the halt]
  assign idex.halt_in = cuif.halt;
  assign xmem.halt_in = idex.halt_out;
  assign mweb.halt_in = xmem.halt_out;
  /*
    PIPELINE motion control
    -- make sure no instruction move forward in PIPELINE
       when stall is asserted.
    -- stall when there is a pending memory operation
  */

  assign stall = (dpif.dmemREN || dpif.dmemWEN ? (!dpif.dhit) : 0);
  always_ff @(posedge CLK, negedge nRST) begin
      if(!nRST) begin
           ifid.WEN <= 1;
      end else begin
           ifid.WEN <= !(stall && hzif.stall_ifid);
      end
  end
  always_ff @(posedge CLK, negedge nRST) begin
       if(!nRST) begin
           idex.WEN <= 1;
      end else begin
           idex.WEN <= !stall;
      end
  end
  always_ff @(posedge CLK, negedge nRST) begin
       if(!nRST) begin
           xmem.WEN <= 1;
      end else begin
           xmem.WEN <= !hzif.stall_xmem;
      end
  end
  always_ff @(posedge CLK, negedge nRST) begin
      if(!nRST) begin
           mweb.WEN <= 1;
      end else begin
           mweb.WEN <= !stall;
      end
  end
  
  assign fwif.id_rt = cuif.rt;
  assign fwif.id_rs = cuif.rs;
 // assign fwd_rdat1 = (fwif.forwardR1 == 1 ? xmem.alu_output_out : rfif.rdat1); //incomplete
   assign fwd_rdat1 = (fwif.forwardR1 == 1 ? xmem.alu_output_out : (fwif.forwardR1 == 2 ? dpif.dmemload : (fwif.forwardR1 == 3 ? writeback : rfif.rdat1)));

 // assign fwd_rdat2 = (fwif.forwardR2 == 1 ? xmem.alu_output_out : (fwif.forwardR2 == 2 ? alu_output : (fwif.forwardR2 == 3 ? mweb.alu_output_out : (fwif.forwardR2 == 4 ? xmem.pcn_out : rfif.rdat2))));
  assign fwd_rdat2 = (fwif.forwardR2 == 1 ? xmem.alu_output_out : (fwif.forwardR2 == 2 ? alu_output : (fwif.forwardR2 == 3 ? writeback : (fwif.forwardR2 == 4 ? xmem.pcn_out : rfif.rdat2))));

  logic reg_equal;
  assign reg_equal = ((fwd_rdat1 - fwd_rdat2) == 0 ? 1 : 0);
  //TODO: move this to decode stage!!! IMPORTANT
  //mux in datapath to do stuff  ^umm what?
  always_comb begin
     if(cuif.Branch && reg_equal || cuif.BranchNEQ && !reg_equal) begin //idex.M_branch_out
        pcif.PCSrc = 2; //jump
     end else begin
        pcif.PCSrc = cuif.PCSrc;
     end
  end

   //hazard uniz
   assign hzif.jump = cuif.Jump;
   assign hzif.branch = cuif.Branch;
   assign hzif.branch_neq = cuif.BranchNEQ;
   //this signal tells the HZU that we are going to take this branch
   assign hzif.is_equal = reg_equal;
   assign hzif.dhit = ((dpif.dmemREN || dpif.dmemWEN) ? dpif.dhit :  0);
   assign hzif.idex_rs = idex.rs_out;
   assign hzif.mwb_rd = mweb.reg_instr_out;
   /*
    PIPELINE LATCHES connections
  */

  assign ifid.instruction_in = dpif.imemload;
  assign ifid.next_address_in = pcif.pc_plus_4;

//  assign idex.rs_in
  assign idex.shamt_in = cuif.shamt;
  assign idex.next_address_in = pcif.pc_plus_4;
  assign idex.WB_MemToReg_in = cuif.MemToReg;
  assign idex.WB_RegWrite_in = cuif.RegWr;
  assign idex.M_Branch_in = cuif.Branch;
  assign idex.M_MemRead_in = cuif.dREN;
  assign idex.M_MemWrite_in = cuif.dWEN;
  assign idex.EX_RegDst_in = cuif.RegDst;
  assign idex.EX_ALUSrc_in = cuif.ALUSrc;
  assign idex.EX_ALUOp_in = cuif.ALUctr;
  assign idex.EX_ALUSrc2_in = cuif.ALUSrc2;
  assign idex.rdat1_in = fwd_rdat1;
  assign idex.rdat2_in = fwd_rdat2;

  assign ifid.pcn_in = pcif.pc_plus_4;
  assign idex.pcn_in = ifid.pcn_out;
  assign xmem.pcn_in = idex.pcn_out;
  assign mweb.pcn_in = xmem.pcn_out;

  assign xmem.M_Branch_in = idex.M_Branch_out;
  assign xmem.WB_MemToReg_in = idex.WB_MemToReg_out;
  assign xmem.WB_RegWrite_in = idex.WB_RegWrite_out;
  assign xmem.M_MemRead_in = idex.M_MemRead_out;

  assign xmem.M_MemWrite_in = idex.M_MemWrite_out;

  //assign xmem.regfile_rdat2_in = idex.rdat2_out;//alu_b_fwd;//idex.rdat2_out;
  assign xmem.regfile_rdat2_in = (fwif.forwardData ? xmem.alu_output_out : idex.rdat2_out);

  assign xmem.alu_zero_in = alu_zf;

  assign mweb.WB_RegWrite_in = xmem.WB_RegWrite_out;
  assign mweb.WB_MemToReg_in = xmem.WB_MemToReg_out;
  assign mweb.dmemload_in = dpif.dmemload;
  assign mweb.alu_output_in = xmem.alu_output_out;
  assign fwif.wbRegWr = mweb.WB_RegWrite_out;
  assign fwif.exMemRead = xmem.M_MemRead_out;
  assign fwif.wbMemRead = mweb.M_MemRead_out;

  assign mweb.M_MemRead_in = xmem.M_MemRead_in;
  assign mweb.reg_instr_in = xmem.reg_instr_out;
  assign rfif.wsel = mweb.reg_instr_out;


endmodule
