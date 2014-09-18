/*
  Pat Sabpisal
  ssabpisa@purdue.edu
*/

`ifndef RUCUIFVH
`define RUCUIFVH

`include "cpu_types_pkg.vh"

interface ru_cu_if;

  import cpu_types_pkg::*;

  logic imemREN, dmemREN, dmemWEN;
  logic dhit, ihit;

  logic ctr_iREN, ctr_dWEN, ctr_dREN;


  //output to cache
  //input to datapath (controller)
  modport ru (
     input dhit, ihit, ctr_iREN, ctr_dWEN, ctr_dREN,
     output imemREN, dmemREN, dmemWEN
  );

endinterface

`endif
