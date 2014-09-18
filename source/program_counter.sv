/*

  Pat Suppatach Sabpisal
  ssabpisa@purdue.edu

  this block is the program counter
  and its next pc logic

*/
`include "pc_if.vh"
`include "cpu_types_pkg.vh"

module program_counter (
   input CLK, nRST,
   pc_if.pc pcif
);

   //TODO: make interface for pc
   import cpu_types_pkg::*;
   word_t PC_next;
   word_t PC;
   word_t pc_4;

   assign pc_4 = PC + 4;

   parameter PC_INIT = 0;

   assign pcif.imemaddr = PC;

   //TODO: ----------- Increase on ihit: otherwise
   //TODO: ----------- Increase on dhit: ctr_dWEN | ctr_dREN

   always_comb begin : PC_ns_logic
      if(!pcif.pc_en) begin
       PC_next = PC;
      end else begin
        PC_next = PC + 4;
        casez (pcif.PCSrc)
              0: begin
                 //JR
                 PC_next = pcif.rdat1; // (JR) Let $rs go to rsel1
              end
              1: begin
                 //J or JAL
                 //TODO: put in $31 for JAL
                 PC_next = { pc_4[31:28] , pcif.immediate26, 2'b0 };
              end
              2: begin
                 //BEQ/BNE
                 PC_next = (PC + 4) + (pcif.immediate26 << 2);
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
