onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /datapath_tb/CLK
add wave -noupdate /datapath_tb/nRST
add wave -noupdate /datapath_tb/DUT/cuif/pc_en
add wave -noupdate /datapath_tb/DUT/RF/CLK
add wave -noupdate /datapath_tb/DUT/RF/nRST
add wave -noupdate /datapath_tb/DUT/RF/regs
add wave -noupdate /datapath_tb/DUT/rfif/WEN
add wave -noupdate /datapath_tb/DUT/rfif/wsel
add wave -noupdate /datapath_tb/DUT/rfif/rsel1
add wave -noupdate /datapath_tb/DUT/rfif/rsel2
add wave -noupdate -radix hexadecimal /datapath_tb/DUT/rfif/wdat
add wave -noupdate /datapath_tb/DUT/rfif/rdat1
add wave -noupdate /datapath_tb/DUT/rfif/rdat2
add wave -noupdate /datapath_tb/DUT/cuif/iREN
add wave -noupdate /datapath_tb/DUT/cuif/dWEN
add wave -noupdate /datapath_tb/DUT/cuif/dREN
add wave -noupdate /datapath_tb/DUT/cuif/instruction
add wave -noupdate /datapath_tb/DUT/cuif/opcode
add wave -noupdate /datapath_tb/DUT/cuif/funct
add wave -noupdate /datapath_tb/DUT/cuif/rs
add wave -noupdate /datapath_tb/DUT/cuif/rt
add wave -noupdate /datapath_tb/DUT/cuif/rd
add wave -noupdate /datapath_tb/DUT/cuif/shamt
add wave -noupdate /datapath_tb/DUT/cuif/immediate
add wave -noupdate /datapath_tb/DUT/cuif/immediate26
add wave -noupdate /datapath_tb/DUT/cuif/alu_zf
add wave -noupdate /datapath_tb/DUT/cuif/MemToReg
add wave -noupdate /datapath_tb/DUT/cuif/RegWr
add wave -noupdate /datapath_tb/DUT/cuif/MemWr
add wave -noupdate /datapath_tb/DUT/ALU/ALUOP
add wave -noupdate /datapath_tb/DUT/ALU/Port_A
add wave -noupdate /datapath_tb/DUT/ALU/Port_B
add wave -noupdate /datapath_tb/DUT/ALU/negative
add wave -noupdate /datapath_tb/DUT/ALU/overflow
add wave -noupdate /datapath_tb/DUT/ALU/output_port
add wave -noupdate /datapath_tb/DUT/ALU/zero
add wave -noupdate /datapath_tb/DUT/cuif/ExtOp
add wave -noupdate /datapath_tb/DUT/cuif/ALUctr
add wave -noupdate /datapath_tb/DUT/cuif/RegDst
add wave -noupdate /datapath_tb/DUT/cuif/PCSrc
add wave -noupdate /datapath_tb/DUT/cuif/ALUSrc
add wave -noupdate /datapath_tb/DUT/cuif/MemRead
add wave -noupdate /datapath_tb/DUT/cuif/ALUSrc2
add wave -noupdate /datapath_tb/DUT/cuif/Jump
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {116 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {99 ns} {225 ns}
