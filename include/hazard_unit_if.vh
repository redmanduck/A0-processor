`ifndef HZU_IF_VH
`define HZU_IF_VH
`include "cpu_types_pkg.vh"

interface hazard_unit_if;
   logic stall_ifid, stall_xmem, stall_idex, stall_wb;
   logic flush_ifid, flush_xmem, flush_idex, flush_wb;
   logic branch, branch_neq, pc_en, is_equal, take_branch;
   logic jump;
   logic dhit;
   modport hzu(
     output stall_ifid, stall_xmem, stall_idex, stall_wb, flush_ifid, flush_xmem,
flush_idex, flush_wb, pc_en,
     input dhit, jump, branch_neq, branch, is_equal
   );
endinterface
`endif
