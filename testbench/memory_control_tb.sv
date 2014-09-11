`include "cache_control_if.vh"
`include "cpu_ram_if.vh"
//`include "system_if.vh"

`timescale 1 ns / 1 ns

import cpu_types_pkg::*;

module memory_control_tb;


  cache_control_if ccif();
  cpu_ram_if ramif();
//  system_if syif();

  logic CLK = 0;
  logic nRST;
  parameter PERIOD = 10;
  parameter ADDR_MAX = 40;
  memory_control DUT(CLK, nRST, ccif);
  ram DRAM(CLK, nRST, ramif);

  always #(PERIOD/2) CLK++;


  assign ccif.ramstate = ramif.ramstate;
  assign ccif.ramload = ramif.ramload;
  assign ramif.ramWEN = ccif.ramWEN;
  assign ramif.ramstore = ccif.ramstore;
  assign ramif.ramREN = ccif.ramREN;
  assign ramif.ramaddr = ccif.ramaddr;

//  assign ramif.ramREN = syif.REN;
//  assign syif.WEN = ramif.ramWEN;
//  assign syif.store = ramif.ramstore;
//  assign syif.addr = ramif.ramaddr;
//  assign syif.load = ramif.ramload;

  initial begin
    nRST = 1'b0;
    nRST = 1'b1;

    #(PERIOD*2);

    //Test Read
    //un-float the connections
    ccif.dREN = 2'b01;
    ccif.daddr = 4;
    ccif.dWEN = 2'b00;
    ccif.dstore = 0;

    $display("performing consequtive reads");
    //test read all addresses
     #(PERIOD*2);
     for (int i=0; i <= ADDR_MAX; i=i+4) begin
      ccif.daddr = i;
      #(PERIOD*4);
      //$display("%h", ccif.dload);

    end

    $display("performing modification");
    #(PERIOD*2);
    //Test Write
    ccif.dREN = 2'b00;
    ccif.daddr = 0;
    ccif.dWEN = 2'b01;
    //Write this data
    ccif.dstore = 64'hABCDEF9;
    //to this address
    ccif.daddr = 0;

    #(PERIOD*5);

    ccif.dREN = 2'b01;
    ccif.daddr = 0;
    ccif.dWEN = 2'b00;
    ccif.dstore = 0;

    //Read bac0k
    #(PERIOD*50);
    $display("%h", ccif.dload);
    #(PERIOD*5);

    dump_memory();

    $finish;
  end


   /*
      This dump_memory function is provided
   */

   task automatic dump_memory();
    string filename = "memcpu.hex";
    int memfd;

    //ccif.tbCTRL = 1;
    ccif.daddr = 0;
    ccif.dWEN = 0;
    ccif.dREN = 0;

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

      ccif.daddr = i << 2;
      ccif.dREN = 1;
      repeat (2) @(posedge CLK);
      if (ccif.dload === 0)
        continue;
      values = {8'h04,16'(i),8'h00,ccif.dload};
      foreach (values[j])
        chksum += values[j];
      chksum = 16'h100 - chksum;
      ihex = $sformatf(":04%h00%h%h",16'(i),ccif.dload,8'(chksum));
      $fdisplay(memfd,"%s",ihex.toupper());
    end //for
    if (memfd)
    begin
      //ccif.tbCTRL = 0;
      ccif.dREN = 0;
      $fdisplay(memfd,":00000001FF");
      $fclose(memfd);
      $display("Finished memory dump.");
    end
  endtask


endmodule
