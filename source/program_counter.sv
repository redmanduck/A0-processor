/*

  Pat Suppatach Sabpisal
  ssabpisa@purdue.edu

  this block is the program counter
  and its next pc logic

*/
`include "datapath_cache_if.vh"
`include "cpu_types_pkg.vh"

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
    if (!dcif.pc_en) begin
      casez (PCSrc) begin
          case 0: begin // JR
            PC_next <= rfif.rdat1 //Let $rs go to rsel1
          end
          case 1: PC_next <= PC + 4 + IMM16; //fille this in
          case 2: PC_next <=
          case 3: PC_next <=
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
