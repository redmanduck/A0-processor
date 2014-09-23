`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module pl_mem_wb(
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
