onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/clk
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/pmem_resp
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/pmem_rdata
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/pmem_read
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/pmem_write
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/pmem_address
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/pmem_wdata
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/icache_read
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/icache_write
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/icache_wmask
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/icache_address
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/icache_wdata
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/icache_resp
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/icache_rdata
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/dcache_read
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/dcache_write
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/dcache_wmask
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/dcache_address
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/dcache_wdata
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/dcache_resp
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/dcache_rdata
add wave -noupdate -height 15 /mp3_tb/dut/caches/dcache/l1_cc/state
add wave -noupdate -height 15 /mp3_tb/dut/caches/dcache/l1_cc/pmem_read
add wave -noupdate -height 15 /mp3_tb/dut/caches/dcache/l1_cc/pmem_resp
add wave -noupdate -height 15 /mp3_tb/dut/caches/arbiter/cac/cache_read_sel
add wave -noupdate -height 15 /mp3_tb/dut/caches/arbiter/cac/cache_address_sel
add wave -noupdate -height 15 /mp3_tb/dut/caches/arbiter/cac/state
add wave -noupdate -height 15 /mp3_tb/dut/caches/arbiter/l2_read
add wave -noupdate -height 15 /mp3_tb/dut/caches/arbiter/l2_resp
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/pc_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {26368 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 278
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
WaveRestoreZoom {0 ps} {315176 ps}
