onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mp2_tb/clk
add wave -noupdate /mp2_tb/pmem_resp
add wave -noupdate /mp2_tb/pmem_read
add wave -noupdate /mp2_tb/pmem_write
add wave -noupdate /mp2_tb/pmem_address
add wave -noupdate /mp2_tb/pmem_rdata
add wave -noupdate /mp2_tb/pmem_wdata
add wave -noupdate -label clk -radix hexadecimal /mp2_tb/clk
add wave -noupdate -expand /mp2_tb/dut/CPU/Datapath/REGFILE/data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {786022 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 159
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 200000
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {1969 ns} {2001632 ps}
