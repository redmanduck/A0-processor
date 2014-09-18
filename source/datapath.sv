/*
  Pat Sabpisal
  pat@uniduck.co

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"
`include "control_unit_if.vh"
`include "register_file_if.vh"
`include "ru_cu_if.vh"
`include "pc_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;
  parameter PC_INIT = 0;
  logic megatron;
  assign megatron = CLK;
  control_unit_if cuif();
  register_file_if rfif();
  ru_cu_if rqif();
  pc_if pcif();

  //ALU logics
  aluop_t alu_op;
  word_t alu_a;
  word_t alu_b;
  logic alu_nf;
  logic alu_vf;
  word_t alu_output;
  logic alu_zf;

  logic ihit;
  logic dhit;
  //sub-blocks
  control_unit CU(CLK, nRST, cuif);

  register_file RF(CLK, nRST, rfif);

  program_counter PC(CLK, nRST, pcif);

  alu ALU(.ALUOP(alu_op), .Port_A(alu_a), .Port_B(alu_b), .negative(alu_nf), .overflow(alu_vf), .output_port(alu_output), .zero(alu_zf));

  request_unit RUCU(CLK, nRST, rqif);

  //connect

  assign rfif.rsel1 = cuif.rs;
  assign rfif.rsel2 = cuif.rt;
  assign rfif.WEN = cuif.RegWr;
  assign rfif.wdat = (cuif.MemToReg ? dpif.dmemload : alu_output);
  assign rfif.wsel = (cuif.RegDst ? cuif.rd : cuif.rt  );

  assign rqif.dhit = dpif.dhit;
  assign rqif.ihit = dpif.ihit;
  assign rqif.ctr_iREN = cuif.iREN;
  assign rqif.ctr_dWEN = cuif.dWEN;
  assign rqif.ctr_dREN = cuif.dREN;
  assign dpif.imemREN = rqif.imemREN;
  assign dpif.dmemREN = rqif.dmemREN;
  assign dpif.dmemWEN = rqif.dmemWEN;
  assign dpif.dmemstore = rfif.rdat2;
  assign dpif.dmemaddr = alu_output;

  assign pcif.ihit = ihit;
  assign pcif.dhit = dhit;
  assign pcif.immediate26 = cuif.immediate26;
  assign pcif.rdat1 = rfif.rdat1;
  assign pcif.pc_en = !cuif.halt & dpif.ihit;
  assign pcif.PCSrc =  cuif.PCSrc;
  assign dpif.imemaddr = pcif.imemaddr;

  assign cuif.instruction = dpif.imemload;
  assign cuif.alu_zf = alu_zf;

  assign alu_op = cuif.ALUctr;
  assign alu_a = rfif.rdat1;
//  assign alu_b = 0; //(!cuif.ALUSrc ? rfif.rdat2 : (cuif.ALUSrc2 ? cuif.shamt : ( cuif.ExtOp ? $signed(cuif.immediate) : {16'b0, cuif.immediate} ) ));  //TODO: double check ALUSrc2 mux input

   always_comb begin : MUX_ALUB
       if(!cuif.ALUSrc) begin
          alu_b = rfif.rdat2;
       end else if(cuif.ALUSrc2) begin
          alu_b = cuif.shamt;
       end else if(cuif.ExtOp) begin
          alu_b = $signed(cuif.immediate);
       end else begin //TODO: switch based on ExtOp
          alu_b = cuif.immediate;
       end
   end

/*  always_comb begin : MUX_WRITESRC
    if(cuif.MemToReg) begin
       //Write from reg
       rfif.wdat = dpif.imemload;
    end else begin
       //Write from alu
       rfif.wdat = alu_output;
    end
  end
*/
  assign dpif.halt = cuif.halt; //TODO: double check

endmodule
