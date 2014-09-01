/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  register_file_if rfif ();
  // test program
  test PROG ();
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif);
`else
  register_file DUT(
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule

program test(register_file_if.rf rfif);
   //write test program here
   initial begin
       parameter PERIOD = 10;
       //Reset
       #(PERIOD*2);
       rfif.wsel = 1'b0;
       rfif.WEN = 1'b0;
       rfif.wdat = 1'b0;
       rfif.rsel1 = 1'b0;
       rfif.rsel2 = 1'b0;

       #(PERIOD*2);
       $display("Writing to register 0");
       rfif.wsel =1'b0;
       rfif.WEN = 1'b1;
       rfif.wdat = 32'hABABABAB;

       #(PERIOD*2);
       $display("Writing to register 31");
       rfif.wsel = 1'b0;
       rfif.WEN = 1'b1;
       rfif.wdat = 32'hBABABA00;
   end
endprogram

