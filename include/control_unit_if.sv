`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH
`include "cpu_types_pkg.vh"

interface control_unit_if;
  import cpu_types_pkg::*;

  //out into request unit
  logic iREN, dWEN, dREN;
  //the instruction
  word_t instr;
  //out to somewhere
  logic [5:0] opcode, funct;
  logic [4:0] rs, rt, rd, shamt;
  logic [16:0] immediate;
  //request control signal
  logic iREN, dWEN, dREN;

  //other standard magical signals
  logic MemToReg; //what is the size??
  logic RegWr; //when you want to write to reg
  logic MemWr; //when you want to write to memory
  logic ExtOp; //zero extended or sign extended
  aluop_t ALUctr;
  logic RegDst; //destination Reg (* what is the size ??)
  logic PCSrc; //when you want to modify the PC
  logic ALUSrc; //?

  modport control (
    input instr,
    output opcode, funct, rs, rd, rt, shamt, immediate, iREN, dWEN, dREN, MemToReg, RegWr,
MemWr, ExtOp, ALUctr, RegDst, PCSrc, ALUSrc
  );

endinterface


`endif
