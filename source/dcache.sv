`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"
`include "cache_control_if.vh"

import cpu_types_pkg::*;

module icache (
  input logic CLK, nRST,
  datapath_cache_if.dcache dpif,
  cache_control_if.dcache ccif
);

  parameter total_set = 8;
  parameter CPUID = 0;

  typedef struct packed{ 

    logic [5:0] index;
    logic [25:0] tag1, tag2;
    word_t [1:0] block1, block2;
    logic valid1, valid2, dirty1, dirty2;    
  } TwoWayTable;
  
  TwoWayTable [total_set - 1:0] dtable;

  typedef enum logic [1:2] {idle, fetch} StateType;

  StateType state, next_state;

  logic [25:0] rq_tag;
  logic [3:0] rq_index;
  
  //requested index and tag
  assign rq_index = dpif.imemaddr[5:2];
  assign rq_tag = dpif.imemaddr[31:6];

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
