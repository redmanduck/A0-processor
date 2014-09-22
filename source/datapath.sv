/*
  Pat Sabpisal
  pat@uniduck.co

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"
`include "control_unit_if.vh"
`include "register_file_if.vh"
`include "ru_cu_if.vh"
`include "pc_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;
  parameter PC_INIT = 0;
  logic megatron;
  assign megatron = CLK;
  control_unit_if cuif();
  register_file_if rfif();
  ru_cu_if rqif();
  pc_if pcif();

  //ALU logics
  aluop_t alu_op;
  word_t alu_a;
  word_t alu_b;
  logic alu_nf;
  logic alu_vf;
  word_t alu_output;
  logic alu_zf;

  logic ihit;
  logic dhit;
  //sub-blocks
  control_unit CU(CLK, nRST, cuif);

  register_file RF(CLK, nRST, rfif);

  program_counter PC(CLK, nRST, pcif);

  alu ALU(.ALUOP(alu_op), .Port_A(alu_a), .Port_B(alu_b), .negative(alu_nf), .overflow(alu_vf), .output_port(alu_output), .zero(alu_zf));

  request_unit RUCU(CLK, nRST, rqif);

  //connect

  assign rfif.rsel1 = cuif.rs;
  assign rfif.rsel2 = cuif.rt;
  assign rfif.WEN = cuif.RegWr;

  //assign rfif.wdat = (cuif.MemToReg ? dpif.dmemload : alu_output);
  always_comb begin : RFIF_WRITE
    casez (cuif.MemToReg)
      1: rfif.wdat = dpif.dmemload;
      2: rfif.wdat = dpif.imemaddr + 4;
      default: rfif.wdat = alu_output;
    endcase
  end
  //assign rfif.wsel = (cuif.RegDst ? cuif.rd : cuif.rt );
  always_comb begin : MUX_RGDST
    casez (cuif.RegDst)
      1: rfif.wsel = cuif.rd;
      2: rfif.wsel = 31;
      default: rfif.wsel = cuif.rt;
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
  //assign pcif.pc_en = (cuif.ihit ? (!cuif.halt) : (cuif.dWEN || cuif.dREN ? dpif.dhit : 0));
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

endmodule
