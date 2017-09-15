transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/zpaya2/ece411/mp1 {/home/zpaya2/ece411/mp1/lc3b_types.sv}
vlog -sv -work work +incdir+/home/zpaya2/ece411/mp1 {/home/zpaya2/ece411/mp1/plus2.sv}
vlog -sv -work work +incdir+/home/zpaya2/ece411/mp1 {/home/zpaya2/ece411/mp1/register.sv}
vlog -sv -work work +incdir+/home/zpaya2/ece411/mp1 {/home/zpaya2/ece411/mp1/mux2.sv}
vlog -sv -work work +incdir+/home/zpaya2/ece411/mp1 {/home/zpaya2/ece411/mp1/mux3.sv}
vlog -sv -work work +incdir+/home/zpaya2/ece411/mp1 {/home/zpaya2/ece411/mp1/mux4.sv}
vlog -sv -work work +incdir+/home/zpaya2/ece411/mp1 {/home/zpaya2/ece411/mp1/adj.sv}
vlog -sv -work work +incdir+/home/zpaya2/ece411/mp1 {/home/zpaya2/ece411/mp1/alu.sv}
vlog -sv -work work +incdir+/home/zpaya2/ece411/mp1 {/home/zpaya2/ece411/mp1/control.sv}
vlog -sv -work work +incdir+/home/zpaya2/ece411/mp1 {/home/zpaya2/ece411/mp1/gencc.sv}
vlog -sv -work work +incdir+/home/zpaya2/ece411/mp1 {/home/zpaya2/ece411/mp1/ir.sv}
vlog -sv -work work +incdir+/home/zpaya2/ece411/mp1 {/home/zpaya2/ece411/mp1/regfile.sv}
vlog -sv -work work +incdir+/home/zpaya2/ece411/mp1 {/home/zpaya2/ece411/mp1/adder.sv}
vlog -sv -work work +incdir+/home/zpaya2/ece411/mp1 {/home/zpaya2/ece411/mp1/cccomp.sv}
vlog -sv -work work +incdir+/home/zpaya2/ece411/mp1 {/home/zpaya2/ece411/mp1/adj_imm.sv}
vlog -sv -work work +incdir+/home/zpaya2/ece411/mp1 {/home/zpaya2/ece411/mp1/mask.sv}
vlog -sv -work work +incdir+/home/zpaya2/ece411/mp1 {/home/zpaya2/ece411/mp1/truncator.sv}
vlog -sv -work work +incdir+/home/zpaya2/ece411/mp1 {/home/zpaya2/ece411/mp1/datapath.sv}
vlog -sv -work work +incdir+/home/zpaya2/ece411/mp1 {/home/zpaya2/ece411/mp1/mp1.sv}

vlog -sv -work work +incdir+/home/zpaya2/ece411/mp1 {/home/zpaya2/ece411/mp1/mp1_tb.sv}
vlog -sv -work work +incdir+/home/zpaya2/ece411/mp1 {/home/zpaya2/ece411/mp1/memory.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L stratixiii_ver -L rtl_work -L work -voptargs="+acc"  mp1_tb

add wave *
view structure
view signals
run 200 ns
