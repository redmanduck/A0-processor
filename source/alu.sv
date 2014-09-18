`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;

module alu(
        input logic [3:0] ALUOP,
        input logic [31:0] Port_A,
        input logic [31:0] Port_B,
        output logic negative,
        output logic overflow,
        output logic [31:0] output_port,
        output logic zero
    );


assign zero = (output_port == 32'h0 ? 1'b1 : 1'b0);
assign overflow = (Port_A[31] == Port_B[31] ? (Port_A[31]^output_port[31]) :
1'b0); //overflow if output has different sign than operands
assign negative = output_port[31];

always_comb begin : decoder
    casez (ALUOP)
        default: begin
            output_port <= 32'b0;
        end
        ALU_SLL: begin
            //Logical Shift Left Port A by Port B
            //TODO: if Port B is larger than 32 or other cases
            output_port = Port_A << Port_B;
        end
        ALU_SRL: begin
            //Logical Shift Right similar to LSL
            output_port = Port_A >> Port_B;
        end
        ALU_AND: begin
            output_port = Port_B & Port_A;
        end
        ALU_OR: begin
            output_port = Port_B | Port_A;
        end
        ALU_XOR: begin
            output_port = Port_B ^ Port_A;
        end
        ALU_SLT: begin
            //Set if less than
            if ($signed(Port_A) < $signed(Port_B)) begin
               output_port = 1'b1;
            end else begin
               output_port = 1'b0;
            end

        end
        ALU_SLTU: begin
           if ( $unsigned(Port_A) < $unsigned(Port_B) ) begin
               output_port = 1'b1;
           end else begin
               output_port = 1'b0;
           end
        end
        ALU_ADD: begin
            //Signed Add
            output_port = Port_A + Port_B;
        end
        ALU_SUB: begin
           //Signed Subtract
            output_port = Port_A - Port_B;
        end
        ALU_NOR: begin
            //#overflow = 1'b0;
            output_port = ~(Port_B | Port_A);
        end
    endcase
end

endmodule

