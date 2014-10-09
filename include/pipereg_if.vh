`ifndef PIPEREGX_VH
`define PIPEREGX_VH

// ram memory types
`include "cpu_types_pkg.vh"

interface pipereg_id_ex;
   import cpu_types_pkg::*;
   logic halt_in, halt_out;
   logic WEN; //do WEN
   logic M_Jump_out, M_Jump_in;
   logic flush; //do NOP
   logic WB_RegWrite_in, M_Branch_in, M_MemRead_in, M_MemWrite_in;
   logic [1:0] EX_RegDst_in;
   logic [1:0] EX_ALUSrc_in, EX_ALUSrc_out;
   logic WB_RegWrite_out, M_Branch_out, M_MemRead_out, M_MemWrite_out;
   logic [1:0] EX_RegDst_out, WB_MemToReg_in, WB_MemToReg_out;
   aluop_t EX_ALUOp_in, EX_ALUOp_out;
   word_t next_address_in, next_address_out;
   word_t rdat1_in, rdat1_out;
   word_t rdat2_in, rdat2_out;
   word_t sign_ext32_in, sign_ext32_out;
   logic [4:0] rs_in , rs_out;
   logic [4:0] rt_in, rt_out;
   logic [4:0] rd_in, rd_out;
   logic [4:0] shamt_in, shamt_out;
   logic EX_ALUSrc2_in, EX_ALUSrc2_out;
   logic [25:0] immediate26_in, immediate26_out;
   word_t immediate_in, immediate_out; //extended immediate
   word_t pcn_out, pcn_in;
   logic bubble_in, bubble_out;

  modport idex(
     input WEN, rs_in, pcn_in, flush, WB_MemToReg_in, immediate26_in,immediate_in, M_Jump_in,
     shamt_in, EX_ALUSrc2_in, WB_RegWrite_in, M_Branch_in, M_MemRead_in, bubble_in,
     M_MemWrite_in, EX_RegDst_in, EX_ALUOp_in, EX_ALUSrc_in, next_address_in,
     rdat1_in, rdat2_in, sign_ext32_in, rt_in, rd_in, halt_in,
     output WB_MemToReg_out, pcn_out, rs_out, WB_RegWrite_out, immediate26_out,immediate_out,
     shamt_out, EX_ALUSrc2_out, M_Branch_out, M_MemRead_out, M_MemWrite_out, M_Jump_out,
     EX_RegDst_out, EX_ALUOp_out, EX_ALUSrc_out, next_address_out, rdat1_out, bubble_out,
     rdat2_out, sign_ext32_out, rt_out, rd_out, halt_out
  );
endinterface


interface pipereg_if_id;
   import cpu_types_pkg::*;

   logic WEN;
   logic flush;
   logic flushed_out, flushed_in;
   word_t next_address_out, instruction_out, next_address_in, instruction_in;
   word_t pcn_out, pcn_in;

  modport ifid(
     input pcn_in, WEN, flush, next_address_in, instruction_in,flushed_in ,
     output pcn_out, next_address_out, instruction_out, flushed_out
  );
endinterface


interface pipereg_ex_mem;
   import cpu_types_pkg::*;

   logic WEN;
   logic flush;
   logic  WB_RegWrite_in, M_Branch_in, M_MemRead_in, M_MemWrite_in;
   logic  WB_RegWrite_out, M_Branch_out, M_MemRead_out, M_MemWrite_out;
   logic alu_zero_in, alu_zero_out;
   logic halt_in, halt_out;
   logic [1:0] WB_MemToReg_in, WB_MemToReg_out;
   word_t pcn_in, pcn_out;
   word_t alu_output_in, alu_output_out;
   word_t adder_result_in, adder_result_out;

   word_t regfile_rdat2_in, regfile_rdat2_out;

   logic [4:0] reg_instr_in, reg_instr_out;

  modport xmem (
     input WEN, flush, pcn_in, WB_MemToReg_in, WB_RegWrite_in, M_Branch_in,
     M_MemRead_in, M_MemWrite_in, alu_zero_in, alu_output_in, halt_in,
     adder_result_in, regfile_rdat2_in, reg_instr_in,
     output WB_MemToReg_out, pcn_out, WB_RegWrite_out, M_Branch_out,
     M_MemRead_out, M_MemWrite_out, alu_zero_out, alu_output_out,
     adder_result_out, regfile_rdat2_out, reg_instr_out, halt_out
  );
endinterface


interface pipereg_mem_wb;
  import cpu_types_pkg::*;

  logic halt_in, halt_out;

  logic [1:0] WB_MemToReg_in, WB_MemToReg_out;
  logic WEN, flush;
  word_t dmemload_in, dmemload_out, dmemaddr_in, dmemaddr_out;
  logic WB_RegWrite_in, WB_RegWrite_out;
  word_t pcn_out, pcn_in;
  logic [4:0] reg_instr_in, reg_instr_out;
  logic M_MemRead_in, M_MemRead_out;
   word_t alu_output_in, alu_output_out;
  //reg_instr IS THE REGISTER DESTINATION
  modport mwb(
    input WEN, flush, pcn_in, dmemload_in, dmemaddr_in,
    WB_RegWrite_in, WB_MemToReg_in, alu_output_in, reg_instr_in, halt_in, M_MemRead_in,
    output WB_RegWrite_out, pcn_out, alu_output_out, halt_out,
    WB_MemToReg_out, dmemload_out, dmemaddr_out, reg_instr_out, M_MemRead_out
  );
endinterface

`endif
