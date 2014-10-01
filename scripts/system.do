onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group PLATCH_EXM /system_tb/DUT/CPU/DP/EXMEM/CLK
add wave -noupdate -group PLATCH_EXM /system_tb/DUT/CPU/DP/EXMEM/nRST
add wave -noupdate -group PLATCH_EXM /system_tb/DUT/CPU/DP/EXMEM/WB_MemToReg
add wave -noupdate -group PLATCH_EXM /system_tb/DUT/CPU/DP/EXMEM/WB_RegWrite
add wave -noupdate -group PLATCH_EXM /system_tb/DUT/CPU/DP/EXMEM/M_Branch
add wave -noupdate -group PLATCH_EXM /system_tb/DUT/CPU/DP/EXMEM/M_MemRead
add wave -noupdate -group PLATCH_EXM /system_tb/DUT/CPU/DP/EXMEM/M_MemWrite
add wave -noupdate -group PLATCH_EXM /system_tb/DUT/CPU/DP/EXMEM/alu_zero
add wave -noupdate -group PLATCH_EXM /system_tb/DUT/CPU/DP/EXMEM/alu_output
add wave -noupdate -group PLATCH_EXM /system_tb/DUT/CPU/DP/EXMEM/adder_result
add wave -noupdate -group PLATCH_EXM /system_tb/DUT/CPU/DP/EXMEM/regfile_rdat2
add wave -noupdate -group PLATCH_EXM /system_tb/DUT/CPU/DP/EXMEM/reg_instr
add wave -noupdate -group PLATCH_MW /system_tb/DUT/CPU/DP/MEMWB/CLK
add wave -noupdate -group PLATCH_MW /system_tb/DUT/CPU/DP/MEMWB/nRST
add wave -noupdate -group PLATCH_MW /system_tb/DUT/CPU/DP/MEMWB/dmemload
add wave -noupdate -group PLATCH_MW /system_tb/DUT/CPU/DP/MEMWB/alu_output
add wave -noupdate -group PLATCH_MW /system_tb/DUT/CPU/DP/MEMWB/dmemaddr
add wave -noupdate -group PLATCH_MW /system_tb/DUT/CPU/DP/MEMWB/WB_RegWrite
add wave -noupdate -group PLATCH_MW /system_tb/DUT/CPU/DP/MEMWB/WB_MemToReg
add wave -noupdate -group PLATCH_MW /system_tb/DUT/CPU/DP/MEMWB/reg_instr
add wave -noupdate -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/CLK
add wave -noupdate -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/nRST
add wave -noupdate -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/WB_MemToReg
add wave -noupdate -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/WB_RegWrite
add wave -noupdate -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/M_Branch
add wave -noupdate -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/M_MemRead
add wave -noupdate -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/M_MemWrite
add wave -noupdate -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/EX_RegDst
add wave -noupdate -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/EX_ALUSrc
add wave -noupdate -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/EX_ALUSrc2
add wave -noupdate -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/EX_ALUOp
add wave -noupdate -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/next_address
add wave -noupdate -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/rdat1
add wave -noupdate -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/rdat2
add wave -noupdate -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/sign_ext32
add wave -noupdate -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/rt
add wave -noupdate -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/rd
add wave -noupdate -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/shamt
add wave -noupdate -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/immediate26
add wave -noupdate -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/immediate
add wave -noupdate -expand -group PLATCH_IFID /system_tb/DUT/CPU/DP/IFID/CLK
add wave -noupdate -expand -group PLATCH_IFID /system_tb/DUT/CPU/DP/IFID/nRST
add wave -noupdate -expand -group PLATCH_IFID /system_tb/DUT/CPU/DP/IFID/next_address
add wave -noupdate -expand -group PLATCH_IFID /system_tb/DUT/CPU/DP/IFID/instruction
add wave -noupdate -group PLATCH_ALU /system_tb/DUT/CPU/DP/ALU/ALUOP
add wave -noupdate -group PLATCH_ALU /system_tb/DUT/CPU/DP/ALU/Port_A
add wave -noupdate -group PLATCH_ALU /system_tb/DUT/CPU/DP/ALU/Port_B
add wave -noupdate -group PLATCH_ALU /system_tb/DUT/CPU/DP/ALU/negative
add wave -noupdate -group PLATCH_ALU /system_tb/DUT/CPU/DP/ALU/overflow
add wave -noupdate -group PLATCH_ALU /system_tb/DUT/CPU/DP/ALU/output_port
add wave -noupdate -group PLATCH_ALU /system_tb/DUT/CPU/DP/ALU/zero
add wave -noupdate -expand -group FWUNIT /system_tb/DUT/CPU/DP/FWU/fw_if/ex_rs
add wave -noupdate -expand -group FWUNIT /system_tb/DUT/CPU/DP/FWU/fw_if/ex_rt
add wave -noupdate -expand -group FWUNIT /system_tb/DUT/CPU/DP/FWU/fw_if/mem_rd
add wave -noupdate -expand -group FWUNIT /system_tb/DUT/CPU/DP/FWU/fw_if/wb_rd
add wave -noupdate -expand -group FWUNIT /system_tb/DUT/CPU/DP/FWU/fw_if/forwardA
add wave -noupdate -expand -group FWUNIT /system_tb/DUT/CPU/DP/FWU/fw_if/forwardB
add wave -noupdate -expand /system_tb/DUT/CPU/DP/RF/regs
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/halt
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/iREN
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/dWEN
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/dREN
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/instruction
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/opcode
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/funct
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/rs
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/rt
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/rd
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/shamt
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/immediate
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/immediate26
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/alu_zf
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/MemToReg
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/RegWr
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/MemWr
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/ExtOp
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/ALUctr
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/RegDst
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/PCSrc
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/ALUSrc
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/MemRead
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/ALUSrc2
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/Jump
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/Branch
add wave -noupdate /system_tb/DUT/CPU/halt
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/stall_ifid
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/stall_xmem
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/stall_idex
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/stall_wb
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/flush_ifid
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/flush_xmem
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/flush_idex
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/flush_wb
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/branch
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/pc_en
add wave -noupdate /system_tb/DUT/CPU/CLK
add wave -noupdate /system_tb/DUT/CPU/nRST
add wave -noupdate -expand -group PCIF /system_tb/DUT/CPU/DP/pcif/ihit
add wave -noupdate -expand -group PCIF /system_tb/DUT/CPU/DP/pcif/dhit
add wave -noupdate -expand -group PCIF /system_tb/DUT/CPU/DP/pcif/pc_en
add wave -noupdate -expand -group PCIF /system_tb/DUT/CPU/DP/pcif/PCSrc
add wave -noupdate -expand -group PCIF /system_tb/DUT/CPU/DP/PC/PC
add wave -noupdate -expand -group PCIF /system_tb/DUT/CPU/DP/PC/PC_next
add wave -noupdate -expand -group PCIF /system_tb/DUT/CPU/DP/pcif/rdat1
add wave -noupdate -expand -group PCIF /system_tb/DUT/CPU/DP/pcif/immediate26
add wave -noupdate -expand -group PCIF /system_tb/DUT/CPU/DP/pcif/immediate
add wave -noupdate -expand -group PCIF /system_tb/DUT/CPU/DP/pcif/imemaddr
add wave -noupdate -expand -group PCIF /system_tb/DUT/CPU/DP/pcif/pc_plus_4
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/datomic
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/flushed
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemaddr
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/ALU/ALUOP
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/ALU/Port_A
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/ALU/Port_B
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/ALU/negative
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/ALU/overflow
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/ALU/output_port
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/ALU/zero
add wave -noupdate -expand -group WB /system_tb/DUT/CPU/DP/MEMWB/CLK
add wave -noupdate -expand -group WB /system_tb/DUT/CPU/DP/MEMWB/nRST
add wave -noupdate -expand -group WB /system_tb/DUT/CPU/DP/MEMWB/dmemload
add wave -noupdate -expand -group WB /system_tb/DUT/CPU/DP/MEMWB/alu_output
add wave -noupdate -expand -group WB /system_tb/DUT/CPU/DP/MEMWB/dmemaddr
add wave -noupdate -expand -group WB /system_tb/DUT/CPU/DP/MEMWB/WB_RegWrite
add wave -noupdate -expand -group WB /system_tb/DUT/CPU/DP/MEMWB/WB_MemToReg
add wave -noupdate -expand -group WB /system_tb/DUT/CPU/DP/MEMWB/reg_instr
add wave -noupdate -expand -group WB /system_tb/DUT/CPU/DP/MEMWB/halt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7060 ps} 0}
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
WaveRestoreZoom {0 ps} {530496 ps}
