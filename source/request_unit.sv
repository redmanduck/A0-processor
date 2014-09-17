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
   input ctr_iREN, //TODO: needed?? since imemREN is always based on ihit
   input ctr_dWEN, //control request data write goes to? //control request instruction read goes to MemWR
   input ctr_dREN  //control request data read goes to ?
);

  import cpu_types_pkg::*;

  //imemREN is not dependent on iHIT?
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
