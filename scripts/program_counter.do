onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /program_counter_tb/CLK
add wave -noupdate /program_counter_tb/nRST
add wave -noupdate /program_counter_tb/ihit
add wave -noupdate /program_counter_tb/dhit
add wave -noupdate /program_counter_tb/DUT/CLK
add wave -noupdate /program_counter_tb/DUT/nRST
add wave -noupdate /program_counter_tb/DUT/ihit
add wave -noupdate /program_counter_tb/DUT/dhit
add wave -noupdate /program_counter_tb/DUT/PC_next
add wave -noupdate /program_counter_tb/DUT/PC
add wave -noupdate /program_counter_tb/RFDUT/CLK
add wave -noupdate /program_counter_tb/RFDUT/nRST
add wave -noupdate /program_counter_tb/RFDUT/regs
add wave -noupdate /program_counter_tb/cuif/pc_en
add wave -noupdate /program_counter_tb/cuif/iREN
add wave -noupdate /program_counter_tb/cuif/dWEN
add wave -noupdate /program_counter_tb/cuif/dREN
add wave -noupdate /program_counter_tb/cuif/instruction
add wave -noupdate /program_counter_tb/cuif/opcode
add wave -noupdate /program_counter_tb/cuif/funct
add wave -noupdate /program_counter_tb/cuif/rs
add wave -noupdate /program_counter_tb/cuif/rt
add wave -noupdate /program_counter_tb/cuif/rd
add wave -noupdate /program_counter_tb/cuif/shamt
add wave -noupdate /program_counter_tb/cuif/immediate
add wave -noupdate /program_counter_tb/cuif/immediate26
add wave -noupdate /program_counter_tb/cuif/alu_zf
add wave -noupdate /program_counter_tb/cuif/MemToReg
add wave -noupdate /program_counter_tb/cuif/RegWr
add wave -noupdate /program_counter_tb/cuif/MemWr
add wave -noupdate /program_counter_tb/cuif/ExtOp
add wave -noupdate /program_counter_tb/cuif/ALUctr
add wave -noupdate /program_counter_tb/cuif/RegDst
add wave -noupdate /program_counter_tb/cuif/PCSrc
add wave -noupdate /program_counter_tb/cuif/ALUSrc
add wave -noupdate /program_counter_tb/cuif/MemRead
add wave -noupdate /program_counter_tb/cuif/ALUSrc2
add wave -noupdate /program_counter_tb/cuif/Jump
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {88 ns} 0}
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
WaveRestoreZoom {0 ns} {1 us}
