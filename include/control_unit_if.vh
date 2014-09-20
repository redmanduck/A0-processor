`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH
`include "cpu_types_pkg.vh"

interface control_unit_if;
  import cpu_types_pkg::*;
  logic halt;
  //out into request unit
  logic iREN, dWEN, dREN;
  //the instruction
  word_t instruction;
  //out to somewhere
  logic [5:0] opcode, funct;
  logic [4:0] rs, rt, rd, shamt;
  logic [15:0] immediate;
  logic [25:0] immediate26;
  //request control signal
   logic alu_zf; //zero flag from alu
  //other standard magical signals
  logic [1:0] MemToReg; //write content of memory to Reg or write ALU output to reg
  logic RegWr; //when you want to write to reg
  logic MemWr; //when you want to write to memory
  logic ExtOp; //zero extended or sign extended
  aluop_t ALUctr; //select what operation the ALU will do
  logic [1:0] RegDst; //destination Reg
  logic [2:0] PCSrc; //select where the hell to increment PC from
  logic [1:0] ALUSrc; //select where ALU operand comes from
  logic MemRead;
  logic ALUSrc2; //second level mux selector to select operand from SHAMT
  logic Jump; //dont even know why thats there

  modport control (
    input instruction, alu_zf,
    output opcode, funct, rs, rd, rt, shamt, immediate, immediate26, iREN, dWEN, dREN, MemToReg, RegWr,MemWr, Jump, ExtOp, ALUctr, RegDst, PCSrc, ALUSrc, ALUSrc2, MemRead, halt
  );

  modport tb (
    output instruction, alu_zf,
    input opcode, funct, rs, rd, rt, shamt, immediate, immediate26, iREN, MemToReg, RegWr,
MemWr, Jump, ExtOp, ALUctr, RegDst, PCSrc, ALUSrc, ALUSrc2, MemRead, halt
  );

endinterface


`endif
