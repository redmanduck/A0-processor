`ifndef PIPEREGX_VH
`define PIPEREGX_VH

// ram memory types
`include "cpu_types_pkg.vh"

interface pipereg_id_ex;
   import cpu_types_pkg::*;

   logic WEN; //do WEN
   logic flush; //do NOP
   logic WB_MemToReg_in, WB_RegWrite_in, M_Branch_in, M_MemRead_in, M_MemWrite_in, EX_RegDst_in, EX_ALUOp_in, EX_ALUSrc_in;
   logic WB_MemToReg_out, WB_RegWrite_out, M_Branch_out, M_MemRead_out, M_MemWrite_out, EX_RegDst_out, EX_ALUOp_out, EX_ALUSrc_out;

   word_t next_address_in, next_address_out;
   word_t rdat1_in, rdat1_out;
   word_t rdat2_in, rdat2_out;
   word_t sign_ext32_in, sign_ext32_out;
   word_t rt_in, rt_out;
   word_t rd_in, rd_out;


  modport idex(
     input WEN, flush, WB_MemToReg_in, WB_RegWrite_in, M_Branch_in, M_MemRead_in, M_MemWrite_in, EX_RegDst_in, EX_ALUOp_in, EX_ALUSrc_in, next_address_in, rdat1_in, rdat2_in, sign_ext32_in, rt_in, rd_in,
     output WB_MemToReg_out, WB_RegWrite_out, M_Branch_out, M_MemRead_out, M_MemWrite_out, EX_RegDst_out, EX_ALUOp_out, EX_ALUSrc_out, next_address_out, rdat1_out, rdat2_out, sign_ext32_out, rt_out, rd_out
  );
endinterface


interface pipereg_if_id;
   import cpu_types_pkg::*;

   logic WEN; 
   logic flush;
   word_t next_address_out, instruction_out, next_address_in, instruction_in;

  modport ifid(
     input WEN, flush, next_address_in, instruction_in, 
     output next_address_out, instruction_out
  );
endinterface


interface pipeline_ex_mem;
   import cpu_types_pkg::*;

   logic WEN; 
   logic flush;
   word_t WB_MemToReg_in, WB_RegWrite_in, M_Branch_in, M_MemRead_in, M_MemWrite_in;
   word_t WB_MemToReg_out, WB_RegWrite_out, M_Branch_out, M_MemRead_out, M_MemWrite_out;
   logic alu_zero_in, alu_zero_out;
   logic alu_output_in, alu_output_out;
   logic adder_result_in, adder_result_out, regfile_rdat2_in, regfile_rdat2_out, reg_instr_in, reg_instr_out;

  modport xmem (
     input WEN, flush, WB_MemToReg_in, WB_RegWrite_in, M_Branch_in, M_MemRead_in, M_MemWrite_in, alu_zero_in, alu_output_in, adder_result_in, regfile_rdat2_in, reg_instr_in,
     output WB_MemToReg_out, WB_RegWrite_out, M_Branch_out, M_MemRead_out, M_MemWrite_out, alu_zero_out, alu_output_out, adder_result_out, regfile_rdat2_out, reg_instr_out
  );
endinterface


`endif