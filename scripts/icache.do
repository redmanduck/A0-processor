onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /icache_tb/nRST
add wave -noupdate /icache_tb/CLK
add wave -noupdate /icache_tb/i
add wave -noupdate /icache_tb/cycles
add wave -noupdate /icache_tb/CPURAM/addr
add wave -noupdate /icache_tb/DUT/CLK
add wave -noupdate /icache_tb/DUT/CPUID
add wave -noupdate /icache_tb/DUT/dtable
add wave -noupdate /icache_tb/DUT/nRST
add wave -noupdate /icache_tb/DUT/next_state
add wave -noupdate /icache_tb/DUT/rq_index
add wave -noupdate /icache_tb/DUT/rq_tag
add wave -noupdate /icache_tb/DUT/state
add wave -noupdate /icache_tb/DUT/total_set
add wave -noupdate -expand -group dcif /icache_tb/dcif/halt
add wave -noupdate -expand -group dcif /icache_tb/dcif/ihit
add wave -noupdate -expand -group dcif /icache_tb/dcif/imemREN
add wave -noupdate -expand -group dcif /icache_tb/dcif/imemload
add wave -noupdate -expand -group dcif /icache_tb/dcif/imemaddr
add wave -noupdate -expand -group dcif /icache_tb/dcif/dhit
add wave -noupdate -expand -group dcif /icache_tb/dcif/datomic
add wave -noupdate -expand -group dcif /icache_tb/dcif/dmemREN
add wave -noupdate -expand -group dcif /icache_tb/dcif/dmemWEN
add wave -noupdate -expand -group dcif /icache_tb/dcif/flushed
add wave -noupdate -expand -group dcif /icache_tb/dcif/dmemload
add wave -noupdate -expand -group dcif /icache_tb/dcif/dmemstore
add wave -noupdate -expand -group dcif /icache_tb/dcif/dmemaddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2821 ps} 0}
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
WaveRestoreZoom {0 ps} {64 ns}
