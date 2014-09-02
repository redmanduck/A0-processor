/*
  Pat S. Sabpisal
  ssabpisa@purdue.edu

  register file

*/
`include "register_file_if.vh"
import cpu_types_pkg::*;

module register_file (
  input logic CLK,
  input logic nRST,
  register_file_if.rf rfif
);

//word_t
word_t [31:0] regs;

always_ff @(posedge CLK, negedge nRST) begin
  //regs[0] = 0;
  if (nRST == 1'b0) begin
    //Reset all modifiable locations to a value of 0x00000000
  /*    int i;
      for (i=0;i<32;i=i+1) begin : resetloop
        regs[i] = 32'h00000000;
      end
*/
    regs <= 0;
  end else if (rfif.WEN == 1'b1) begin
    //Write mode
    if(rfif.wsel != 0) begin
      regs[rfif.wsel] <= rfif.wdat;
    end
  end
end

//connects rdat to requested register (rsel) if write enable is low
assign rfif.rdat1 = regs[rfif.rsel1];
assign rfif.rdat2 = regs[rfif.rsel2];

endmodule
