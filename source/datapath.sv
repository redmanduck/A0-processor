/*
  Pat Sabpisal
  pat@uniduck.co

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
  ru_cu_if rqif();
  pc_if pcif();
  pipereg_if_id ifid();
  pipereg_id_ex idex();
  pipereg_ex_mem xmem();
  pipereg_mem_wb mweb();

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

  request_unit RUCU(CLK, nRST, rqif);

  pl_if_id PIPEREG_IFID(CLK, nRST, ifid);
  pl_id_ex PIPEREG_IDEX(CLK, nRST, idex);
  pl_ex_mem PIPEREG_XMEM(CLK, nRST, xmem);
  pl_mem_wb PIPEREG_MWEB(CLK, nRST, mweb);

  //TODO: not verified
  assign rfif.rsel1 = cuif.rs;
  assign rfif.rsel2 = cuif.rt;
  assign rfif.WEN = cuif.RegWr;


  //PIPELINED rfif wdat
  always_comb begin : RFIF_WRITE
    casez (mweb.MemToReg_out)
      1: rfif.wdat = mweb.dmemload_out;
      2: rfif.wdat = pcif.imemaddr + 4;//TODO: not implemetned yet, shd be mweb
      default: rfif.wdat = mweb.alu_result_out;
    endcase
  end

  //PIPELINED
  always_comb begin : MUX_RGDST
    casez (idex.RegDst_out)
      1: rfif.wsel = idex.rd_out;
      2: rfif.wsel = 31;
      default: rfif.wsel = idex.rt_out;
    endcase
  end

  assign rqif.dhit = dpif.dhit;
  assign rqif.ihit = dpif.ihit;
  assign rqif.ctr_iREN = cuif.iREN;
  assign rqif.ctr_dWEN = cuif.dWEN;
  assign rqif.ctr_dREN = cuif.dREN;
  assign dpif.imemREN = rqif.imemREN;
  assign dpif.dmemREN = rqif.dmemREN;
  assign dpif.dmemWEN = rqif.dmemWEN;
  assign dpif.dmemstore = rfif.rdat2;
  assign dpif.dmemaddr = alu_output;

  assign pcif.ihit = ihit; //not used TODO:remove
  assign pcif.dhit = dhit; //not used
  assign pcif.immediate26 = cuif.immediate26;
  assign pcif.immediate = cuif.immediate;
  assign pcif.rdat1 = rfif.rdat1;
  assign pcif.pc_en = nRST & !cuif.halt & dpif.ihit & !dpif.dhit;

  assign pcif.PCSrc =  cuif.PCSrc;
  assign dpif.imemaddr = pcif.imemaddr;

  assign cuif.instruction = dpif.imemload;
  assign cuif.alu_zf = alu_zf;

  assign alu_op = cuif.ALUctr;
  assign alu_a = rfif.rdat1;

  always_comb begin : MUX_ALU_B
       if(cuif.ALUSrc == 0) begin
          alu_b = rfif.rdat2;
       end else if(cuif.ALUSrc == 1 && cuif.ALUSrc2) begin
          alu_b = cuif.shamt;
       end else if(cuif.ALUSrc == 2) begin
          alu_b = {cuif.immediate, 16'b0};
       end else if(cuif.ExtOp) begin
          alu_b = $signed(cuif.immediate);
       end else begin
          alu_b = {16'h0000, cuif.immediate};
       end
   end

  assign dpif.halt = cuif.halt; //double checked

  /*
    PIPELINE motion control
    -- make sure no instruction move forward in PIPELINE
       when stall is asserted.
    -- stall when there is a pending memory operation
  */

  assign stall = (dpif.dmemREN || dpif.dmemWEN) && (!dpif.dhit);
  always_ff @(posedge CLK, negedge nRST) begin
       ifid.WEN <= !stall;
  end
  always_ff @(posedge CLK, negedge nRST) begin
       idex.WEN <= !stall;
  end
  always_ff @(posedge CLK, negedge nRST) begin
       xmem.WEN <= !stall;
  end
  always_ff @(posedge CLK, negedge nRST) begin
       mweb.WEN <= !stall;
  end


  /*
    PIPELINE LATCHES connections
  */

  assign ifid.instruction_in = cuif.instruction;
  assign ifid.next_address_in = pcif.pc_plus_4;

  assign idex.next_address_in = pcif.pc_plus_4;
  assign idex.WB_MemToReg_in = cuif.MemToReg;
  assign idex.WB_RegWrite_in = cuif.RegWr;
  assign idex.M_Branch_in = cuif.Branch;     //TODO: Not yet Implemented
  assign idex.M_MemRead_in = cuif.MemRead;
  assign idex.M_MemWrite_in = cuif.MemWr;
  assign idex.M_RegDst_in = cuif.RegDst;
  assign idex.EX_ALUSrc = cuif.ALUSrc;
  assign idex.EX_ALUOp = cuif.ALUctr;
  assign idex.EX_RegDst = cuif.RegDst;
  assign idex.EX_ALUSrc2 = cuif.ALUSrc2;

  assign xmem.WB_MemToReg_in = idex.WB_MemToReg_out;
  assign xmem.WB_RegWrite_in = idex.WB_RegWrite_out;
  assign xmem.M_MemRead_in = idex.M_MemRead_out;
  assign xmem.M_MemRead_in = idex.M_MemRead_out;

  assign mweb.WB_RegWrite_in = xmem.WB_RegWrite_out;
  assign mweb.WB_MemToReg_in = xmem.WB_MemToReg_out;

endmodule
