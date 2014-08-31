ECE437 Processors 
=================
## Register file (register_file.sv)

- Each location is 32 bits wide.
- The 0th location will have constant value of 0, the remaining 31 locations can store any value
- Values will be stored on the +ve clock edge
- An active low asynchronous reset will reset all modifiable locations to a value of 0x00000000
- 2 read ports each 32 bits wide.
- 1 write ports 32 bits wide.
- Each port has select signal 5 bits wide.
- A write enable signal (WEN) 1 bit wide to control storing value to register file.


## ALU (alu.sv)

Purely combinational computational unit of the processor.

- Each port is 32 bits wide
- 2 input ports and 1 output port
- Input a 4 bits wide opcode to select operation to perform
- Output negative, zero and overflow flag bits
- Operations (ALUOP)
  - Logical Shift (left, right), And, Or, Xor, Nor.
  - Signed add/subtract
  - Set less than signed and unsigned
