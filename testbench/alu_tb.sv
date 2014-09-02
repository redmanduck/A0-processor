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


    #(CLK_PERIOD*2);
    tb_aluop <= ALU_AND;
    tb_a <= 1'b1;
    tb_b <= 1'b0;
    #(CLK_PERIOD*2);
    $display("Result 0x01 & 0x00 = %d", tb_output);

  end

endmodule
