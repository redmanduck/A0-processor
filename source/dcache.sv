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

  typedef enum logic [4:0] {idle, evict, fetch1, fetch2, fetch_done, wb1, wb2, reset,  all_fetch_done, flush} StateType;


  StateType state, next_state;

  logic [25:0] rq_tag;
  logic [3:0] rq_index;
  logic hit_out, hit0, hit1;
  logic tag_match0, tag_match1;
  logic cur_lru, rq_blockoffset;


  logic which_word, write_dirty, write_valid, CACHE_WEN;
  word_t write_data;
  logic [25:0] write_tag;

  //current LRU based on index
  assign cur_lru = LRU[rq_index];
  //requested index and tag
  assign rq_index = dpif.dmemaddr[5:3];
  assign rq_tag = dpif.dmemaddr[31:6];
  assign rq_blockoffset = dpif.dmemaddr[2];

  assign tag_match0 = (rq_tag == cway[0].dtable[rq_index].tag);
  assign tag_match1 = (rq_tag == cway[1].dtable[rq_index].tag);

  assign hit0 = (rq_tag == cway[0].dtable[rq_index].tag) && (cway[0].dtable[rq_index].valid) && (dpif.dmemREN || dpif.dmemWEN);
  assign hit1 = (rq_tag == cway[1].dtable[rq_index].tag) && (cway[1].dtable[rq_index].valid) && (dpif.dmemREN || dpif.dmemWEN);
  assign hit_out = hit0 | hit1;

  assign dpif.dhit = hit_out;


  always_comb begin : next_state_logic_fsm
     //start from idle
     next_state = idle;
     if(state == idle) begin

        if (dpif.halt) begin
            next_state = flush;
        end else if(hit_out) begin //&& dpif.dmemREN
            //want to read and its in the table, so we just read it
            next_state = idle;
        end else if(!(dpif.dmemREN || dpif.dmemWEN)) begin
            next_state = idle;
        end else if(!cway[cur_lru].dtable[rq_index].dirty || (!cway[0].dtable[rq_index].valid && !cway[1].dtable[rq_index].valid)) begin
            next_state = fetch1;
        end else if(!hit_out && cway[cur_lru].dtable[rq_index].dirty && cway[cur_lru].dtable[rq_index].valid) begin
            next_state = wb1;
        end


     end else if(state == fetch_done) begin
        next_state = idle;

     end else if(state == fetch1) begin
        next_state = fetch2;

     end else if(state == fetch2) begin

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

  //STUFF
  always_ff @ (posedge CLK, negedge nRST) begin
    if(!nRST) begin
      LRU <= '0;
    end else if(hit_out) begin
      LRU[rq_index] <= !LRU[rq_index];
    end
  end 


 assign dpif.dmemload = (hit0 ? cway[0].dtable[rq_index].block[rq_blockoffset] : (hit1 ? cway[1].dtable[rq_index].block[rq_blockoffset] : 32'hbadbeef1 )); //or bad1bad1

  always_comb begin : output_logic_fsm
    CACHE_WEN = 0;
    
    casez(state)
      flush: begin
          $display("FLUSHING (! bits)");
      end
      idle: begin
            ccif.dREN = 0;
            if(hit_out && dpif.dmemWEN) begin
                $display("idle WRITING SW lru = %d, idx = %d", cur_lru, rq_index);

                // cway[cur_lru].dtable[rq_index].block[rq_blockoffset] = dpif.dmemstore;
                // cway[cur_lru].dtable[rq_index].dirty = 1;
                // cway[cur_lru].dtable[rq_index].valid = 1;
                CACHE_WEN = 1;
                which_word = rq_blockoffset;
                write_dirty = 1;
                write_valid = 1;
                write_tag = rq_tag;
                write_data = dpif.dmemstore;

            end

            // if(hit_out) begin
            //     LRU[rq_index] = !LRU[rq_index];
            // end

      end
      fetch1: begin
          ccif.dREN = 1;
        //  $display("Fetching 1 %h",  ccif.daddr);
          // cway[cur_lru].dtable[rq_index].block[0] = ccif.dload[CPUID];
          // cway[cur_lru].dtable[rq_index].dirty = 0;
          // cway[cur_lru].dtable[rq_index].tag = rq_tag;
          // cway[cur_lru].dtable[rq_index].valid = 0;

          CACHE_WEN = 1;
          which_word = 0;
          write_dirty = 0;
          write_tag = rq_tag;
          write_valid = 0;
          write_data = ccif.dload[CPUID];

          ccif.daddr = {rq_tag, rq_index, 3'b000};
      end
      fetch2: begin
          ccif.dREN = 1;
          //fetch two block offset = 1
          // ccif.daddr = {rq_tag, rq_index, 3'b100};
          // cway[cur_lru].dtable[rq_index].tag = rq_tag;
          // cway[cur_lru].dtable[rq_index].block[1] = ccif.dload[CPUID];
          // cway[cur_lru].dtable[rq_index].dirty = 0;
          CACHE_WEN = 1;
          which_word = 1;
          write_dirty = 0;
          write_tag = rq_tag;
          write_data = ccif.dload[CPUID];

          ccif.daddr = {rq_tag, rq_index, 3'b100};

         // $display("Fetching 2 %h", ccif.daddr);

        //  $display("Fetch 2 : lru = %d, idx = %d", cur_lru, rq_index);

          if(!ccif.dwait) begin
            write_valid = 1;
           // $display("Setting valid  %h",  ccif.daddr);
          end

          if(hit_out && dpif.dmemWEN) begin
                $display("WRITING SW lru = %d, idx = %d", cur_lru, rq_index);
                
                CACHE_WEN = 1;
                write_dirty = 1;
                write_valid = 1;
                which_word = rq_blockoffset;
                write_data = dpif.dmemstore;
                write_tag = rq_tag;

                // cway[cur_lru].dtable[rq_index].block[rq_blockoffset] = dpif.dmemstore;
                // cway[cur_lru].dtable[rq_index].dirty = 1;
                // cway[cur_lru].dtable[rq_index].valid = 1;
          end

          // LRU[rq_index] = !LRU[rq_index];

      end
      wb1: begin
          //writeback data in table to RAM

          CACHE_WEN = 0;

          ccif.dWEN = 1;
          ccif.dstore[CPUID] = cway[cur_lru].dtable[rq_index].block[0]; //cur_lru ---> (hit0 ? 1 : 0)
      end
      wb2: begin
                CACHE_WEN = 0;

          ccif.dWEN = 1;
          ccif.dstore[CPUID] = cway[cur_lru].dtable[rq_index].block[1]; //(hit0 ? 1 : 0)
      end
      default: begin
             CACHE_WEN = 0;
            //dont do anything
            ccif.dREN = 0;
            ccif.dWEN = 0;

            write_dirty = write_dirty;
            write_valid = write_valid;
            which_word = which_word;
            write_data = write_data;
            write_tag = write_tag;
      end
    endcase
  end


  always_ff @ (posedge CLK, negedge nRST) begin : word
      if(!nRST) begin
          cway <= '0;
      end else if(CACHE_WEN) begin
          cway[cur_lru].dtable[rq_index].tag <= write_tag;
          cway[cur_lru].dtable[rq_index].block[which_word] <= write_data; //ccif.dload[CPUID]
          cway[cur_lru].dtable[rq_index].valid <= write_valid;
          cway[cur_lru].dtable[rq_index].dirty <= write_dirty;
      end 
  end



  always_ff @ (posedge CLK, negedge nRST) begin : ff_fsm
    if(!nRST) begin
        state <= idle;
    end else begin
        state <= next_state;
    end
  end

endmodule
