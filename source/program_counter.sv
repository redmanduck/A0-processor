/*

  Pat Suppatach Sabpisal
  ssabpisa@purdue.edu

  this block is the program counter
  and its next pc logic

*/
`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"
`include "register_file_if.vh"
module program_counter (
   input CLK, nRST,
   control_unit_if.control cuif,
   register_file_if.rf rfif,
   input ihit, dhit
);

   //TODO: make interface for pc
   import cpu_types_pkg::*;
   parameter PC_INIT = 0;

   word_t PC_next;
   word_t PC;

   //TODO: Increase on ihit: otherwise
   //TODO: Increase on dhit: ctr_dWEN | ctr_dREN
   always_comb begin : PC_ns_logic
      if(!cuif.pc_en) begin
       PC_next = PC;
      end else begin
        casez (cuif.PCSrc)
            0: begin
               //JR
               PC_next = rfif.rdat1; // (JR) Let $rs go to rsel1
            end
            1: begin
               //J or JAL //TODO: how do i impletement JAL
               PC_next = cuif.immediate26;
            end
            2: begin
               //BEQ/bne
               PC_next = PC + cuif.immediate26;
            end
            default: PC_next = PC + 4;
        endcase
      end
   end

   always_ff @ (posedge CLK, negedge nRST) begin : PC_update_logic
    if(!nRST) begin
      PC <= PC_INIT;
    end else begin
      PC <= PC_next;
    end
  end
endmodule
