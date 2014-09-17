/*
  Pat Sabpisal
  ssabpisa@purdue.edu
*/
`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"

module control_unit (
   input CLK, nRST,
   control_unit_if.control cuif
);

  import cpu_types_pkg::*;

  //technically imemload will connect to instr

  assign cuif.opcode = cuif.instruction[31:26];
  assign cuif.rs = cuif.instruction[26:21];
  assign cuif.rt = cuif.instruction[21:16];
  assign cuif.rd = cuif.instruction[16:11];
  assign cuif.shamt = cuif.instruction[11:6];
  assign cuif.funct = cuif.instruction[6:0];
  assign cuif.immediate = cuif.instruction[15:0];
  assign cuif.immediate26 = cuif.instruction[25:0];

  assign cuif.MemWr = (cuif.opcode == SW ? 1 : 0);
  assign cuif.MemRead = (cuif.opcode == LW || cuif.opcode == LUI ? 1 : 0);
  assign cuif.iREN = 1'b1;
//  assign cuif.RegWr = (cuif.opcode == RTYPE && (cuif.funct != JR) ? 1 : 0); //everything except JR
  assign cuif.RegDst = (cuif.opcode == RTYPE);

  always_comb begin : PC_CONTROLS
    if(cuif.opcode == JR) begin
       cuif.PCSrc = 1;
    end else if(cuif.opcode == J || cuif.opcode == JAL) begin
       cuif.PCSrc = 2;
    end else if(cuif.opcode == BEQ) begin
       cuif.PCSrc = 3;
    end else if(cuif.opcode == RTYPE && cuif.funct == JR) begin
       cuif.PCSrc = 4;
    end else begin
       cuif.PCSrc = 5; //normal mode otherwise
    end
  end

  always_comb begin : REGISTER_FILE_CONTROLS
    if(cuif.opcode == LW) begin
      //always write to reg FROM Memory
      cuif.MemToReg = 1;
    end else begin
       //always write to reg FROM ALU
      cuif.MemToReg = 0;
    end
  end

  always_comb begin : REG_EN_CONTROLS
    if((cuif.opcode == RTYPE && cuif.opcode != JR) || cuif.opcode == ADDIU || cuif.opcode == ANDI || cuif.opcode == LUI || cuif.opcode == LW || cuif.opcode == ORI || cuif.opcode == SLTI || cuif.opcode == SLTIU || cuif.opcode == SW || cuif.opcode == SW || cuif.opcode == XORI) begin
       cuif.RegWr = 1;
    end else begin
       //default, no write
       cuif.RegWr = 0;
    end
  end



  always_comb begin : ALU_CONTROLS
    if (cuif.opcode == RTYPE) begin
      //do RTYPE operations
      cuif.ALUSrc2 = 1'b0; //Doesnt matter because ALUSrc is 0
      cuif.ALUSrc = 1'b0; //Register
      cuif.ALUctr = ALU_ADD; //some useless default
      casez (cuif.funct)
        ADDU: cuif.ALUctr = ALU_ADD;
        ADD:  cuif.ALUctr = ALU_ADD; //why is this not in asm -i
        AND:  cuif.ALUctr = ALU_AND;
        JR:   cuif.ALUctr = ALU_ADD;
        NOR:  cuif.ALUctr = ALU_NOR;
        OR:   cuif.ALUctr = ALU_OR;
        SLT:  cuif.ALUctr = ALU_SLT;
        SLTU: cuif.ALUctr = ALU_SLTU;
        SLL:  cuif.ALUctr = ALU_SLL;
        SRL:  cuif.ALUctr = ALU_SRL;
        SUBU: cuif.ALUctr = ALU_SUB;
        SUB: cuif.ALUctr = ALU_SUB;
        XOR: cuif.ALUctr = ALU_XOR;
        default: cuif.ALUctr = ALU_ADD;
      endcase
    end else begin
      //I-TYPES
      cuif.ALUctr = ALU_ADD;
      cuif.ALUSrc2 = 1'b0; //Use Sign Extended Imm16
      cuif.ALUSrc = 1'b1; //Sign Extended Imm16
      casez (cuif.opcode) // or funct?
        ANDI: cuif.ALUctr = ALU_AND;
        ADDIU: cuif.ALUctr = ALU_ADD;
        BEQ: cuif.ALUctr = ALU_SUB; // subtract and check zero
        BNE: cuif.ALUctr = ALU_SUB;
        LUI: cuif.ALUctr = ALU_ADD; // or shift left?
        LW: cuif.ALUctr = ALU_ADD;
        ORI: cuif.ALUctr = ALU_OR;
        SLTI: cuif.ALUctr = ALU_SLT;
        SLTIU: cuif.ALUctr = ALU_SLTU;
        SW: cuif.ALUctr = ALU_ADD;
        XORI: cuif.ALUctr = ALU_XOR;
        default: cuif.ALUctr = ALU_ADD;
      endcase
    end
  end
endmodule
