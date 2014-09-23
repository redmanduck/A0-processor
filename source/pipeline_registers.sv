`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

/*
# PIPELINE IF_ID REGISTER
*/

module pipeline_if_id(
   input logic CLK, nRST, WEN,
   if_id_reg_if.ifid ifid
);
   word_t next_address;
   word_t instruction;

   always_ff @(posedge CLK, negedge nRST) begin
     if (!nRST) begin
      instruction <= 1'b0;
      next_address <= 1'b0;
   end else if (WEN = 1'b1) begin
      instruction <= ifid.instruction_in;
      next_address <= ifid.next_adderss_in;
   end
endmodule

/*
#  PIPELINE EX_MEM REGISTER
*/

module pipeline_ex_mem(
   input logic CLK, nRST, WEN,
   ex_mem_reg_if.xmem xmem
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
     if (!nRST) begin
        WB_MemToReg <= '0;
        WB_RegWrite <= '0;
        M_Branch <= '0;
        M_MemRead <= '0;
        M_MemWrite <= '0;
        alu_zero <= '0;
        alu_output <= '0;
        adder_result <= '0;
        regfile_rdat2 <= '0;
        reg_instr <= '0;
     end else if (WEN = 1'b1) begin
        WB_MemToReg <= xmem.WB_MemToReg_in;
        WB_RegWrite <= xmem.WB_RegWrite_in;
        M_Branch <= xmem.M_Branch_in;
        M_MemRead <= xmem.M_MemRead_in;
        M_MemWrite <= xmem.M_MemWrite_in;
        alu_zero <= xmem.alu_zero_in;
        alu_output <= xmem.alu_output;
        adder_result <= xmem.adder_result;
        regfile_rdat2 <= xmem.regfile_rdat2;
        reg_instr <= xmem.reg_instr;
     end
   end

endmodule

/*
#  ID_EX REGISTER
#
*/

module pipeline_id_ex(
   input logic CLK, nRST, WEN
   id_ex_reg_if.idex idex
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

   //ASK ERIC WHY DO WE NEED ANOTHER MEMORY CONTROL

   always_ff @(posedge CLK, negedge nRST) begin
      if(nRST) begin
         WB_MemToReg <= idex.WB_MemToReg_in;
         WB_RegWrite <= idex.WB_RegWrite_in;
         M_Branch <= idex.M_Branch_in;
         M_MemRead <= idex.M_MemRead_in;
         M_MemWrite <= idex.M_MemWrite_in;
         EX_RegDst <= idex.EX_RegDst_in;
         EX_ALUOp <= idex.EX_ALUOp_in;
         EX_ALUSrc <= idex.EX_ALUSrc_in;
         next_address <= idex.next_address_in;
         rdat1 <= idex.rdat1_in;
         rdat2 <= idex.rdat2_in;
         sign_ext32 <= idex.sign_ext32_in;
         rt <= idex.rt_in;
         rd <= idex.rd_in;
      end else if(WEN = 1'b1) begin
         WB_MemToReg <= '0;
         WB_RegWrite <= '0;
         M_Branch <= '0;
         M_MemRead <= '0;
         M_MemWrite <= '0;
         EX_RegDst <= '0;
         EX_ALUOp <= '0;
         EX_ALUSrc <= '0;
         next_address <= '0;
         rdat1 <= '0;
         rdat2 <= '0;
         sign_ext32 <= '0;
         rt <= '0;
         rd <= '0;
      end
   end

endmodule

module pipeline_mem_wb(
  input logic CLK, nRST, WEN
  mem_wb_reg_if.mwb mwb
);

   word_t dmemload;
   word_t dmemaddr;
   always_ff @(posedge CLK, negedge nRST) begin
      if(nRST) begin
         dmemload <= '0;
         dmemaddr <= '0;
      end else if(WEN = 1'b1) begin
         dmemload <= mwb.dmemload_in;
         dmemaddr <= mwb.dmemaddr_in;
      end
   end


endmodule
