/*

  Pat Suppatach Sabpisal
  ssabpisa@purdue.edu

  this block is the program counter
  and its next pc logic

*/
`include "datapath_cache_if.vh"
`include "cpu_types_pkg.vh"

module program_counter (
   input CLK, nRST,
   datapath_cache_if.cache dcif
);

   import cpu_types_pkg::*;
   parameter PC_INIT = 0;

   word_t PC_next;
   word_t PC;

   //increase on ihit: otherwise
   //increase on dhit: ctr_dWEN | ctr_dREN

   always_comb begin : PC_ns_logic
    if (!dcif.halt) begin
      PC_next = PC + 4;
    end
  end

   always_ff @ (posedge CLK, negedge nRST) begin : PC_update_logic
    if(!nRST) begin
      PC <= PC_INIT;
    end else begin
      PC <= PC_next;
    end
  end
endmodule
