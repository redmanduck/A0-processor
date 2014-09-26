/*
   Hazard Unit
*/
`include "hazard_unit_if.vh"

module hazard_unit(
   hazard_unit_if.hzu hzif
);

  always_comb begin
     hzif.stall_ifid = 0;
     hzif.stall_idex = 0;
     hzif.stall_xmem = 0;
     hzif.stall_wb = 0;
     hzif.flush_ifid = 0;
     hzif.flush_idex = 0;
     hzif.pc_en = 1;

    if(hzif.branch) begin
       //FIRST BRANCH
       hzif.flush_ifid = 1;
       hzif.pc_en = 0;
       hzif.flush_idex = 1;
       hzif.stall_idex = 1;
     end
  end

endmodule
