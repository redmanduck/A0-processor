onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/DUT/prif/ramREN
add wave -noupdate /system_tb/DUT/prif/ramWEN
add wave -noupdate /system_tb/DUT/prif/memREN
add wave -noupdate /system_tb/DUT/prif/memWEN
add wave -noupdate /system_tb/DUT/prif/memaddr
add wave -noupdate /system_tb/DUT/prif/memstore
add wave -noupdate /system_tb/DUT/CPU/ccif/iwait
add wave -noupdate /system_tb/DUT/CPU/ccif/dwait
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/datomic
add wave -noupdate /system_tb/DUT/prif/ramstore
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/halt
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/iREN
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/dWEN
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/dREN
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/instruction
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/opcode
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/funct
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/rs
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/rt
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/rd
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/shamt
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/immediate
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/immediate26
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/alu_zf
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/MemToReg
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/RegWr
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/MemWr
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/ExtOp
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/ALUctr
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/RegDst
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/PCSrc
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/ALUSrc
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/MemRead
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/ALUSrc2
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/Jump
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/Branch
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/flushed
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemaddr
add wave -noupdate /system_tb/DUT/CPU/DP/ALU/ALUOP
add wave -noupdate /system_tb/DUT/CPU/DP/ALU/Port_A
add wave -noupdate /system_tb/DUT/CPU/DP/ALU/Port_B
add wave -noupdate /system_tb/DUT/CPU/DP/ALU/negative
add wave -noupdate /system_tb/DUT/CPU/DP/ALU/overflow
add wave -noupdate /system_tb/DUT/CPU/DP/ALU/output_port
add wave -noupdate /system_tb/DUT/CPU/DP/ALU/zero
add wave -noupdate /system_tb/DUT/CPU/ccif/iREN
add wave -noupdate /system_tb/DUT/CPU/ccif/dREN
add wave -noupdate /system_tb/DUT/CPU/ccif/dWEN
add wave -noupdate /system_tb/DUT/CPU/ccif/iload
add wave -noupdate /system_tb/DUT/CPU/ccif/dstore
add wave -noupdate /system_tb/DUT/CPU/ccif/dload
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate -expand -group idex /system_tb/DUT/CPU/DP/IDEX/CLK
add wave -noupdate -expand -group idex /system_tb/DUT/CPU/DP/IDEX/nRST
add wave -noupdate -expand -group idex /system_tb/DUT/CPU/DP/IDEX/WB_MemToReg
add wave -noupdate -expand -group idex /system_tb/DUT/CPU/DP/IDEX/WB_RegWrite
add wave -noupdate -expand -group idex /system_tb/DUT/CPU/DP/IDEX/M_Branch
add wave -noupdate -expand -group idex /system_tb/DUT/CPU/DP/IDEX/M_MemRead
add wave -noupdate -expand -group idex /system_tb/DUT/CPU/DP/IDEX/M_MemWrite
add wave -noupdate -expand -group idex /system_tb/DUT/CPU/DP/IDEX/EX_RegDst
add wave -noupdate -expand -group idex /system_tb/DUT/CPU/DP/IDEX/EX_ALUSrc
add wave -noupdate -expand -group idex /system_tb/DUT/CPU/DP/IDEX/EX_ALUSrc2
add wave -noupdate -expand -group idex /system_tb/DUT/CPU/DP/IDEX/EX_ALUOp
add wave -noupdate -expand -group idex /system_tb/DUT/CPU/DP/IDEX/next_address
add wave -noupdate -expand -group idex /system_tb/DUT/CPU/DP/IDEX/rdat1
add wave -noupdate -expand -group idex /system_tb/DUT/CPU/DP/IDEX/rdat2
add wave -noupdate -expand -group idex /system_tb/DUT/CPU/DP/IDEX/sign_ext32
add wave -noupdate -expand -group idex /system_tb/DUT/CPU/DP/IDEX/rt
add wave -noupdate -expand -group idex /system_tb/DUT/CPU/DP/IDEX/rd
add wave -noupdate -expand -group idex /system_tb/DUT/CPU/DP/IDEX/shamt
add wave -noupdate -expand -group idex /system_tb/DUT/CPU/DP/IDEX/immediate26
add wave -noupdate -expand -group idex /system_tb/DUT/CPU/DP/IDEX/immediate
add wave -noupdate /system_tb/DUT/CPU/DP/ifid/WEN
add wave -noupdate /system_tb/DUT/CPU/DP/ifid/flush
add wave -noupdate /system_tb/DUT/CPU/DP/ifid/next_address_out
add wave -noupdate /system_tb/DUT/CPU/DP/ifid/instruction_out
add wave -noupdate /system_tb/DUT/CPU/DP/ifid/next_address_in
add wave -noupdate /system_tb/DUT/CPU/DP/ifid/instruction_in
add wave -noupdate -childformat {{{/system_tb/DUT/CPU/DP/RF/regs[2]} -radix hexadecimal}} -expand -subitemconfig {{/system_tb/DUT/CPU/DP/RF/regs[2]} {-height 17 -radix hexadecimal}} /system_tb/DUT/CPU/DP/RF/regs
add wave -noupdate /system_tb/DUT/CPU/DP/IFID/CLK
add wave -noupdate /system_tb/DUT/CPU/DP/IFID/nRST
add wave -noupdate /system_tb/DUT/CPU/DP/IFID/next_address
add wave -noupdate /system_tb/DUT/CPU/DP/IFID/instruction
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate /system_tb/DUT/prif/ramaddr
add wave -noupdate /system_tb/DUT/prif/ramload
add wave -noupdate -expand -group exmem /system_tb/DUT/CPU/DP/EXMEM/CLK
add wave -noupdate -expand -group exmem /system_tb/DUT/CPU/DP/EXMEM/nRST
add wave -noupdate -expand -group exmem /system_tb/DUT/CPU/DP/EXMEM/WB_MemToReg
add wave -noupdate -expand -group exmem /system_tb/DUT/CPU/DP/EXMEM/WB_RegWrite
add wave -noupdate -expand -group exmem /system_tb/DUT/CPU/DP/EXMEM/M_Branch
add wave -noupdate -expand -group exmem /system_tb/DUT/CPU/DP/EXMEM/M_MemRead
add wave -noupdate -expand -group exmem /system_tb/DUT/CPU/DP/EXMEM/M_MemWrite
add wave -noupdate -expand -group exmem /system_tb/DUT/CPU/DP/EXMEM/alu_zero
add wave -noupdate -expand -group exmem /system_tb/DUT/CPU/DP/EXMEM/alu_output
add wave -noupdate -expand -group exmem /system_tb/DUT/CPU/DP/EXMEM/adder_result
add wave -noupdate -expand -group exmem /system_tb/DUT/CPU/DP/EXMEM/regfile_rdat2
add wave -noupdate -expand -group exmem /system_tb/DUT/CPU/DP/EXMEM/reg_instr
add wave -noupdate /system_tb/DUT/prif/ramstate
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate /system_tb/DUT/CPU/DP/PC/PC_next
add wave -noupdate /system_tb/DUT/CPU/DP/PC/PC
add wave -noupdate /system_tb/DUT/CPU/DP/PC/pcif/pc_en
add wave -noupdate -radix binary /system_tb/DUT/CPU/DP/cuif/opcode
add wave -noupdate -radix binary /system_tb/DUT/CPU/DP/cuif/funct
add wave -noupdate /system_tb/DUT/CPU/ccif/iaddr
add wave -noupdate /system_tb/DUT/CPU/ccif/daddr
add wave -noupdate /system_tb/DUT/CPU/ccif/ccwait
add wave -noupdate /system_tb/DUT/CPU/ccif/ccinv
add wave -noupdate /system_tb/DUT/CPU/ccif/ccwrite
add wave -noupdate /system_tb/DUT/CPU/ccif/cctrans
add wave -noupdate /system_tb/DUT/CPU/ccif/ccsnoopaddr
add wave -noupdate /system_tb/DUT/CPU/ccif/ramWEN
add wave -noupdate /system_tb/DUT/CPU/ccif/ramREN
add wave -noupdate /system_tb/DUT/CPU/ccif/ramstate
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/instruction
add wave -noupdate /system_tb/DUT/CPU/ccif/ramaddr
add wave -noupdate /system_tb/DUT/CPU/ccif/ramstore
add wave -noupdate /system_tb/DUT/CPU/ccif/ramload
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/iREN
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/dWEN
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/dREN
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/rs
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/rt
add wave -noupdate /system_tb/DUT/CPU/DP/RF/rfif/WEN
add wave -noupdate /system_tb/DUT/CPU/DP/RF/rfif/wsel
add wave -noupdate /system_tb/DUT/CPU/DP/RF/rfif/rsel1
add wave -noupdate /system_tb/DUT/CPU/DP/RF/rfif/rsel2
add wave -noupdate /system_tb/DUT/CPU/DP/RF/rfif/wdat
add wave -noupdate /system_tb/DUT/CPU/DP/RF/rfif/rdat1
add wave -noupdate /system_tb/DUT/CPU/DP/RF/rfif/rdat2
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/rd
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/shamt
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/immediate
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/immediate26
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/alu_zf
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/MemToReg
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/RegWr
add wave -noupdate -expand -group {m web} /system_tb/DUT/CPU/DP/mweb/WEN
add wave -noupdate -expand -group {m web} /system_tb/DUT/CPU/DP/mweb/flush
add wave -noupdate -expand -group {m web} /system_tb/DUT/CPU/DP/mweb/WB_MemToReg_in
add wave -noupdate -expand -group {m web} /system_tb/DUT/CPU/DP/mweb/WB_MemToReg_out
add wave -noupdate -expand -group {m web} /system_tb/DUT/CPU/DP/mweb/dmemload_in
add wave -noupdate -expand -group {m web} /system_tb/DUT/CPU/DP/mweb/dmemload_out
add wave -noupdate -expand -group {m web} /system_tb/DUT/CPU/DP/mweb/dmemaddr_in
add wave -noupdate -expand -group {m web} /system_tb/DUT/CPU/DP/mweb/dmemaddr_out
add wave -noupdate -expand -group {m web} /system_tb/DUT/CPU/DP/mweb/WB_RegWrite_in
add wave -noupdate -expand -group {m web} /system_tb/DUT/CPU/DP/mweb/WB_RegWrite_out
add wave -noupdate -expand -group {m web} /system_tb/DUT/CPU/DP/mweb/reg_instr_in
add wave -noupdate -expand -group {m web} /system_tb/DUT/CPU/DP/mweb/reg_instr_out
add wave -noupdate -expand -group {m web} /system_tb/DUT/CPU/DP/mweb/alu_output_in
add wave -noupdate -expand -group {m web} /system_tb/DUT/CPU/DP/mweb/alu_output_out
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/MemWr
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/ExtOp
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/ALUctr
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/RegDst
add wave -noupdate /system_tb/DUT/CPU/DP/alu_output
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/PCSrc
add wave -noupdate /system_tb/DUT/CPU/DP/PC/pcif/ihit
add wave -noupdate /system_tb/DUT/CPU/DP/PC/pcif/dhit
add wave -noupdate /system_tb/DUT/CPU/DP/PC/pcif/pc_en
add wave -noupdate /system_tb/DUT/CPU/DP/PC/CLK
add wave -noupdate /system_tb/DUT/CPU/DP/PC/nRST
add wave -noupdate /system_tb/DUT/CPU/DP/PC/PC_next
add wave -noupdate /system_tb/DUT/CPU/DP/PC/PC
add wave -noupdate /system_tb/DUT/CPU/DP/PC/pc_4
add wave -noupdate /system_tb/DUT/CPU/DP/PC/pcif/PCSrc
add wave -noupdate /system_tb/DUT/CPU/DP/PC/pcif/rdat1
add wave -noupdate /system_tb/DUT/CPU/DP/PC/pcif/immediate26
add wave -noupdate /system_tb/DUT/CPU/DP/PC/pcif/imemaddr
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/ALUSrc
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/MemRead
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/ALUSrc2
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/Jump
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {400000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 101
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {655884933 ps} {656090267 ps}
