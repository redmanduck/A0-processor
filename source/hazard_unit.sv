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

     hzif.flush_ifid = hzif.dhit;
     hzif.flush_idex = 0;
     hzif.flush_xmem = 0;
     hzif.flush_wb = 0;

     hzif.pc_en = !hzif.dhit;

     if((hzif.branch && hzif.is_equal) || (hzif.branch_neq && !hzif.is_equal)) begin
        hzif.flush_ifid = 1;
        hzif.pc_en = 1;
     end else if(hzif.jump) begin
      // hzif.pc_en = 0;
        hzif.flush_ifid = 1;
     end else if(hzif.idex_rs == hzif.mwb_rd && (hzif.idex_rs && hzif.mwb_rd)) begin
       // hzif.pc_en = 0;
        hzif.stall_ifid = 1;
     end
  end


//  assign hzif.flush_ifid = (hzif.jump || (hzif.branch && hzif.is_equal) || (hzif.branch_neq && !hzif.is_equal)) ? 1 : hzif.dhit;

  //TODO: handle case where SW occur
endmodule
