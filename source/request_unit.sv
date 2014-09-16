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
   datapath_cache_if.cache dcif,
   input ctr_iREN, //control request instruction read
   input ctr_dWEN, //control request data write
   input ctr_dREN  //control request data read
);

  import cpu_types_pkg::*;

  assign dcif.imemREN = dcif.ihit ? 0 : 1'b1; // ihit?

  always_ff @ (posedge CLK, negedge nRST) begin
    if(!nRST) begin
       dcif.dmemREN <= 0;
       dcif.dmemWEN <= 0;
    end else begin
       dcif.dmemREN <= dcif.dhit ? 0 : ctr_dREN;
       dcif.dmemWEN <= dcif.dhit ? 0 : ctr_dWEN;
    end
  end

endmodule
