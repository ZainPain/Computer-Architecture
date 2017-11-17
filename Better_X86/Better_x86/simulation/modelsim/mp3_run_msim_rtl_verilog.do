transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/lc3b_types.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/decoder.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/mux8.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/l1_cache_control.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/demux2.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/cache_arbiter_control.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/n_bit_counter.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/register.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/plus2.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/mux5.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/mux4.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/mux3.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/mux2.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/adder.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/byte_detect.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/memory_caches.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/l1_cache_datapath.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/cache_arbiter_datapath.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/cache_arbiter.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/branch_logic.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/zext.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/sext.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/regfile.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/gencc.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/cpu_datapath.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/control_rom.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/cc_comp.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/alu.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/adj.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/MEM_WB_reg.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/IF_ID_reg.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/ID_EX_reg.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/EX_MEM_reg.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/Array.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/mp3.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/staller.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/Forwarding.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/l1_cache.sv}

vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/mp3_tb.sv}
vlog -sv -work work +incdir+/home/zpaya2/Better_X86/Better_x86 {/home/zpaya2/Better_X86/Better_x86/physical_memory.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L stratixiii_ver -L rtl_work -L work -voptargs="+acc"  mp3_tb

add wave *
view structure
view signals
run 100 ns
