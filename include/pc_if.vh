/*
  Pat Sabpisal
  ssabpisa@purdue.edu
*/

`ifndef PCIFVH
`define PCIFVH

`include "cpu_types_pkg.vh"

interface pc_if;

  import cpu_types_pkg::*;

  logic ihit, dhit, pc_en;
  logic [2:0] PCSrc;
  word_t rdat1;
  logic [25:0] immediate26;
  logic [15:0] immediate;
  word_t imemaddr;
  word_t pc_plus_4;

  modport pc(
    input ihit, dhit, immediate, immediate26, rdat1, pc_en, PCSrc,
    output imemaddr, pc_plus_4
  );

endinterface

`endif
