ifndef HZU_IF_VH
`define HZU_IF_VH
`include "cpu_types_pkg.vh"

interface hazard_unit_if;
   logic stall_ifid, stall_xmem, stall_idex, stall_wb;
   logic wen_ifid, wen_xmem, wen_idex, wen_wb;
   modport hzu(
     output stall_ifid, stall_xmem, stall_idex, stall_wb
   );
endinterface
