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

  modport ru (
     output imemREN, dmemREN, dmemWEN,
     input dhit, ihit, ctr_iREN, ctr_dWEN, ctr_dREN
  );

endinterface

`endif
