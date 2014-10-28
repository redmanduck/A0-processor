`include "cpu_types_pkg.vh"
`include "cache_control_if.vh"
`include "cpu_ram_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

import cpu_types_pkg::*;

module dcache_tb;
   //internal signals
   logic nRST, CLK = 0;
   logic RAMCLK = 0;
   parameter PERIOD = 10;
   parameter CPUID = 0;
   parameter WORDS = 10; //# data words to load into cache
   int   i;

int unsigned cycles;

   //interfaces
   datapath_cache_if dcif ();
   cache_control_if ccif ();

   ////////
   //Comment out this portion to test dcache in isolation
   cpu_ram_if ramif();
   ram #(.LAT(1)) CPURAM (RAMCLK, nRST, ramif);
   memory_control MCTL(CLK, nRST, ccif.cc);
   //connections
   assign ccif.ramstate = ramif.ramstate;
   assign ccif.ramload = ramif.ramload;
   assign ramif.ramWEN = ccif.ramWEN;
   assign ramif.ramstore = ccif.ramstore;
   assign ramif.ramREN = ccif.ramREN;
   assign ramif.ramaddr = ccif.ramaddr;
   ///////

   //blocks
`ifndef MAPPED
   dcache #(8,2,0) DUT (CLK, nRST, dcif, ccif);
`else
   dcache DUT ( );
`endif

   always #(PERIOD/4) RAMCLK++;
   always #(PERIOD/2) CLK++;

   initial begin
      //initial values
      nRST = 0;
      ccif.iaddr[CPUID] = '0;
      ccif.iREN[CPUID] = 0; //so they dont interferewith memctl
      dcif.dmemWEN = 0; dcif.dmemREN = 0;
      dcif.dmemaddr = '0;
      dcif.dmemstore = '0;
      //initial nRequesting
      #(PERIOD*1.5) nRST = 1;
      @(posedge CLK);

      $display("\nChecking if everything reset to 0.");
      //Check it.

      $display("\nRequesting data that is not loaded: compulsory miss test.");
      // load_word(32'h00); //miss
      // #PERIOD;

      load_word(32'h08); //miss
      #PERIOD;

      load_word(32'h0C); //hit
      #PERIOD;

      load_word(32'h3C); //miss
      #PERIOD;

      load_word(32'h00);  //miss
      #PERIOD;

      // load_word(32'h00000400); //hit, loading into same set, must pick last usedto replace
      // #(2*PERIOD);

      store_word(32'h08, 32'hBEEFDEAD);  //write to address that hit
 //     store_word(32'hF8, 32'hBEEF);  //write to address that miss


      #(PERIOD*10);

      load_word(32'h08);  //miss


      // store_word(32'h08, 32'hDED2); //miss



      dcif.halt = 1;
      #(PERIOD*40);


      $finish();

   end // initial begin


   task automatic load_word;
      input [31:0] address;
      begin
      dcif.dmemaddr = address;
      dcif.dmemREN = 1;
      cycles = 1;

   for (i=0; i < 32; i++) begin
      if (dcif.dhit == 1) begin
         dcif.dmemREN = 0;
         $display("%s", (cycles > 3)? "MISS" : "HIT");
         $display("Received data: %h", ccif.dload[CPUID]);

         break;
      end
      else begin
         cycles++;
         #PERIOD;
      end
   end
      end
   endtask


   task automatic store_word;
      input [31:0] address;
      input [31:0] data;
      begin
      dcif.dmemaddr = address;
      dcif.dmemREN = 0;
      dcif.dmemWEN = 1;
      dcif.dmemstore = data;

   for (i=0; i < 32; i++) begin
      if (dcif.dhit == 1) begin
         dcif.dmemWEN = 0;
         $display("Storing data: %h", ccif.dstore[CPUID]);
         break;
      end
      else begin
         $display("waiting");
         #PERIOD;
      end
   end
      end
   endtask


endmodule
