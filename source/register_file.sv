/*
  Pat S. Sabpisal
  ssabpisa@purdue.edu

  register file

*/
import cpu_types_pkg::*;

module register_file (
  input logic clk,
  input logic n_rst,
  input register_file_if.rf rfif
);

word_t regs; //no need to specify [31:0] right?

always_ff (posedge clk, negedge n_rst) begin
  if (n_rst == 1'b0) begin
    //Reset all modifiable locations to a value of 0x00000000
    regs = 8'b00000000;
  else if (rfif.WEN) begin
    //Write mode
    regs[rfif.wsel] <= rfif.wdat;
  end
end

//connects rdat to requested register (rsel) if write enable is low
assign rfif.rdat1 = (!rfif.WEN ? regs[rfif.rsel1] : 1'b0)
assign rfif.rdat2 = (!rfif.WEN ? regs[rfif.rsel2] : 1'b0)
