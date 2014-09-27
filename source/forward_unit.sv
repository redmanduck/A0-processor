/*
  forward unit for forwarding alu result
*/

`include "forward_unit_if.vh"

module forward_unit(forward_unit_if.fwu fw_if
);

// forwardA choose right value to forward for operend A
assign fw_if.forwardA = (fw_if.regWr && fw_if.regRd) && ((fw_if.mem_rd == fw_if.ex_rs) ? 1 : ((fw_if.wb_rd == fw_if.ex_rs) ? 2 : 0));

// forwardB choose right value to forward for operend B
assign fw_if.forwardB =(!fw_if.memWr) && (fw_if.regWr && fw_if.regRd) && ((fw_if.ex_rs== fw_if.ex_rt) ? 0 : (fw_if.mem_rd == fw_if.ex_rt) ? 1 : ((fw_if.wb_rd == fw_if.ex_rt) ? 2 : 0));
//TODO: why I compare rs and rt? I may use it for avoiding forward when branch is taken

assign fw_if.forwardData = (fw_if.memWr) && ((fw_if.mem_rd == fw_if.ex_rt) ? 1 :((fw_if.wb_rd == fw_if.ex_rt) ? 1 : 0));

endmodule
