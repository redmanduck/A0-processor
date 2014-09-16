/*

  Pat Sabpisal
  ssabpisa@purdue.edu

*/
`include "datapath_cache_if.vh"
`include "cpu_types_pkg.vh"

module control_unit (
   input CLK, nRST,
   control_unit_if.control cuif
);

   import cpu_types_pkg::*;

  assign cuif.opcode = dpif.imemload[31:26];
  assign cuif.rs = dpif.imemload[26:21];
  assign cuif.rt = dpif.imemload[21:16];
  assign cuif.rd = dpif.imemload[16:11];
  assign cuif.shamt = dpif.imemload[11:6];
  assign cuif.funct = dpif.imemload[6:0];
  assign cuif.immediate = dpif.imemload[16:0];

endmodule
