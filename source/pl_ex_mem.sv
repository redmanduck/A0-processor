`include "cpu_types_pkg.vh"
`include "pipereg_if.vh"

import cpu_types_pkg::*;

module pl_ex_mem(
   input logic CLK, nRST,
   pipereg_ex_mem.xmem xmem
);

   //WB control regs
   logic [1:0] WB_MemToReg;
   logic WB_RegWrite;
   //M control regs
   logic M_Branch, M_MemRead, M_MemWrite;
   logic alu_zero;
   word_t pcn;
   word_t alu_output; //output from ALU 1
   word_t adder_result; //output from adder
   word_t regfile_rdat2; //register file's rdat2
   word_t reg_instr; //this is rd OR rt
   logic halt;
   assign xmem.WB_MemToReg_out = WB_MemToReg;
   assign xmem.WB_RegWrite_out = WB_RegWrite;
   assign xmem.M_Branch_out = M_Branch;
   assign xmem.M_MemRead_out = M_MemRead;
   assign xmem.M_MemWrite_out = M_MemWrite;
   assign xmem.alu_zero_out = alu_zero;
   assign xmem.alu_output_out = alu_output;
   assign xmem.adder_result_out = adder_result;
   assign xmem.regfile_rdat2_out = regfile_rdat2;
   assign xmem.reg_instr_out = reg_instr;
   assign xmem.halt_out = halt;
   assign xmem.pcn_out = pcn;
   always_ff @(posedge CLK, negedge nRST) begin
     if (!nRST) begin //TODO: or flush
        WB_MemToReg <= '0;
        pcn <= '0;
        WB_RegWrite <= '0;
        halt <= '0;
        M_Branch <= '0;
        M_MemRead <= '0;
        M_MemWrite <= '0;
        alu_zero <= '0;
        alu_output <= '0;
        adder_result <= '0;
        regfile_rdat2 <= '0;
        reg_instr <= '0;
     end else if (xmem.flush == 1'b1) begin
        M_MemRead <= 0;
        pcn <= '0;
        M_MemWrite <= 0;
        WB_RegWrite <= '0;
        M_Branch <= '0;
        halt <= '0;
     end else if (!xmem.flush && xmem.WEN == 1'b1) begin
        WB_MemToReg <= xmem.WB_MemToReg_in;
        pcn <= xmem.pcn_in;
        WB_RegWrite <= xmem.WB_RegWrite_in;
        M_Branch <= xmem.M_Branch_in;
        M_MemRead <= xmem.M_MemRead_in;
        M_MemWrite <= xmem.M_MemWrite_in;
        halt <= xmem.halt_in;
        alu_zero <= xmem.alu_zero_in;
        alu_output <= xmem.alu_output_in;
        adder_result <= xmem.adder_result_in;
        regfile_rdat2 <= xmem.regfile_rdat2_in;
        reg_instr <= xmem.reg_instr_in;
     end //add else retain value
  end

endmodule


