`include "cache_control_if.vh"
`include "cpu_ram_if.vh"

`timescale 1 ns / 1 ns

import cpu_types_pkg::*;

module memory_control_tb;
  cache_control_if ccif();
  cpu_ram_if ramif();

  logic CLK = 0;
  logic nRST;
  parameter PERIOD = 10;

  memory_control DUT(CLK, nRST, ccif);
  ram DRAM(CLK, nRST, ramif);

  always #(PERIOD/2) CLK++;


  assign ccif.ramstate = ramif.ramstate;
  assign ccif.ramload = ramif.ramload;
  assign ramif.ramWEN = ccif.ramWEN;
  assign ramif.ramstore = ccif.ramstore;
  assign ramif.ramREN = ccif.ramREN;
  assign ramif.ramaddr = ccif.ramaddr;

 // assign ccif.ramstate = BUSY;
 // assign ccif.ramload = 32'hABCD;

  initial begin
    nRST = 1'b0;
    nRST = 1'b1;

    #(PERIOD*2);

    //enable read instruction for memcontroller
    ccif.dREN[0] = 1'b1;
    ccif.daddr = 64'h0004;

//    #(PERIOD*2);
  //  ccif.daddr = 64'h0005;

   // #(PERIOD*2)
   // ccif.daadr = 64'h0006;
   // $display("iwait %d iload %h", ccif.iwait, ccif.iload);

   end


   /*
      This dump_memory function is provided
   */
/*
   task automatic dump_memory();
    string filename = "memcpu.hex";
    int memfd;

    syif.tbCTRL = 1;
    syif.addr = 0;
    syif.WEN = 0;
    syif.REN = 0;

    memfd = $fopen(filename,"w");
    if (memfd)
      $display("Starting memory dump.");
    else
      begin $display("Failed to open %s.",filename); $finish; end

    for (int unsigned i = 0; memfd && i < 16384; i++)
    begin
      int chksum = 0;
      bit [7:0][7:0] values;
      string ihex;

      syif.addr = i << 2;
      syif.REN = 1;
      repeat (2) @(posedge CLK);
      if (syif.load === 0)
        continue;
      values = {8'h04,16'(i),8'h00,syif.load};
      foreach (values[j])
        chksum += values[j];
      chksum = 16'h100 - chksum;
      ihex = $sformatf(":04%h00%h%h",16'(i),syif.load,8'(chksum));
      $fdisplay(memfd,"%s",ihex.toupper());
    end //for
    if (memfd)
    begin
      syif.tbCTRL = 0;
      syif.REN = 0;
      $fdisplay(memfd,":00000001FF");
      $fclose(memfd);
      $display("Finished memory dump.");
    end
  endtask
*/

endmodule
