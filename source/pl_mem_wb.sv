`include "cpu_types_pkg.vh"
`include "pipereg_if.vh"

import cpu_types_pkg::*;

module pl_mem_wb(
  input logic CLK, nRST,
  pipereg_mem_wb.mwb mwb
);

   word_t dmemload;
   word_t alu_output;
   word_t dmemaddr;

   logic WB_RegWrite;
   logic WB_MemToReg;
   logic [4:0] reg_instr;
   logic halt;

   assign mwb.WB_RegWrite_out = WB_RegWrite;
   assign mwb.WB_MemToReg_out = WB_MemToReg;
   assign mwb.dmemload_out = dmemload;
   assign mwb.dmemaddr_out = dmemaddr;
   assign mwb.alu_output_out = alu_output;
   assign mwb.reg_instr_out = reg_instr;
   assign mwb.halt_out = halt;

   always_ff @(posedge CLK, negedge nRST) begin
      if(!nRST) begin
         dmemload <= '0;
         dmemaddr <= '0;
         WB_RegWrite <= '0;
         alu_output <= '0;
         reg_instr <= '0;
         WB_MemToReg <= '0;
         halt <= '0;
      end else if(mwb.flush == 1'b1) begin
         WB_RegWrite <= 0;
      end else if(mwb.WEN == 1'b1) begin
         dmemload <= mwb.dmemload_in;
         halt <= mwb.halt_in;
         dmemaddr <= mwb.dmemaddr_in;
         WB_RegWrite <= mwb.WB_RegWrite_in;
         WB_MemToReg <= mwb.WB_MemToReg_in;
         alu_output <= mwb.alu_output_in;
         reg_instr <= mwb.reg_instr_in;
      end
    end


endmodule
