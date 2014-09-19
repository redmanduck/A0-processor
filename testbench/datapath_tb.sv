`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"

`timescale 1 ns / 1 ns

import cpu_types_pkg::*;

module datapath_tb;
  logic CLK = 0;
  logic nRST;
  logic ihit = 0;

  parameter PERIOD = 10;
  always #(PERIOD/2) CLK++;

  datapath_cache_if dpif();
  datapath DUT(CLK, nRST, dpif);

  always #(PERIOD) ihit++;
  assign dpif.ihit = ihit;
  logic [4:0] rs, rt, rd;
  logic [15:0] imm16;

  initial begin
    nRST = 0;
    #(PERIOD);
    nRST = 1;
    imm16 = 16'b0;
    rs = 0;
    rt = 0;
    rd = 0;
    #(PERIOD);
    rs = 0;
    rt = 10;
    imm16 = 16'b11;
    #(PERIOD);
    dpif.imemload = {ADDIU, rs, rt, imm16};

    #(PERIOD);
    rs = 0;
    rt = 1;
    imm16 = 16'b0100;
    #(PERIOD);
    dpif.imemload = {ADDIU, rs, rt, imm16};

    #(PERIOD*2);
    rs = 10;
    rt = 1;
    rd = 9;
    imm16 = 0; //dont care
    #(PERIOD*10);
    //TODO: Below instruction will break everything
    // dpif.imemload = {RTYPE, rs, rt, rd, 5'h0, ADD};
     dpif.imemload = {RTYPE, rs, rt, rd, 5'h0, ADD};

   #(PERIOD*2);
    rs = 9;
    rt = 9;
    rd = 0;
    imm16 = 0; //dont care
    #(PERIOD*10);
     dpif.imemload = {SW, rs, rt, imm16};

    #(PERIOD*10);
    $finish;
  end

endmodule
