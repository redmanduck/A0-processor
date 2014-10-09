`include "cpu_types_pkg.vh"
`include "pipereg_if.vh"

import cpu_types_pkg::*;

module pl_if_id(
   input logic CLK, nRST,
   pipereg_if_id.ifid ifid
);
   word_t next_address;
   word_t instruction;
   word_t pcn;
   logic flushed;
   assign ifid.next_address_out = next_address;
   assign ifid.instruction_out = instruction;
   assign ifid.pcn_out = pcn;
   assign ifid.flushed_out = flushed;
   always_ff @(posedge CLK, negedge nRST) begin
     if (!nRST) begin
         instruction <= '0;
         next_address <= '0;
         pcn <= '0;
         flushed <= 0;
      end else if(ifid.flush) begin
         instruction <= '0;
         next_address <= '0;
         pcn <= '0;
         flushed <= 1;
      end else if (ifid.WEN == 1'b1) begin
         instruction <= ifid.instruction_in;
         pcn <= ifid.pcn_in;
         next_address <= ifid.next_address_in;
         flushed <= 0;
      end else begin
         instruction <= instruction;
         pcn <= pcn;
         flushed <= 0;
         next_address <= next_address;
      end
   end
endmodule
