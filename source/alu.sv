`include "control_hazard_alu_if.vh"
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;

module alu(
        output logic [3:0] ALUOP,
        output logic [31:0] Port_A,
        output logic [31:0] Port_B,
        output logic negative,
        output logic overflow,
        output logic [31:0] output_port,
        output logic zero
    );

parameter LSL=4'b1000, LSR=4'b1001, AND=4'b0000, OR=4'b0001,
          XOR=4'b1111,NOR=4'b1100, ADD=4'b0010, SUB=4'b0110, SLS=4'b0111;

always_comb begin : decoder
    case(ALUOP)
        default: begin
            overflow = 1'b0;
            output_port <= 32'b0;
        end
        LSL: begin
            //Logical Shift Left Port A by Port B
            //TODO: if Port B is larger than 32 or other cases
            overflow = 1'b0;
            output_port = Port_A << Port_B;
        end
        LSR: begin
            //Logical Shift Right similar to LSL
            overflow = 1'b0;
            output_port = Port_A >> Port_B;
        end
        AND: begin
            overflow = 1'b0;
            output_port = Port_B & Port_A;
        end
        OR: begin
            overflow = 1'b0;
            output_port = Port_B | Port_A;
        end
        XOR: begin
            overflow = 1'b0;
            output_port = (~Port_B) & Port_A;
        end
        NOR: begin
            overflow = 1'b0;
            output_port = ~(Port_B | Port_A);
        end
    endcase
end