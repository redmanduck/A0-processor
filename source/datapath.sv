/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;

  // pc init
  parameter PC_INIT = 0;

  //@Lab3, implements only R-type, load-store instructions
  logic [5:0] opcode, funct;
  logic [4:0] rs, rt, rd, shamt;
  word_t PC_next;
  word_t PC;

  //map the instruction
  assign opcode = dpif.imemload[31:26];
  assign rs = dpif.imemload[26:21];
  assign rt = dpif.imemload[21:16];
  assign rd = dpif.imemload[16:11];
  assign shamt = dpif.imemload[11:6];
  assign funct = dpif.imemload[6:0];
  assign immediate = dpif.imemload[16:0];

  always_comb begin : PC_ns_logic
    if (!dpif.halt) begin
      PC_next = PC + 4;
    end
  end

  always_ff @ (posedge CLK, negedge nRST) begin : PC_update_logic
    if(!n_RST) begin
      PC <= PC_INIT;
    end else begin
      PC <= PC_next;
    end
  end

  always_comb begin :

  always_ff @ (posedge CLK, negedge nRST) begin : PC_Load_stuff
endmodule
