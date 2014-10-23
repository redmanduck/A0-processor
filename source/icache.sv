`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"
`include "cache_control_if.vh"

import cpu_types_pkg::*;

module icache (
  input logic CLK, nRST,
  datapath_cache_if.icache dpif,
  cache_control_if.icache ccif
);

  parameter total_set = 16;
  parameter CPUID = 0;


  typedef struct packed{ 
    logic [25:0] tag;
    word_t data;
    logic valid ;   //1 bit>?
  } CacheTable;
  
  CacheTable [total_set - 1:0] dtable;

  typedef enum logic [1:0] {reset, idle, fetch} StateType;

  StateType state, next_state;

  logic [25:0] rq_tag;
  logic [3:0] rq_index;

  //requested index and tag
  assign rq_index = dpif.imemaddr[5:2];
  assign rq_tag = dpif.imemaddr[31:6];

  //set ihit if there is a hit
  assign dpif.ihit = (rq_tag == dtable[rq_index].tag) && dtable[rq_index].valid ? 1 : 0;
  //set output data
  assign dpif.imemload = dtable[rq_index].data;  
  //read from memory when read request is on, and stop reading when ihit is asserted
  assign ccif.iREN[CPUID] = !dpif.ihit && dpif.imemREN; 
  //set address output
  assign ccif.iaddr[CPUID] = dpif.imemaddr; 




  always_ff @ (posedge CLK, negedge nRST) begin : ICACHE
    if(!nRST) begin
      //initially clear the table
        dtable <= '0;
    end else begin
     casez(state)
       fetch: begin
            dtable[rq_index].tag = rq_tag;
            dtable[rq_index].valid = 1;
            dtable[rq_index].data = ccif.iload[CPUID];
       end 
       default: begin
          //dont do stuff
       end
     endcase
    end
  end


  // //## is the (above) or below better? should we have a reset state?
  // always_comb begin : proc_do_fetch
  //   casez(state) 
  //     reset: begin
  //           dtable = '0;
  //     end
  //     fetch: begin 
  //           dtable[rq_index].tag = rq_tag;
  //           dtable[rq_index].valid = 1;
  //           dtable[rq_index].data = ccif.iload[CPUID];
  //     end
  //     default: begin
  //           //dont do anything
  //     end
  //   endcase
  // end

  always_comb begin : next_state_logic
     //start from idle
     next_state = idle;
     if(state == fetch && ccif.iwait) begin
        //if in fetch, go to itself if waiting (otherwise go to idle)
        next_state = fetch;
     end else if(state == idle && !dpif.ihit && dpif.imemREN)  begin
        //if in idle, go to fetch if data request is up and has not arrived yet
        next_state = fetch;
     end else begin
        next_state = idle;
     end
  end

  always_ff @ (posedge CLK, negedge nRST) begin
    if(!nRST) begin
        state <= idle;
    end else begin
        state <= next_state;
   end
  end

endmodule
