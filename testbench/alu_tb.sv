/*

  S. Pat Sabpisal
  ssabpisa@purdue.edu

  ALU testbench
*/


`timescale 1 ns / 1 ns
import cpu_types_pkg::*;

module alu_tb;
  parameter CLK_PERIOD = 10;
  logic tb_clk;
  logic [31:0] tb_a, tb_b;
  logic tb_zero, tb_negative, tb_overflow;
  aluop_t tb_aluop;
  logic [31:0] tb_output;

  alu DUT(.ALUOP(tb_aluop),
          .Port_A(tb_a),
          .Port_B(tb_b),
          .negative(tb_negative),
          .overflow(tb_overflow),
          .output_port(tb_output),
          .zero(tb_zero));

  //Clock generation
  always
  begin
    tb_clk = 1'b0;
    #(CLK_PERIOD/2);
    tb_clk = 1'b1;
    #(CLK_PERIOD/2);
  end

  initial
  begin
    //Reset
    tb_a = 32'h00000000;
    tb_b = 32'h00000000;

    #(CLK_PERIOD*2);

    $display("Testing 1 bit Anding");
    tb_aluop <= ALU_AND;
    tb_a <= 1'b1;
    tb_b <= 1'b1;
    #(CLK_PERIOD*2);
    $display("Result 0x01 & 0x01 = %d", tb_output);
    //$assert(

    #(CLK_PERIOD*2);
    tb_aluop <= ALU_AND;
    tb_a <= 1'b1;
    tb_b <= 1'b0;
    #(CLK_PERIOD*2);
    $display("Result 0x01 & 0x00 = %d", tb_output);

    $display("Testing 32 bits anding");
    tb_aluop <= ALU_AND;
    tb_a <= 32'hABABABAB;
    tb_b <= 32'hABABABAB;
    #(CLK_PERIOD*2);
    $display("Result 0xABABABAB & 0xABABABAB = 0x%h", tb_output);

    //$display("Testing 32 bits anding");
    tb_aluop <= ALU_AND;
    tb_a <= 32'hABABABAB;
    tb_b <= 32'hBABABABA;
    #(CLK_PERIOD*2);
    $display("Result 0xABABABAB & 0xBABABABA = 0x%h", tb_output);

    $display("Testing 32 bits ORing\n");
    tb_aluop <= ALU_OR;
    tb_a <= 32'h55555555;
    tb_b <= 32'hAAAAAAAA;
    #(CLK_PERIOD*2);
    $display("Result 0x55555555 & 0xAAAAAAAA = 0x%h" , tb_output);

    tb_aluop <= ALU_OR;
    tb_a <= 32'hAAAAAA00;
    tb_b <= 32'h0000000F;
    #(CLK_PERIOD*2);
    $display("Result 0xAAAAAA00 &  0x0000000F = 0x%h", tb_output);


    $display("Testing few bits adding\n");
    tb_aluop <= ALU_ADD;
    tb_a <= 32'h00000001;
    tb_b <= 32'h00000001;
    #(CLK_PERIOD*2);
    $display("Result 0x01 + 0x01 = %h", tb_output);
    $display("----- VF = %d, NF = %d, ZF = %d", tb_overflow, tb_negative, tb_zero);

    tb_aluop <= ALU_ADD;
    tb_a <= 10;
    tb_b <= 10;
    #(CLK_PERIOD*2);
    $display("Result 10 + 10 = %d", tb_output);
    $display("----- VF = %d, NF = %d, ZF = %d", tb_overflow, tb_negative, tb_zero);


    tb_aluop <= ALU_ADD;
    tb_a <= -5;
    tb_b <= 10;
    #(CLK_PERIOD*2);
    $display("Result -5 + 10 = %d", tb_output);
    $display("----- VF = %d, NF = %d, ZF = %d", tb_overflow, tb_negative, tb_zero);


    tb_aluop <= ALU_ADD;
    tb_a <= -10;
    tb_b <= 10;
    #(CLK_PERIOD*2);
    $display("Result -10 + 10 = %d", tb_output);
    $display("----- VF = %d, NF = %d, ZF = %d", tb_overflow, tb_negative, tb_zero);


    $display("Testing few bits subtraction\n");
    tb_aluop <= ALU_SUB;
    tb_a <= 15;
    tb_b <= 10;
    #(CLK_PERIOD*2);
    $display("Result 15 - 10 = %d", tb_output);
    $display("---- VF = %d, NF = %d, ZF = %d", tb_overflow, tb_negative, tb_zero);

    tb_aluop <= ALU_SUB;
    tb_a <= 10;
    tb_b <= 15;
    #(CLK_PERIOD*2);
    $display("Result 10 - 15 = %d", tb_output);
    $display("----- VF = %d, NF = %d, ZF = %d", tb_overflow, tb_negative, tb_zero);


    $display("Testing Logical Shift Left (SLL)\n");
    tb_aluop <= ALU_SLL;
    tb_a <= 32'h00000001;
    tb_b <= 5;
    #(CLK_PERIOD*2);
    $display("0x01 << 5 = %b", tb_output);


end

endmodule
