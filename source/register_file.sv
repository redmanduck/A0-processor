/*
  Pat S. Sabpisal
  ssabpisa@purdue.edu

  register file

*/
`include "register_file_if.vh";
import cpu_types_pkg::*;

module register_file (
  input logic CLK,
  input logic nRst,
  register_file_if.rf rfif
);

word_t regs; //no need to specify [31:0] right?

always_ff @(posedge CLK, negedge nRst) begin
  if (nRst == 1'b0) begin
    //Reset all modifiable locations to a value of 0x00000000
    regs <= 0;
  end
  else if (rfif.WEN) begin
    //Write mode
    regs[rfif.wsel] <= rfif.wdat;
  end
end

//connects rdat to requested register (rsel) if write enable is low
assign rfif.rdat1 = (!rfif.WEN ? regs[rfif.rsel1] : 32'h00000000);
assign rfif.rdat2 = (!rfif.WEN ? regs[rfif.rsel2] : 32'h00000000);

endmodule
