onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dcache_tb/nRST
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/RAMCLK
add wave -noupdate /dcache_tb/i
add wave -noupdate -group dpif /dcache_tb/DUT/dpif/halt
add wave -noupdate -group dpif /dcache_tb/DUT/dpif/ihit
add wave -noupdate -group dpif /dcache_tb/DUT/dpif/imemREN
add wave -noupdate -group dpif /dcache_tb/DUT/dpif/imemload
add wave -noupdate -group dpif /dcache_tb/DUT/dpif/imemaddr
add wave -noupdate -group dpif /dcache_tb/DUT/dpif/dhit
add wave -noupdate -group dpif /dcache_tb/DUT/dpif/datomic
add wave -noupdate -group dpif /dcache_tb/DUT/dpif/dmemREN
add wave -noupdate -group dpif /dcache_tb/DUT/dpif/dmemWEN
add wave -noupdate -group dpif /dcache_tb/DUT/dpif/flushed
add wave -noupdate -group dpif /dcache_tb/DUT/dpif/dmemload
add wave -noupdate -group dpif /dcache_tb/DUT/dpif/dmemstore
add wave -noupdate -group dpif /dcache_tb/DUT/dpif/dmemaddr
add wave -noupdate -group ccif /dcache_tb/DUT/ccif/iwait
add wave -noupdate -group ccif /dcache_tb/DUT/ccif/dwait
add wave -noupdate -group ccif /dcache_tb/DUT/ccif/iREN
add wave -noupdate -group ccif /dcache_tb/DUT/ccif/dREN
add wave -noupdate -group ccif /dcache_tb/DUT/ccif/dWEN
add wave -noupdate -group ccif /dcache_tb/DUT/ccif/iload
add wave -noupdate -group ccif /dcache_tb/DUT/ccif/dload
add wave -noupdate -group ccif /dcache_tb/DUT/ccif/dstore
add wave -noupdate -group ccif /dcache_tb/DUT/ccif/iaddr
add wave -noupdate -group ccif /dcache_tb/DUT/ccif/daddr
add wave -noupdate -group ccif /dcache_tb/DUT/ccif/ccwait
add wave -noupdate -group ccif /dcache_tb/DUT/ccif/ccinv
add wave -noupdate -group ccif /dcache_tb/DUT/ccif/ccwrite
add wave -noupdate -group ccif /dcache_tb/DUT/ccif/cctrans
add wave -noupdate -group ccif /dcache_tb/DUT/ccif/ccsnoopaddr
add wave -noupdate -group ccif /dcache_tb/DUT/ccif/ramWEN
add wave -noupdate -group ccif /dcache_tb/DUT/ccif/ramREN
add wave -noupdate -group ccif /dcache_tb/DUT/ccif/ramstate
add wave -noupdate -group ccif /dcache_tb/DUT/ccif/ramaddr
add wave -noupdate -group ccif /dcache_tb/DUT/ccif/ramstore
add wave -noupdate -group ccif /dcache_tb/DUT/ccif/ramload
add wave -noupdate -group DUT /dcache_tb/DUT/CLK
add wave -noupdate -group DUT /dcache_tb/DUT/nRST
add wave -noupdate -group DUT /dcache_tb/DUT/LRU
add wave -noupdate -group DUT /dcache_tb/DUT/cway
add wave -noupdate -group DUT /dcache_tb/DUT/state
add wave -noupdate -group DUT /dcache_tb/DUT/next_state
add wave -noupdate -group DUT /dcache_tb/DUT/rq_tag
add wave -noupdate -group DUT /dcache_tb/DUT/rq_index
add wave -noupdate -group DUT /dcache_tb/DUT/hit_out
add wave -noupdate -group DUT /dcache_tb/DUT/hit0
add wave -noupdate -group DUT /dcache_tb/DUT/hit1
add wave -noupdate -group DUT /dcache_tb/DUT/tag_match0
add wave -noupdate -group DUT /dcache_tb/DUT/tag_match1
add wave -noupdate -group DUT /dcache_tb/DUT/cur_lru
add wave -noupdate -group DUT /dcache_tb/DUT/rq_blockoffset
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
WaveRestoreZoom {0 ps} {1 us}
