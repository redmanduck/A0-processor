/*
  Pat Sabpisal
  ssabpisa@purdue.edu
*/

`ifndef RUCUIFVH
`define RUCUIFVH

`include "cpu_types_pkg.vh"

interface ru_cu_if;

  import cpu_types_pkg::*;

  //from control unit to request unit
  logic load_word_en; //assert this to request
  logic store_word_en; //assert this to request

  //from request unit to cache
  logic dhit, ihit;

  modport ru (
     input load_word_en, store_word_en,
     output dhit, ihit
  );

endinterface

`endif
