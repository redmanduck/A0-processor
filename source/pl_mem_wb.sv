`include "cpu_types_pkg.vh"
`include "pipereg_if.vh"

import cpu_types_pkg::*;

module pl_mem_wb(
  input logic CLK, nRST,
  pipereg_mem_wb.mwb mwb
);

   word_t dmemload;
   word_t dmemaddr;
   logic WB_RegWrite;
   logic WB_MemToReg;

   assign mwb.WB_RegWrite_out = WB_RegWrite;
   assign mwb.WB_MemToReg_out = WB_MemToReg;
   assign mwb.dmemload_out = dmemload;
   assign mwb.dmemaddr_out = dmemload;

   always_ff @(posedge CLK, negedge nRST) begin
      if(!nRST) begin
         dmemload <= '0;
         dmemaddr <= '0;
         WB_RegWrite <= '0;
         WB_MemToReg <= '0;
      end else if(mwb.flush == 1'b1) begin
         WB_RegWrite <= 0;
      end else if(mwb.WEN == 1'b1) begin
         dmemload <= mwb.dmemload_in;
         dmemaddr <= mwb.dmemaddr_in;
         WB_RegWrite <= mwb.WB_RegWrite_in;
         WB_MemToReg <= mwb.WB_MemToReg_in;
      end
    end


endmodule
