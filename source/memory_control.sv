/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 2;


 /*
    ccif <- dREN = cache data read enable
    ccif <-  dWEN = cache data write enable
    ccif <- iREN = cache instruction read enable
    ccif <- dstore = cache data store ??
    ccif <- iaddr = cache instruction address
    ccif <- daddr = data instruction address

    ccif <- ramload = ram load
    ccif <- ramstate = ram state
    ...
*/
always_comb begin //cache control operations
    casez(ccif.ramstate)
      FREE: begin
        //the memory is free for both I and D
        ccif.iwait = 1'b0;
        ccif.dwait = 1'b0o;
      end
      ACCESS: begin
        // memory is begin accessed
        // data is prioritized
        // if data is begin read or written
        // Instruction Fetch will wait

        ccif.iwait = ccif.dREN | ccif.dWEN;
      end
      BUSY: begin
        //memory is being read
        ccif.iwait = 1'b1;
        ccif.dwait = 1'b1;
      end
      ERROR: begin
        //block all operations
        ccif.iwait = 1'b1;
        ccif.dwait = 1'b1;
      end
      default: begin
        ccif.iwait = 1'b0;
        ccif.dwait = 1'b0;
      end
   endcase
end

always_comb begin //RAM control operations
    ccif.ramREN = 1'b0;
    ccif.ramaddr = 32'b0;
    if(ccif.dREN) begin
      //if cache wants to read from RAM
      ccif.ramREN = 1'b1;
      ccif.ramaddr = ccif.daddr;
    end else if (ccif.dWEN) begin
      ccif.ramWEN = 1'b1;
      ccif.ramaddr = ccif.daddr;
    end else if (ccif.iREN) begin
      ccif.ramREN = 1'b1;
      ccif.ramaddr = ccif.daddr;
    end
end

endmodule
