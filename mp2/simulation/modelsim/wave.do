onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label clk /mp2_tb/clk
add wave -noupdate -label pmem_resp /mp2_tb/pmem_resp
add wave -noupdate -label pmem_read /mp2_tb/pmem_read
add wave -noupdate -label pmem_write /mp2_tb/pmem_write
add wave -noupdate -label pmem_address -radix hexadecimal /mp2_tb/pmem_address
add wave -noupdate -label pmem_rdata -radix hexadecimal /mp2_tb/pmem_rdata
add wave -noupdate -label pmem_wdata -radix hexadecimal /mp2_tb/pmem_wdata
add wave -noupdate -label data -radix decimal -childformat {{{/mp2_tb/dut/CPU/Datapath/REGFILE/data[7]} -radix hexadecimal} {{/mp2_tb/dut/CPU/Datapath/REGFILE/data[6]} -radix hexadecimal} {{/mp2_tb/dut/CPU/Datapath/REGFILE/data[5]} -radix hexadecimal} {{/mp2_tb/dut/CPU/Datapath/REGFILE/data[4]} -radix hexadecimal} {{/mp2_tb/dut/CPU/Datapath/REGFILE/data[3]} -radix hexadecimal} {{/mp2_tb/dut/CPU/Datapath/REGFILE/data[2]} -radix hexadecimal} {{/mp2_tb/dut/CPU/Datapath/REGFILE/data[1]} -radix hexadecimal} {{/mp2_tb/dut/CPU/Datapath/REGFILE/data[0]} -radix hexadecimal}} -expand -subitemconfig {{/mp2_tb/dut/CPU/Datapath/REGFILE/data[7]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/CPU/Datapath/REGFILE/data[6]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/CPU/Datapath/REGFILE/data[5]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/CPU/Datapath/REGFILE/data[4]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/CPU/Datapath/REGFILE/data[3]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/CPU/Datapath/REGFILE/data[2]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/CPU/Datapath/REGFILE/data[1]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/CPU/Datapath/REGFILE/data[0]} {-height 15 -radix hexadecimal}} /mp2_tb/dut/CPU/Datapath/REGFILE/data
add wave -noupdate -label state -radix hexadecimal /mp2_tb/dut/CPU/Control/state
add wave -noupdate -label tag -radix hexadecimal -childformat {{{/mp2_tb/dut/CACHE/CACHE_DATAPATH/tag[8]} -radix hexadecimal} {{/mp2_tb/dut/CACHE/CACHE_DATAPATH/tag[7]} -radix hexadecimal} {{/mp2_tb/dut/CACHE/CACHE_DATAPATH/tag[6]} -radix hexadecimal} {{/mp2_tb/dut/CACHE/CACHE_DATAPATH/tag[5]} -radix hexadecimal} {{/mp2_tb/dut/CACHE/CACHE_DATAPATH/tag[4]} -radix hexadecimal} {{/mp2_tb/dut/CACHE/CACHE_DATAPATH/tag[3]} -radix hexadecimal} {{/mp2_tb/dut/CACHE/CACHE_DATAPATH/tag[2]} -radix hexadecimal} {{/mp2_tb/dut/CACHE/CACHE_DATAPATH/tag[1]} -radix hexadecimal} {{/mp2_tb/dut/CACHE/CACHE_DATAPATH/tag[0]} -radix hexadecimal}} -subitemconfig {{/mp2_tb/dut/CACHE/CACHE_DATAPATH/tag[8]} {-height 14 -radix hexadecimal} {/mp2_tb/dut/CACHE/CACHE_DATAPATH/tag[7]} {-height 14 -radix hexadecimal} {/mp2_tb/dut/CACHE/CACHE_DATAPATH/tag[6]} {-height 14 -radix hexadecimal} {/mp2_tb/dut/CACHE/CACHE_DATAPATH/tag[5]} {-height 14 -radix hexadecimal} {/mp2_tb/dut/CACHE/CACHE_DATAPATH/tag[4]} {-height 14 -radix hexadecimal} {/mp2_tb/dut/CACHE/CACHE_DATAPATH/tag[3]} {-height 14 -radix hexadecimal} {/mp2_tb/dut/CACHE/CACHE_DATAPATH/tag[2]} {-height 14 -radix hexadecimal} {/mp2_tb/dut/CACHE/CACHE_DATAPATH/tag[1]} {-height 14 -radix hexadecimal} {/mp2_tb/dut/CACHE/CACHE_DATAPATH/tag[0]} {-height 14 -radix hexadecimal}} /mp2_tb/dut/CACHE/CACHE_DATAPATH/tag
add wave -noupdate -label index -radix hexadecimal /mp2_tb/dut/CACHE/CACHE_DATAPATH/index
add wave -noupdate -label offset -radix hexadecimal /mp2_tb/dut/CACHE/CACHE_DATAPATH/offset
add wave -noupdate -label mem_resp -radix hexadecimal /mp2_tb/dut/CPU/mem_resp
add wave -noupdate -label mem_rdata -radix hexadecimal /mp2_tb/dut/CPU/mem_rdata
add wave -noupdate -label mem_read -radix hexadecimal /mp2_tb/dut/CPU/mem_read
add wave -noupdate -label mem_write -radix hexadecimal /mp2_tb/dut/CPU/mem_write
add wave -noupdate -label mem_byte_enable -radix hexadecimal /mp2_tb/dut/CPU/mem_byte_enable
add wave -noupdate -label mem_address -radix hexadecimal /mp2_tb/dut/CPU/mem_address
add wave -noupdate -label mem_wdata -radix hexadecimal /mp2_tb/dut/CPU/mem_wdata
add wave -noupdate -label cache_state /mp2_tb/dut/CACHE/CACHE_CONTROLLER/state
add wave -noupdate -label tag_array1 -radix hexadecimal /mp2_tb/dut/CACHE/CACHE_DATAPATH/tag_array1/dataout
add wave -noupdate -label tag_array2 -radix hexadecimal /mp2_tb/dut/CACHE/CACHE_DATAPATH/tag_array2/data
add wave -noupdate -label data_array1 -radix hexadecimal -childformat {{{/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array1/data[7]} -radix hexadecimal} {{/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array1/data[6]} -radix hexadecimal} {{/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array1/data[5]} -radix hexadecimal} {{/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array1/data[4]} -radix hexadecimal} {{/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array1/data[3]} -radix hexadecimal} {{/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array1/data[2]} -radix hexadecimal} {{/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array1/data[1]} -radix hexadecimal} {{/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array1/data[0]} -radix hexadecimal}} -subitemconfig {{/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array1/data[7]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array1/data[6]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array1/data[5]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array1/data[4]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array1/data[3]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array1/data[2]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array1/data[1]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array1/data[0]} {-height 15 -radix hexadecimal}} /mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array1/data
add wave -noupdate -label data_array2 -radix hexadecimal -childformat {{{/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array2/data[7]} -radix hexadecimal} {{/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array2/data[6]} -radix hexadecimal} {{/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array2/data[5]} -radix hexadecimal} {{/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array2/data[4]} -radix hexadecimal} {{/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array2/data[3]} -radix hexadecimal} {{/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array2/data[2]} -radix hexadecimal} {{/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array2/data[1]} -radix hexadecimal} {{/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array2/data[0]} -radix hexadecimal}} -subitemconfig {{/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array2/data[7]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array2/data[6]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array2/data[5]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array2/data[4]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array2/data[3]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array2/data[2]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array2/data[1]} {-height 15 -radix hexadecimal} {/mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array2/data[0]} {-height 15 -radix hexadecimal}} /mp2_tb/dut/CACHE/CACHE_DATAPATH/data_array2/data
add wave -noupdate -label hit /mp2_tb/dut/CACHE/CACHE_DATAPATH/hit
add wave -noupdate -label hit1_out /mp2_tb/dut/CACHE/CACHE_DATAPATH/hit1_out
add wave -noupdate -label hit2_out /mp2_tb/dut/CACHE/CACHE_DATAPATH/hit2_out
add wave -noupdate -label lru_in -radix hexadecimal /mp2_tb/dut/CACHE/CACHE_DATAPATH/lru_in
add wave -noupdate -label lru_out -radix hexadecimal /mp2_tb/dut/CACHE/CACHE_DATAPATH/lru_out
add wave -noupdate -label valid1_out -radix hexadecimal /mp2_tb/dut/CACHE/valid1_out
add wave -noupdate -label valid2_out -radix hexadecimal /mp2_tb/dut/CACHE/valid2_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {12904 ps} 0}
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
WaveRestoreZoom {0 ps} {32632 ps}
