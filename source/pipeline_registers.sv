`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

/*
# PIPELINE IF_ID REGISTER
*/

module pipeline_if_id(
   input logic CLK, nRST, WEN
);
   word_t next_address;
   word_t instruction;

   always_ff @(posedge CLK, negedge nRST) begin
      instruction <= 1'b0;
      next_address <= 1'b0;
   end else if (WEN = 1'b1) begin
      instruction <= plif.instruction_in;
      next_address <= plif.next_adderss_in;
   end
endmodule

/*
#  PIPELINE EX_MEM REGISTER
*/

module pipeline_ex_mem(
   input logic CLK, nRST, WEN
);

   //WB control regs
   reg WB_MemToReg, WB_RegWrite;
   //M control regs
   reg M_Branch, M_MemRead, M_MemWrite;
   reg alu_zero;

   word_t alu_output; //output from ALU 1
   word_t adder_result; //output from adder
   word_t regfile_rdat2; //register file's rdat2
   word_t reg_instr; //this is rd OR rt

   always_ff @(posedge CLK, negedge nRST) begin
      WB_MemToReg <= '0;
      WB_RegWrite <= '0;
      M_Branch <= '0;
      M_MemRead <= '0;
      M_MemWrite <= '0;
      alu_zero <= '0;
   end else if (WEN = 1'b1) begin
      WB_MemToReg <= plif.WB_MemToReg_in;
      WB_RegWrite <= plif.WB_RegWrite_in;
      M_Branch <= plif.M_Branch_in;
      M_MemRead <= plif.M_MemRead_in;
      M_MemWrite <= plif.M_MemWrite_in;
      alu_zero <= plif.alu_zero_in;
   end

endmodule

/*
#  ID_EX REGISTER
#
*/

module pipeline_id_ex(
   input logic CLK, nRST, WEN

);
   //WB control regs
   reg WB_MemToReg, WB_RegWrite;

   //MEM control regs (TODO: jump?)
   reg M_Branch, M_MemRead, M_MemWrite;

   //EX control signals
   reg EX_RegDst, EX_ALUOp, EX_ALUSrc;

   word_t next_address;
   word_t rdat1;
   word_t rdat2;
   word_t sign_ext32;
   word_t rt;
   word_t rd;

   always_ff @(posedge CLK, negedge nRST) begin

   end else if(WEN = 1'b1) begin

   end

endmodule

module pipeline_mem_wb(
   input logic CLK, nRST, WEN
);

   word_t _dmemload;
   word_t _dmemaddr;

endmodule
