/*

  Pat Sabpisal
  ssabpisa@purdue.edu

  request unit

*/
`include "datapath_cache_if.vh"
`include "cpu_types_pkg.vh"
`include "ru_cu_if.vh"

module request_unit (
   input CLK, nRST,
   ru_cu_if.ru rqif
);

  import cpu_types_pkg::*;
  assign rqif.imemREN = 1'b1;

  always_ff @ (posedge CLK, negedge nRST) begin
    if(!nRST) begin
       rqif.dmemREN <= 0;
       rqif.dmemWEN <= 0;
    end else begin
       rqif.dmemREN <= rqif.dhit ? 0 : (rqif.ihit ? rqif.ctr_dREN : 0);
       rqif.dmemWEN <= rqif.dhit ? 0 : (rqif.ihit ? rqif.ctr_dWEN : 0);
    end
  end

endmodule
