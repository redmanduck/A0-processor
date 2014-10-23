`include "cpu_types_pkg.vh"
`include "cache_control_if.vh"
`include "cpu_ram_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

import cpu_types_pkg::*;

module icache_tb;
//internal signals
logic nRST, CLK = 0;
parameter PERIOD = 10;
parameter CPUID = 0;
parameter INSTRUCTIONS = 10; //# instructions to load into cache

always #(PERIOD/2) CLK++;
//interfaces

int i;
int unsigned cycles;
////////
//Comment out this portion to test icache in isolation

datapath_cache_if dcif ();
cache_control_if ccif ();
cpu_ram_if ramif();

ram #(.LAT(10)) CPURAM  (CLK, nRST, ramif);
memory_control MCTL(CLK, nRST, ccif);

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
        icache #(16,0) DUT (CLK, nRST, dcif, ccif);
`else
icache DUT ( );
`endif

initial begin
    //initial values
    nRST = 0;
    dcif.imemaddr = '0;
    dcif.imemREN = 0;
    #PERIOD nRST = 1;

    #(PERIOD);
    $display("\nChecking if everything reset to 0.");

    $display("\nRequesting data that is not loaded: compulsory miss test.");
    request_instr(32'h00);
    #(PERIOD*5);
    request_instr(32'h04);
    #(PERIOD*5);
    request_instr(32'h08);
    #(PERIOD*5);
    request_instr(32'h08);
    $finish();
end // initial begin

task request_instr;
    input [31:0] address;
    begin
        dcif.imemaddr = address;
        dcif.imemREN = 1;
        #(PERIOD);
        cycles = 1;
        while(!dcif.ihit) begin
          #(PERIOD);
          cycles++;
        end
        #(PERIOD);
        $display("addr: %h data: %h %s", address, dcif.imemload, (cycles == 1)? "HIT" : "MISS");
    end
endtask

endmodule

