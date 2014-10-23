 `include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"

`timescale 1 ns / 1 ns

import cpu_types_pkg::*;

module pipeline_registers_tb;
  logic CLK = 0;
  logic nRST = 1;

  pipeline_ex_mem EX_MEM(CLK, nRST);
  pipeline_id_ex ID_EX(CLK,nRST);

  initial begin
    $display("hello world");
  end
endmodule

