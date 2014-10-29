onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group PLATCH_EXM /system_tb/DUT/CPU/DP/EXMEM/CLK
add wave -noupdate -expand -group PLATCH_EXM /system_tb/DUT/CPU/DP/EXMEM/nRST
add wave -noupdate -expand -group PLATCH_EXM /system_tb/DUT/CPU/DP/EXMEM/WB_MemToReg
add wave -noupdate -expand -group PLATCH_EXM /system_tb/DUT/CPU/DP/EXMEM/M_Branch
add wave -noupdate -expand -group PLATCH_EXM /system_tb/DUT/CPU/DP/EXMEM/WB_RegWrite
add wave -noupdate -expand -group PLATCH_EXM /system_tb/DUT/CPU/DP/EXMEM/pcn
add wave -noupdate -expand -group PLATCH_EXM /system_tb/DUT/CPU/DP/EXMEM/M_MemRead
add wave -noupdate -expand -group PLATCH_EXM /system_tb/DUT/CPU/DP/EXMEM/M_MemWrite
add wave -noupdate -expand -group PLATCH_EXM /system_tb/DUT/CPU/DP/EXMEM/alu_zero
add wave -noupdate -expand -group PLATCH_EXM /system_tb/DUT/CPU/DP/EXMEM/alu_output
add wave -noupdate -expand -group PLATCH_EXM /system_tb/DUT/CPU/DP/EXMEM/adder_result
add wave -noupdate -expand -group PLATCH_EXM /system_tb/DUT/CPU/DP/EXMEM/regfile_rdat2
add wave -noupdate -expand -group PLATCH_EXM /system_tb/DUT/CPU/DP/EXMEM/reg_instr
add wave -noupdate -expand -group PLATCH_MW /system_tb/DUT/CPU/DP/mweb/WEN
add wave -noupdate -expand -group PLATCH_MW /system_tb/DUT/CPU/DP/mweb/flush
add wave -noupdate -expand -group PLATCH_MW /system_tb/DUT/CPU/DP/MEMWB/CLK
add wave -noupdate -expand -group PLATCH_MW /system_tb/DUT/CPU/DP/MEMWB/nRST
add wave -noupdate -expand -group PLATCH_MW /system_tb/DUT/CPU/DP/MEMWB/dmemload
add wave -noupdate -expand -group PLATCH_MW /system_tb/DUT/CPU/DP/MEMWB/alu_output
add wave -noupdate -expand -group PLATCH_MW /system_tb/DUT/CPU/DP/MEMWB/dmemaddr
add wave -noupdate -expand -group PLATCH_MW /system_tb/DUT/CPU/DP/MEMWB/WB_RegWrite
add wave -noupdate -expand -group PLATCH_MW /system_tb/DUT/CPU/DP/MEMWB/WB_MemToReg
add wave -noupdate -expand -group PLATCH_MW /system_tb/DUT/CPU/DP/MEMWB/reg_instr
add wave -noupdate -expand -group PLATCH_MW /system_tb/DUT/CPU/DP/MEMWB/pcn
add wave -noupdate -expand -group PLATCH_IDEX /system_tb/DUT/CPU/DP/idex/WEN
add wave -noupdate -expand -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/CLK
add wave -noupdate -expand -group PLATCH_IDEX /system_tb/DUT/CPU/DP/xmem/flush
add wave -noupdate -expand -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/pcn
add wave -noupdate -expand -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/nRST
add wave -noupdate -expand -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/WB_MemToReg
add wave -noupdate -expand -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/WB_RegWrite
add wave -noupdate -expand -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/M_Branch
add wave -noupdate -expand -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/M_MemRead
add wave -noupdate -expand -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/M_MemWrite
add wave -noupdate -expand -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/EX_RegDst
add wave -noupdate -expand -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/EX_ALUSrc
add wave -noupdate -expand -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/EX_ALUSrc2
add wave -noupdate -expand -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/EX_ALUOp
add wave -noupdate -expand -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/next_address
add wave -noupdate -expand -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/rdat1
add wave -noupdate -expand -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/rdat2
add wave -noupdate -expand -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/sign_ext32
add wave -noupdate -expand -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/rt
add wave -noupdate -expand -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/rs
add wave -noupdate -expand -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/rd
add wave -noupdate -expand -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/shamt
add wave -noupdate -expand -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/immediate26
add wave -noupdate -expand -group PLATCH_IDEX /system_tb/DUT/CPU/DP/IDEX/immediate
add wave -noupdate -expand -group PLATCH_IFID /system_tb/DUT/CPU/DP/ifid/WEN
add wave -noupdate -expand -group PLATCH_IFID /system_tb/DUT/CPU/DP/fwd_rdat1
add wave -noupdate -expand -group PLATCH_IFID /system_tb/DUT/CPU/DP/fwd_rdat2
add wave -noupdate -expand -group PLATCH_IFID /system_tb/DUT/CPU/DP/ifid/flush
add wave -noupdate -expand -group PLATCH_IFID /system_tb/DUT/CPU/DP/IFID/CLK
add wave -noupdate -expand -group PLATCH_IFID /system_tb/DUT/CPU/DP/IFID/pcn
add wave -noupdate -expand -group PLATCH_IFID /system_tb/DUT/CPU/DP/IFID/nRST
add wave -noupdate -expand -group PLATCH_IFID /system_tb/DUT/CPU/DP/IFID/next_address
add wave -noupdate -expand -group PLATCH_IFID /system_tb/DUT/CPU/DP/IFID/instruction
add wave -noupdate -expand -group PLATCH_ALU /system_tb/DUT/CPU/DP/ALU/ALUOP
add wave -noupdate -expand -group PLATCH_ALU /system_tb/DUT/CPU/DP/ALU/Port_A
add wave -noupdate -expand -group PLATCH_ALU /system_tb/DUT/CPU/DP/ALU/Port_B
add wave -noupdate -expand -group PLATCH_ALU /system_tb/DUT/CPU/DP/ALU/negative
add wave -noupdate -expand -group PLATCH_ALU /system_tb/DUT/CPU/DP/ALU/overflow
add wave -noupdate -expand -group PLATCH_ALU /system_tb/DUT/CPU/DP/ALU/output_port
add wave -noupdate -expand -group PLATCH_ALU /system_tb/DUT/CPU/DP/ALU/zero
add wave -noupdate -expand -group FWUNIT /system_tb/DUT/CPU/DP/FWU/fw_if/memWr
add wave -noupdate -expand -group FWUNIT /system_tb/DUT/CPU/DP/fwif/memRegWr
add wave -noupdate -expand -group FWUNIT /system_tb/DUT/CPU/DP/FWU/fw_if/exMemRead
add wave -noupdate -expand -group FWUNIT /system_tb/DUT/CPU/DP/FWU/fw_if/exMemWr
add wave -noupdate -expand -group FWUNIT /system_tb/DUT/CPU/DP/FWU/fw_if/wbMemRead
add wave -noupdate -expand -group FWUNIT /system_tb/DUT/CPU/DP/FWU/fw_if/wbRegWr
add wave -noupdate -expand -group FWUNIT /system_tb/DUT/CPU/DP/fwif/id_rs
add wave -noupdate -expand -group FWUNIT /system_tb/DUT/CPU/DP/fwif/id_rt
add wave -noupdate -expand -group FWUNIT /system_tb/DUT/CPU/DP/FWU/fw_if/ex_rs
add wave -noupdate -expand -group FWUNIT /system_tb/DUT/CPU/DP/FWU/fw_if/ex_rt
add wave -noupdate -expand -group FWUNIT /system_tb/DUT/CPU/DP/FWU/fw_if/mem_rd
add wave -noupdate -expand -group FWUNIT /system_tb/DUT/CPU/DP/fwif/forwardData
add wave -noupdate -expand -group FWUNIT /system_tb/DUT/CPU/DP/FWU/fw_if/wb_rd
add wave -noupdate -expand -group FWUNIT /system_tb/DUT/CPU/DP/FWU/fw_if/forwardA
add wave -noupdate -expand -group FWUNIT /system_tb/DUT/CPU/DP/FWU/fw_if/forwardB
add wave -noupdate -expand -group FWUNIT /system_tb/DUT/CPU/DP/fwif/forwardR1
add wave -noupdate -expand -group FWUNIT /system_tb/DUT/CPU/DP/fwif/forwardR2
add wave -noupdate /system_tb/DUT/CPU/DP/RF/regs
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
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/branch
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/branch_neq
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/dhit
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/flush_idex
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/flush_ifid
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/flush_wb
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/flush_xmem
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/idex_rs
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/is_equal
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/jump
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/mwb_rd
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/pc_en
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/stall_idex
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/stall_ifid
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/stall_wb
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/stall_xmem
add wave -noupdate -expand -group HAZARDUNIT /system_tb/DUT/CPU/DP/HZU/hzif/take_branch
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
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/rdat2
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
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/iwait
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/dwait
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/iREN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/dREN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/dWEN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/iload
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/dload
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/dstore
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/iaddr
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/daddr
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ccwait
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ccinv
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ccwrite
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/cctrans
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ccsnoopaddr
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramWEN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramREN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramstate
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramaddr
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramstore
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramload
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/CLK
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/nRST
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/LRU
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/cway
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/state
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/next_state
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/rq_tag
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/rq_index
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/hit_out
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/hit0
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/hit1
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/tag_match0
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/tag_match1
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/cur_lru
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/rq_blockoffset
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/FLUSH_INDEX_INCREM_EN
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/which_word
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/write_dirty
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/write_valid
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/CACHE_WEN
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/write_data
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/write_tag
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/flushset
add wave -noupdate -expand -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/flush_index
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {612938 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 231
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
WaveRestoreZoom {608626 ps} {1115816 ps}
