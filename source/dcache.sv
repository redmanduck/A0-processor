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

  typedef enum logic [5:0] {idle, fetch1, fetch2, fetch_done, wb1, wb2, reset,  all_fetch_done, flush1, flush2, flush3, flush4, all_flushed, done_everything} StateType;


  StateType state, next_state;

  logic [25:0] rq_tag;
  logic [2:0] rq_index;
  logic hit_out, hit0, hit1;
  logic tag_match0, tag_match1;
  logic cur_lru, rq_blockoffset;

  word_t hitcount, hitcount_next;
  word_t hit_wait_count, hit_wait_count_next;

  logic FLUSH_INDEX_INCREM_EN;
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

  CacheRow [1:0] flushset;
  logic [2:0] flush_index;

  assign flushset[0] = cway[0].dtable[flush_index];
  assign flushset[1] = cway[1].dtable[flush_index];

  always_comb begin : next_state_logic_fsm
     //start from idle
     next_state = idle;
     if(state == idle) begin

        if (dpif.halt) begin
            next_state = flush1;
        end else if(hit_out) begin //&& dpif.dmemREN
            //want to read and its in the table, so we just read it
            next_state = idle;
        end else if(!(dpif.dmemREN || dpif.dmemWEN)) begin
            next_state = idle;
        end else if((!cway[cur_lru].dtable[rq_index].dirty || (!cway[0].dtable[rq_index].valid && !cway[1].dtable[rq_index].valid)) && !hit_out) begin
            next_state = fetch1;
        end else if(!hit_out && cway[cur_lru].dtable[rq_index].dirty && cway[cur_lru].dtable[rq_index].valid) begin
            next_state = wb1;
        end

     end else if(state == flush1) begin
        if(!ccif.dwait[CPUID]) begin
          next_state = flush2;
        end else begin
           next_state = flush1;
        end 

     end else if(state == flush2) begin
        
        if(!ccif.dwait[CPUID]) begin
           next_state = flush3;
        end else begin
           next_state = flush2;
        end 
     end else if(state == flush3) begin
        if(!ccif.dwait[CPUID]) begin
          next_state = flush4;
        end else begin
           next_state = flush3;
        end 

     end else if(state == flush4) begin
        
        if(!ccif.dwait[CPUID]) begin
           if(flush_index == total_set -1) begin //done flushing if we flushed 8 rows already
              next_state = all_flushed;
           end else begin
              next_state = flush1;
           end
        end else begin
           next_state = flush4;
        end 

    end else if(state == all_flushed) begin

        if(!ccif.dwait) begin
          next_state = done_everything;
        end else begin
          next_state = all_flushed;
        end
     end else if(state == done_everything) begin

        next_state = done_everything;

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

  logic next_lru;
  //STUFF
  always_ff @ (posedge CLK, negedge nRST) begin
    if(!nRST) begin
      LRU <= '0;
    end else if(hit_out) begin
      LRU[rq_index] <= next_lru;
      $display("updating LRU at index %d to %d", rq_index, hit0);
    end
  end

 //assign dpif.dmemload = (hit0 ? cway[0].dtable[rq_index].block[rq_blockoffset] : (hit1 ? cway[1].dtable[rq_index].block[rq_blockoffset] : 32'hbad1bad2 ));

 always_comb begin: Eric
   if(hit0 == 1) begin
      if(rq_blockoffset == 0) begin
        dpif.dmemload = cway[0].dtable[rq_index].block[0:0];
      end else begin
        dpif.dmemload = cway[0].dtable[rq_index].block[1:1];
      end
   end else if(hit1 == 1) begin
      if(rq_blockoffset == 0) begin
        dpif.dmemload = cway[1].dtable[rq_index].block[0:0];
      end else begin
        dpif.dmemload = cway[1].dtable[rq_index].block[1:1];
      end
   end else begin
      dpif.dmemload = 32'hbad0bad0;
   end
 end

  always_comb begin : output_logic_fsm
    CACHE_WEN = 0;
    // ccif.dREN = 0;
    // ccif.dWEN = 0;

    // which_word = 0;
    // write_dirty = 0;
    // write_valid = 0;
    // write_tag = 0;
    // write_data = 0;
    dcif.flushed = 0;
    hitcount_next = hitcount;
    hit_wait_count_next = hit_wait_count + 1;
    next_lru = LRU[rq_index];

    casez(state)
      flush1: begin
           //This flushes WAY 1, LOWER WORD at whaterver index we are at

          which_word = 0;
          write_dirty = 0;
          write_valid = 0;
          write_tag = 0;
          write_data = 0;
          FLUSH_INDEX_INCREM_EN = 0;
          CACHE_WEN = 0;
          ccif.dREN = 0;
          ccif.dWEN = flushset[0].dirty;

          ccif.dstore[CPUID] = flushset[0].block[0]; //lower word
          ccif.daddr[CPUID] = { flushset[0].tag, flush_index, 1'b0 ,2'b00};

          //$display("FLUSHING 1 : idx = %h, data = %h, dirty = %h, addr = %h", flush_index, flushset[0].block[0], flushset[0].dirty, { flushset[0].tag, flush_index, 1'b0 ,2'b00});

      end
      flush2: begin
          //This flushes WAY 2, UPPER WORD at whaterver index we are at

          which_word = 0;
          write_dirty = 0;
          write_valid = 0;
          write_tag = 0;
          write_data = 0;
          CACHE_WEN = 0;
          FLUSH_INDEX_INCREM_EN = 0;
          ccif.dREN = 0;
          ccif.dWEN = flushset[0].dirty;
          ccif.dstore[CPUID] = flushset[0].block[1]; //upper word
          ccif.daddr[CPUID] = { flushset[0].tag, flush_index, 1'b1 ,2'b00};

          //$display("FLUSHING 2 : idx = %h, data = %h, dirty = %h, addr = %h", flush_index, flushset[0].block[1], flushset[0].dirty, { flushset[0].tag, flush_index, 1'b1 ,2'b00});

          //TODO we need to write hit count to memory
      end
      flush3: begin
          //This flushes WAY 2, LOWER WORD at whaterver index we are at

          which_word = 0;
          write_dirty = 0;
          write_valid = 0;
          write_tag = 0;
          write_data = 0;
          FLUSH_INDEX_INCREM_EN = 0;
          CACHE_WEN = 0;
          ccif.dREN = 0;
          ccif.dWEN = flushset[1].dirty;

          ccif.dstore[CPUID] = flushset[1].block[0]; //lower word
          ccif.daddr[CPUID] = { flushset[1].tag, flush_index, 1'b0 ,2'b00};

          //$display("FLUSHING 3 : idx = %h, data = %h, dirty = %h, addr = %h", flush_index, flushset[1].block[0], flushset[1].dirty, { flushset[1].tag, flush_index, 1'b0 ,2'b00});


      end
      flush4: begin
            //This flushes WAY 2, UPPER WORD at whaterver index we are at

          which_word = 0;
          write_dirty = 0;
          write_valid = 0;
          write_tag = 0;
          write_data = 0;
          CACHE_WEN = 0;
          FLUSH_INDEX_INCREM_EN = 1; //increment to the next index
          ccif.dREN = 0;
          ccif.dWEN = flushset[1].dirty;
          ccif.dstore[CPUID] = flushset[1].block[1]; //upper word
          ccif.daddr[CPUID] = { flushset[1].tag, flush_index, 1'b1 ,2'b00};

          //$display("FLUSHING 4 : idx = %h, data = %h, dirty = %h, addr = %h \n", flush_index, flushset[1].block[1], flushset[1].dirty, { flushset[1].tag, flush_index, 1'b1 ,2'b00});

      end

      all_flushed: begin
          $display("ALL DONE with hitcount %d", hitcount);
          ccif.dREN = 0;
          ccif.dWEN = 1;
          ccif.dstore[CPUID] = hitcount;
          ccif.daddr[CPUID] = 32'h3100;
          CACHE_WEN = 0;
      end
      done_everything: begin
          dpif.flushed = 1;
      end
      idle: begin
            ccif.dREN = 0; 
            ccif.dWEN = 0;
            hit_wait_count_next = 0;

            if(hit_out) begin
                next_lru = hit0;

                if(hit_wait_count < 1) begin
                    hitcount_next = hitcount + 1;
                end

                if(dpif.dmemWEN == 1'b1) begin

                    next_lru = !LRU[rq_index]; //?

                    $display("IDLE WRITING CACHE: LRU = %d, IDX = %d, data = %h", cur_lru, rq_index, dpif.dmemstore);
                    FLUSH_INDEX_INCREM_EN = 0;
                    CACHE_WEN = 1;

                    which_word = rq_blockoffset;
                    write_dirty = 1;
                    write_valid = 1;
                    write_tag = rq_tag;
                    write_data = dpif.dmemstore;
                end

            end else begin

                CACHE_WEN = 0;
                which_word = 0;
                write_dirty = 0;
                write_valid = 0;
                write_tag = 0;
                write_data = 0;

                FLUSH_INDEX_INCREM_EN  = 0;
            end

            // if(hit_out) begin
            //     LRU[rq_index] = !LRU[rq_index];
            // end

      end
      fetch1: begin
          ccif.dREN = 1; ccif.dWEN = 0;
          CACHE_WEN = 1;
          which_word = 0;
          write_dirty = 0;
          write_tag = rq_tag;
          write_valid = 0;
          write_data = ccif.dload[CPUID];

          FLUSH_INDEX_INCREM_EN  = 0;
          ccif.daddr = {rq_tag, rq_index, 3'b000};
      end
      fetch2: begin
          ccif.dREN = 1; ccif.dWEN = 0;
          CACHE_WEN = 1;
          which_word = 1;
          write_dirty = 0;
          write_tag = rq_tag;
          write_data = ccif.dload[CPUID];

          ccif.daddr = {rq_tag, rq_index, 3'b100};

          FLUSH_INDEX_INCREM_EN  = 0;
          if(!ccif.dwait) begin
            write_valid = 1;
          end else begin
            write_valid = 0;
          end

          if(hit_out && dpif.dmemWEN) begin
                $display("FETCH2 WRITING CACHE: LRU = %d, IDX = %d, data = %h", cur_lru, rq_index, dpif.dmemstore);

                FLUSH_INDEX_INCREM_EN  = 0;
                CACHE_WEN = 1;
                write_dirty = 1;
                write_valid = 1;
                which_word = rq_blockoffset;
                write_data = dpif.dmemstore;
                write_tag = rq_tag;

          end

      end
      wb1: begin
          //writeback data in table to RAM

          CACHE_WEN = 0;
          which_word = 0;
          write_dirty = 0;
          write_valid = 0;
          write_tag = 0;
          write_data = 0;
          ccif.daddr = {cway[cur_lru].dtable[rq_index].tag, rq_index, 3'b000};

          FLUSH_INDEX_INCREM_EN  = 0;
          ccif.dWEN = 1; ccif.dREN = 0;
          ccif.dstore[CPUID] = cway[cur_lru].dtable[rq_index].block[0:0]; //cur_lru ---> (hit0 ? 1 : 0)
          // $display("HAO1 -------- %h", cway[cur_lru].dtable[rq_index].block[0:0]);
      end
      wb2: begin
          CACHE_WEN = 0;

          which_word = 0;
          write_dirty = 0;
          write_valid = 0;
          write_tag = 0;
          write_data = 0;

          FLUSH_INDEX_INCREM_EN  = 0;
          ccif.daddr = {cway[cur_lru].dtable[rq_index].tag, rq_index, 3'b100};
          ccif.dWEN = 1; ccif.dREN = 0;
          ccif.dstore[CPUID] = cway[cur_lru].dtable[rq_index].block[1:1]; //(hit0 ? 1 : 0)

          // $display("HAO2 -------- %h", cway[cur_lru].dtable[rq_index].block[1:1]);

      end
      default: begin
        $display("entered default");
        CACHE_WEN = 0;
        //dont do anything
        ccif.dREN = 0;
        ccif.dWEN = 0;
        dcif.flushed = 0;
        hitcount_next = hitcount;

        FLUSH_INDEX_INCREM_EN  = 0;
        write_dirty = 0;
        write_valid = 0;
        which_word = 0;
        write_data = 0;
        write_tag = 0;
      end
    endcase
  end


  always_ff @ (posedge CLK, negedge nRST) begin : cache_fsm
      if(!nRST) begin
          cway <= '0;
      end else if(CACHE_WEN) begin
          if(hit_out) begin
                cway[!hit0].dtable[rq_index].tag <= write_tag;
                cway[!hit0].dtable[rq_index].block[which_word] <= write_data; //ccif.dload[CPUID]
                cway[!hit0].dtable[rq_index].valid <= write_valid;
                cway[!hit0].dtable[rq_index].dirty <= write_dirty;
          end else begin
                cway[cur_lru].dtable[rq_index].tag <= write_tag;
                cway[cur_lru].dtable[rq_index].block[which_word] <= write_data; //ccif.dload[CPUID]
                cway[cur_lru].dtable[rq_index].valid <= write_valid;
                cway[cur_lru].dtable[rq_index].dirty <= write_dirty;
          end
      end
  end

  always_ff @ (posedge CLK, negedge nRST) begin: flush_fsm
    if(!nRST) begin
        flush_index <= 0;
    end else if(FLUSH_INDEX_INCREM_EN) begin
        flush_index <= flush_index + 1;
    end
  end

  always_ff @ (posedge CLK, negedge nRST) begin : ff_fsm
    if(!nRST) begin
        state <= idle;
        hitcount <= 0;

        hit_wait_count <= 0;
    end else begin
        state <= next_state;
        hitcount <= hitcount_next;
        hit_wait_count <= hit_wait_count_next;
        //$display("idle count : %d", hit_wait_count);
        //$display("hit count : %d", hitcount);
    end
  end

endmodule