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

  //ALU logics
  aluop_t alu_op;
  word_t alu_a;
  word_t alu_b;
  logic alu_nf;
  logic alu_vf;
  word_t alu_output;
  logic alu_zf;

  logic stall;

  logic ihit; //not used
  logic dhit; //not used
  //sub-blocks
  control_unit CU(CLK, nRST, cuif);

  register_file RF(CLK, nRST, rfif);

  program_counter PC(CLK, nRST, pcif);

  alu ALU(.ALUOP(alu_op), .Port_A(alu_a), .Port_B(alu_b), .negative(alu_nf), .overflow(alu_vf), .output_port(alu_output), .zero(alu_zf));

  assign xmem.alu_output_in = alu_output;

//  request_unit RUCU(CLK, nRST, rqif);
  hazard_unit HZU(hzif);
  pl_if_id IFID(CLK, nRST, ifid);
  pl_id_ex IDEX(CLK, nRST, idex);
  pl_ex_mem EXMEM(CLK, nRST, xmem);
  pl_mem_wb MEMWB(CLK, nRST, mweb);

  //PIPELINED
  assign rfif.rsel1 = cuif.rs;
  assign rfif.rsel2 = cuif.rt;
  assign rfif.WEN = mweb.WB_RegWrite_out;

  assign ifid.flush = dpif.dhit || hzif.flush_ifid;
  assign idex.flush = hzif.flush_idex;
  assign xmem.flush = 0;
  assign mweb.flush = 0;

  //PIPELINED rfif wdat
  always_comb begin : RFIF_WRITE
    casez (mweb.WB_MemToReg_out)
      1: rfif.wdat = mweb.dmemload_out;
      2: rfif.wdat = pcif.imemaddr + 4;//TODO: not implemetned yet, shd be mweb
      default: rfif.wdat = mweb.alu_output_out;
    endcase
  end

  always_comb begin : MUX_RGDST
    casez (idex.EX_RegDst_out)
      1: xmem.reg_instr_in = idex.rd_out;
      2: xmem.reg_instr_in = 31; //JAL
      default: xmem.reg_instr_in = idex.rt_out;
    endcase
  end

  assign dpif.dmemREN = xmem.M_MemRead_out;
  assign dpif.dmemWEN = xmem.M_MemWrite_out;

  assign dpif.imemREN = 1'b1;//rqif.imemREN;
  assign dpif.dmemstore = xmem.regfile_rdat2_out;
  assign dpif.dmemaddr = xmem.alu_output_out;

  assign pcif.ihit = ihit; //not used TODO:remove
  assign pcif.dhit = dhit; //not used
  assign pcif.immediate26 = idex.immediate26_out;
  assign pcif.immediate = idex.immediate_out;
  assign pcif.rdat1 = rfif.rdat1;
  assign pcif.pc_en = hzif.pc_en & nRST & !cuif.halt & dpif.ihit & !dpif.dhit;

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
          alu_b = {idex.immediate_out, 16'b0};
       end else begin
          alu_b = shamt_extended;
       end
  end


 //PIPELINED (ID)
 always_comb begin : INSTR
       if(cuif.ExtOp) begin //sign Extended
          idex.immediate_in = $signed(cuif.immediate);
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
           ifid.WEN <= !stall;
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

  //mux in datapath to do stuff
  always_comb begin
     if(idex.M_Branch_out && alu_zf) begin
        pcif.PCSrc = 2;
     end else begin
        pcif.PCSrc = cuif.PCSrc;
     end
  end

   //hazard uniz
   assign hzif.branch = cuif.Branch;
   assign hzif.alu_zf = alu_zf;

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
  assign idex.rdat1_in = rfif.rdat1;
  assign idex.rdat2_in = rfif.rdat2;

  assign xmem.M_Branch_in = idex.M_Branch_out;
  assign xmem.WB_MemToReg_in = idex.WB_MemToReg_out;
  assign xmem.WB_RegWrite_in = idex.WB_RegWrite_out;
  assign xmem.M_MemRead_in = idex.M_MemRead_out;
  assign xmem.M_MemWrite_in = idex.M_MemWrite_out;
  assign xmem.regfile_rdat2_in = idex.rdat2_out;
  assign xmem.alu_zero_in = alu_zf;

  assign mweb.WB_RegWrite_in = xmem.WB_RegWrite_out;
  assign mweb.WB_MemToReg_in = xmem.WB_MemToReg_out;
  assign mweb.dmemload_in = dpif.dmemload;
  assign mweb.alu_output_in = xmem.alu_output_out;

  assign mweb.reg_instr_in = xmem.reg_instr_out;
  assign rfif.wsel = mweb.reg_instr_out;


endmodule
