`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"
`include "cache_control_if.vh"

import cpu_types_pkg::*;

module dcache (
  input logic CLK, nRST,
  datapath_cache_if.dcache dpif,
  cache_control_if.dcache ccif
);

  parameter total_set = 8;
  parameter way_count = 2;
  parameter CPUID = 0;
   
  typedef struct packed{ 
    logic [25:0] tag;
    word_t [1:0] block;
    logic valid;
    logic dirty;
  } CacheRow;

  typedef struct packed{
    CacheRow [total_set - 1 : 0] dtable;
  } CacheWay;

  logic [total_set - 1 : 0] LRU;
  CacheWay [1:0] cway;

  typedef enum logic [4:0] {idle, evict, fetch1, fetch2, fetch_done, wb1, wb2, reset, write_table, all_fetch_done, flush} StateType;


  StateType state, next_state;

  logic [25:0] rq_tag;
  logic [3:0] rq_index;
  logic hit_out, hit0, hit1;
  logic tag_match0, tag_match1; 
  logic cur_lru, rq_blockoffset;
  //current LRU based on index
  assign cur_lru = LRU[rq_index];
  //requested index and tag
  assign rq_index = dpif.dmemaddr[5:2];
  assign rq_tag = dpif.dmemaddr[31:6];
  assign rq_blockoffset = dpif.dmemaddr[2];

  assign ccif.daddr = dpif.dmemaddr;

  assign tag_match0 = (rq_tag == cway[0].dtable[rq_index].tag); 
  assign tag_match1 = (rq_tag == cway[1].dtable[rq_index].tag); 

  assign hit0 = (rq_tag == cway[0].dtable[rq_index].tag) && (cway[0].dtable[rq_index].valid);
  assign hit1 = (rq_tag == cway[1].dtable[rq_index].tag) && (cway[1].dtable[rq_index].valid);
  assign hit_out = hit0 | hit1;

  assign dpif.dmemload = (hit0 ? cway[0].dtable[rq_index].block[rq_blockoffset] : (hit1 ? cway[1].dtable[rq_index].block[rq_blockoffset] : 32'hbadbeef1 )); //or bad1bad1

  always_comb begin : next_state_logic_fsm
     //start from idle
     next_state = idle;
     if(state == idle) begin
        if (dpif.halt) begin
            next_state = flush;
        end if(hit_out && dpif.dmemREN) begin
            //want to read and its in the table, so we just read it
            next_state = idle;
        end else if(!hit_out && dpif.dmemWEN) begin
            //want to write, but its not in the table so we need to fetch it
            next_state = evict; //evict will check whether data need to be saved first
        end else if(cway[0].dtable[rq_index].valid && cway[1].dtable[rq_index].valid) begin
            //otherwise we just fetch
            next_state = fetch1;
        end
     end else if(state == evict) begin

        if(cway[cur_lru].dtable[rq_index].dirty) begin
            next_state = wb1;
        end else begin
            next_state = wb2;
        end

     end else if(state == fetch_done) begin
        next_state = idle;

     end else if(state == fetch1) begin
        next_state = fetch2;

     end else if(state == fetch2) begin

        //set dirty bit to te table if we write
        if(dpif.dmemWEN) begin
            next_state = write_table;
        end else begin
          //otherwise we are good non dirty people
            next_state = all_fetch_done;
        end

     end else if(state == write_table) begin
        next_state = all_fetch_done;

     end else if(state == all_fetch_done) begin
        next_state = idle;

     end else if(state == wb1) begin
        if(ccif.dwait) begin
            next_state = wb1;
        end else begin
            next_state = wb2;
        end

     end else if(state == wb2) begin
        if(ccif.dwait) begin
            next_state = wb2;
        end else begin
            next_state = fetch1;
        end

     end else if(state == reset) begin
        next_state = idle;
     end 
  end

  always_comb begin : output_logic_fsm

    casez(state) 
      reset: begin
        //reset both ways
        cway[0].dtable = '0;
        cway[1].dtable = '0;
        LRU = '0;
      end
      flush: begin
          //we evict every dirty bitsh from the house (CACHE)
          $display("FLUSHING (not implemented yet, bits)");
      end
      idle: begin 
            //dont do anything
      end
      evict: begin
            //choose dirtiness
      end
      fetch1: begin
          ccif.dREN = 1;
          cway[cur_lru].dtable[rq_index].block[0] = ccif.dload[CPUID];
          cway[cur_lru].dtable[rq_index].valid = 1;
          cway[cur_lru].dtable[rq_index].dirty = 0;

      end
      fetch2: begin
          ccif.dREN = 1;
          cway[cur_lru].dtable[rq_index].block[1] = ccif.dload[CPUID];
          cway[cur_lru].dtable[rq_index].dirty = 0;
      end
      write_table: begin
          //after the two words are fetch into our target block
          //we update the table if dmemWEN is enabled and set dirtybits //dpif.dmemstore
          cway[cur_lru].dtable[rq_index].block[rq_blockoffset] = dpif.dmemstore;
          cway[cur_lru].dtable[rq_index].dirty = 1;
          cway[cur_lru].dtable[rq_index].valid = 1;
      end
      all_fetch_done: begin
          //flip
          LRU[rq_index] = !LRU[rq_index];
      end
      wb1: begin
          //writeback data in table to RAM
          ccif.dWEN = 1;
          ccif.dstore[CPUID] = cway[(hit0 ? 1 : 0)].dtable[rq_index].block[0];
      end
      wb2: begin
          ccif.dWEN = 1;
          ccif.dstore[CPUID] = cway[(hit0 ? 1 : 0)].dtable[rq_index].block[1];
      end
      default: begin
            //dont do anything
            ccif.dREN = 0;
            ccif.dWEN = 0;
      end
    endcase
  end

  always_ff @ (posedge CLK, negedge nRST) begin : ff_fsm
    if(!nRST) begin
        state <= reset;
    end else begin
        state <= next_state;
   end
  end

endmodule
