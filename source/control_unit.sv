/*
  Pat Sabpisal
  ssabpisa@purdue.edu
*/
`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"

//TODO: remove nRST and CLK from control unit
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

  assign cuif.iREN = (cuif.opcode != HALT);
  //use dREN and dWEN as request signal
  assign cuif.dREN = cuif.MemToReg;
  assign cuif.dWEN = cuif.MemWr;
  //maybe refactorable?
  assign cuif.RegDst = (cuif.opcode == LW || cuif.opcode == ORI || cuif.opcode == ADDIU || cuif.opcode == ANDI || cuif.opcode == LUI || cuif.opcode == LW || cuif.opcode == SLTI || cuif.opcode == SLTIU ? 0 : 1); //RTYPE
//  assign cuif.ExtOp = (cuif.opcode == ORI ? 0 : cuif.immediate[15]); //SIGN of immediate?? or immediate26

  always_comb begin : EXTOP
    casez(cuif.opcode)
      ORI: cuif.ExtOp = 0;
      default: cuif.ExtOp = cuif.immediate[15];
    endcase
  end


  //assign cuif.LUIOP

//  assign cuif.halt = (cuif.opcode == HALT);
  //if uncomment below, halt signal become 0 ,
  //everythings BREAK!!


  always_comb begin : HALTER
    casez(cuif.opcode)
      HALT: cuif.halt = 1;
      default: cuif.halt = 0;
    endcase
  end

 //TODO: latch the halt

  always_comb begin : PC_CONTROLS
    cuif.Jump = 1'b0; //for what?
    if(cuif.opcode == JR) begin
       cuif.PCSrc = 0; //read Rs
       cuif.Jump = 1'b1;
    end else if(cuif.opcode == J || cuif.opcode == JAL) begin
       cuif.PCSrc = 1; //where does Link occur
       cuif.Jump = 1'b1;
    end else if(cuif.opcode == BEQ && cuif.alu_zf || cuif.opcode == BNE && !cuif.alu_zf) begin
       cuif.PCSrc = 2;
       cuif.Jump = 1'b0;
    end else begin
       cuif.PCSrc = 4; //normal mode otherwise
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
