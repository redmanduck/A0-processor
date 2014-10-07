`ifndef FW_IF_VH
`define FW_IF_VH
`include "cpu_types_pkg.vh"

interface forward_unit_if;
  logic [4:0] ex_rs, ex_rt, ex_rd;
  logic [4:0] mem_rd, wb_rd;
  logic [4:0] id_rs, id_rt;
  logic regWr, regRd; // reg write an read
  logic memRegWr, exRegWr,exMemWr, wbRegWr; //XMEM_regwrite
  logic forwardData;  // sig to choose data to write to mem
  logic [2:0] forwardR2, forwardR1;
  logic [1:0] ex_RegDst;
  logic memWr;  // mem write enable signal
  /* forwardA is the control signal choose which operand to feed in
  for alu operand A
   */
  logic [1:0] forwardA;
  /* forwardB is the control signal choose which operand to feed in
  for alu operand B
   */
  logic [1:0] forwardB;

  modport fwu(
    input ex_RegDst, ex_rs, ex_rt,ex_rd, mem_rd, wb_rd, regWr, regRd, memWr, id_rt, id_rs,memRegWr,exRegWr,exMemWr,wbRegWr,
    output forwardA, forwardB, forwardData,forwardR2,forwardR1
  );
endinterface
`endif


