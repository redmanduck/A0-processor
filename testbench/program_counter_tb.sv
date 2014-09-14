`include "datapath_cache_if.vh"

`include "cpu_ram_if.vh"
`timescale 1 ns / 1 ns

import cpu_types_pkg::*;

module program_counter_tb;

  datapath_cache_if dcif();
  assign dcif.halt = 0;

  logic CLK = 0;
  logic nRST;
  parameter PERIOD = 10;
  parameter ADDR_MAX = 40;

  program_counter DUT(CLK, nRST, dcif);

  always #(PERIOD/2) CLK++;

  initial begin
   nRST = 1'b0;
   #(PERIOD);
   nRST = 1'b1;
   #(PERIOD*10);
   $finish;
  end

endmodule
