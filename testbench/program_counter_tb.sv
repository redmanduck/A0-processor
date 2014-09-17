`include "control_unit_if.vh"
`include "register_file_if.vh"
`include "cpu_ram_if.vh"
`include "cpu_types_pkg.vh"

`timescale 1 ns / 1 ns

import cpu_types_pkg::*;

module program_counter_tb;
  register_file_if rfif();
  control_unit_if cuif();

  logic CLK = 0;
  logic nRST, ihit, dhit;
  parameter PERIOD = 10;
  parameter ADDR_MAX = 40;

  register_file RFDUT(CLK, nRST, rfif);
  program_counter DUT(CLK, nRST, cuif, rfif, ihit, dhit);
  control_unit CUDUT(CLK, nRST, cuif);

  always #(PERIOD/2) CLK++;

  initial begin
   cuif.pc_en = 0;
   #(PERIOD);
   cuif.pc_en = 1;
   cuif.instruction = 32'b0;
   ihit = 0;
   dhit = 0;
   nRST = 1'b0;
   #(PERIOD);
   nRST = 1'b1;
   #(PERIOD*5);
   cuif.instruction = {RTYPE, 5'b0, 5'b1, 5'hA, 5'h0, SUB};
   #(PERIOD);
   cuif.instruction = {RTYPE, 5'hC, 5'h9, 5'hF, 5'h0, ADD};
   #(PERIOD);
   cuif.instruction = {JAL, 26'hABCD};
   #(PERIOD*100);
   $finish;
  end

endmodule
