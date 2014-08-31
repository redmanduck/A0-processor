ECE437 Processors 
=================

**Register file (register_file.sv)**
- Each location is 32 bits wide.
- The 0th location will have constant value of 0, the remaining 31 locations can store any value
- Values will be stored on the +ve clock edge
- An active low asynchronous reset will reset all modifiable locations to a value of 0x00000000
- 2 read ports each 32 bits wide.
- 1 write ports 32 bits wide.
- Each port has select signal 5 bits wide.
- There is a write enable signal (WEN) 1 bit wide to control storing value to register file.
- 
**ALU**
