/*
  Pat S. Sabpisal
  ssabpisa@purdue.edu

  alu fpga wrapper
*/
//`include "types_pkg.vh"

module alu_fpga (
  input logic [3:0] KEY,
  input logic [17:0] SW,
  output logic [6:0] HEX0,
  output logic [6:0] HEX1,
  output logic [6:0] HEX2,
  output logic [6:0] HEX3,
  output logic [6:0] HEX4,
  output logic [6:0] HEX5,
  output logic [6:0] HEX6,
  output logic [6:0] HEX7
);


logic [4:0] port_a, port_b;
logic nf, vf, zf;
logic [4:0] ans;
logic [3:0] op;

alu ALUT(op, port_a, port_b, nf,vf, ans, zf);

assign op = KEY[3:0];
assign port_a = {27'b0, SW[9:5]};
assign port_b = {27'b0, SW[14:10]};

always_comb
  begin
    unique casez (op)
      'h0: HEX7 = 7'b1000000;
      'h1: HEX7 = 7'b1111001;
      'h2: HEX7 = 7'b0100100;
      'h3: HEX7 = 7'b0110000;
      'h4: HEX7 = 7'b0011001;
      'h5: HEX7 = 7'b0010010;
      'h6: HEX7 = 7'b0000010;
      'h7: HEX7 = 7'b1111000;
      'h8: HEX7 = 7'b0000000;
      'h9: HEX7 = 7'b0010000;
      'ha: HEX7 = 7'b0001000;
      'hb: HEX7 = 7'b0000011;
      'hc: HEX7 = 7'b0100111;
      'hd: HEX7 = 7'b0100001;
      'he: HEX7 = 7'b0000110;
      'hf: HEX7 = 7'b0001110;
    endcase
end



always_comb
  begin
    unique casez (ans)
      'h0: HEX0 = 7'b1000000;
      'h1: HEX0 = 7'b1111001;
      'h2: HEX0 = 7'b0100100;
      'h3: HEX0 = 7'b0110000;
      'h4: HEX0 = 7'b0011001;
      'h5: HEX0 = 7'b0010010;
      'h6: HEX0 = 7'b0000010;
      'h7: HEX0 = 7'b1111000;
      'h8: HEX0 = 7'b0000000;
      'h9: HEX0 = 7'b0010000;
      'ha: HEX0 = 7'b0001000;
      'hb: HEX0 = 7'b0000011;
      'hc: HEX0 = 7'b0100111;
      'hd: HEX0 = 7'b0100001;
      'he: HEX0 = 7'b0000110;
      'hf: HEX0 = 7'b0001110;
    endcase
end

endmodule
