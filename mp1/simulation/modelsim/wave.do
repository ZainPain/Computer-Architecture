onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label clk -radix hexadecimal /mp1_tb/clk
add wave -noupdate -label PC_out -radix hexadecimal /mp1_tb/dut/Datapath/pc_out
add wave -noupdate -label mem_address -radix hexadecimal /mp1_tb/mem_address
add wave -noupdate -label mem_read -radix hexadecimal /mp1_tb/mem_read
add wave -noupdate -label mem_rdata -radix hexadecimal /mp1_tb/mem_rdata
add wave -noupdate -label mem_write -radix hexadecimal /mp1_tb/mem_write
add wave -noupdate -label mem_byte_enable -radix hexadecimal /mp1_tb/mem_byte_enable
add wave -noupdate -label mem_wdata -radix hexadecimal /mp1_tb/mem_wdata
add wave -noupdate -label {Register 0} -radix hexadecimal {/mp1_tb/dut/Datapath/REGFILE/data[0]}
add wave -noupdate -label {Register 1} -radix hexadecimal {/mp1_tb/dut/Datapath/REGFILE/data[1]}
add wave -noupdate -label {Register 2} -radix hexadecimal {/mp1_tb/dut/Datapath/REGFILE/data[2]}
add wave -noupdate -label {Register 3} -radix hexadecimal {/mp1_tb/dut/Datapath/REGFILE/data[3]}
add wave -noupdate -label {Register 4} -radix hexadecimal {/mp1_tb/dut/Datapath/REGFILE/data[4]}
add wave -noupdate -label {Register 5} -radix hexadecimal {/mp1_tb/dut/Datapath/REGFILE/data[5]}
add wave -noupdate -label {Register 6} -radix hexadecimal {/mp1_tb/dut/Datapath/REGFILE/data[6]}
add wave -noupdate -label {Register 7} -radix hexadecimal {/mp1_tb/dut/Datapath/REGFILE/data[7]}
add wave -noupdate -label States /mp1_tb/dut/Control/state
add wave -noupdate -label alu_out -radix hexadecimal /mp1_tb/dut/Datapath/alu_out
add wave -noupdate -label MAR -radix hexadecimal /mp1_tb/dut/Datapath/MAR/data
add wave -noupdate -label MDR -radix hexadecimal /mp1_tb/dut/Datapath/MDR/data
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
WaveRestoreZoom {507828 ps} {552400 ps}
