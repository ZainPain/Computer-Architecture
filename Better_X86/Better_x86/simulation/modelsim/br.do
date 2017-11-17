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
add wave -noupdate -height 15 -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/clk
add wave -noupdate -height 15 -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/load
add wave -noupdate -height 15 -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/reset
add wave -noupdate -height 15 -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/inst_in
add wave -noupdate -height 15 -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/pc_in
add wave -noupdate -height 15 -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/inst_out
add wave -noupdate -height 15 -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/pc_out
add wave -noupdate -height 15 -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/offset6
add wave -noupdate -height 15 -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/imm5
add wave -noupdate -height 15 -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/imm4
add wave -noupdate -height 15 -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/trap_vect8
add wave -noupdate -height 15 -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/offset11
add wave -noupdate -height 15 -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/offset9
add wave -noupdate -height 15 -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/dest
add wave -noupdate -height 15 -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/sr1
add wave -noupdate -height 15 -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/sr2
add wave -noupdate -height 15 -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/opcode
add wave -noupdate -height 15 -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/ir11
add wave -noupdate -height 15 -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/ir5
add wave -noupdate -height 15 -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/ir4
add wave -noupdate -height 15 -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/pc_value
add wave -noupdate -height 15 -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/instruction
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/clk
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/load
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/reset
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/inst_in
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/pc_in
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/control_in
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/reg_a
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/reg_b
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/dest_in
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/sext6_in
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/sext5_in
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/sext4_in
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/adj6_in
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/adj9_in
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/adj11_in
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/trap_vect8_in
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/inst_out
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/pc_out
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/control_out
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/sr1
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/sr2
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/dest_out
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/sext6_out
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/sext5_out
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/sext4_out
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/adj6_out
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/adj9_out
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/adj11_out
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/trap_vect8_out
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/control
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/instruction
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/pc_value
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/data_a
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/data_b
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/dest
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/sext6
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/sext5
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/sext4
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/adj6
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/adj9
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/adj11
add wave -noupdate -height 15 -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/trap_vect8
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/clk
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/load
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/reset
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/inst_in
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/pc_in
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/control_in
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/alu_out_in
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/sr2_in
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/dest_in
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/trap_vect8_in
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/branch_address_in
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/inst_out
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/pc_out
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/control_out
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/alu_out_out
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/sr2_out
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/dest_out
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/trap_vect8_out
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/branch_address_out
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/control
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/instruction
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/pc_value
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/alu_value
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/sr2
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/branch_address
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/dest
add wave -noupdate -height 15 -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/trap_vect8
add wave -noupdate -height 15 -expand -group MEM_WB -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/clk
add wave -noupdate -height 15 -expand -group MEM_WB -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/load
add wave -noupdate -height 15 -expand -group MEM_WB -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/reset
add wave -noupdate -height 15 -expand -group MEM_WB -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/inst_in
add wave -noupdate -height 15 -expand -group MEM_WB -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/pc_in
add wave -noupdate -height 15 -expand -group MEM_WB -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/control_in
add wave -noupdate -height 15 -expand -group MEM_WB -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/alu_out_in
add wave -noupdate -height 15 -expand -group MEM_WB -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/mem_out_in
add wave -noupdate -height 15 -expand -group MEM_WB -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/branch_address_in
add wave -noupdate -height 15 -expand -group MEM_WB -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/sr2_in
add wave -noupdate -height 15 -expand -group MEM_WB -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/dest_in
add wave -noupdate -height 15 -expand -group MEM_WB -height 15 -radix hexadecimal -childformat {{/mp3_tb/dut/cpu_d/MEM_WB/control_out.opcode -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.aluop -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.load_cc -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.load_regfile -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.load_pc -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.addermux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.regfilemux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.ldbmux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.datamux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.pcmux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.alumux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.writemux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.storemux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.mem_read -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.mem_write -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.load_IF_ID -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.load_ID_EX -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.load_EX_MEM -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.load_MEM_WB -radix hexadecimal}} -subitemconfig {/mp3_tb/dut/cpu_d/MEM_WB/control_out.opcode {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.aluop {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.load_cc {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.load_regfile {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.load_pc {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.addermux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.regfilemux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.ldbmux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.datamux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.pcmux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.alumux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.writemux_sel {-height 12 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.storemux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.mem_read {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.mem_write {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.load_IF_ID {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.load_ID_EX {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.load_EX_MEM {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.load_MEM_WB {-height 15 -radix hexadecimal}} /mp3_tb/dut/cpu_d/MEM_WB/control_out
add wave -noupdate -height 15 -expand -group MEM_WB -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/pc_out
add wave -noupdate -height 15 -expand -group MEM_WB -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/alu_out_out
add wave -noupdate -height 15 -expand -group MEM_WB -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/mem_out_out
add wave -noupdate -height 15 -expand -group MEM_WB -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/branch_address_out
add wave -noupdate -height 15 -expand -group MEM_WB -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/sr2_out
add wave -noupdate -height 15 -expand -group MEM_WB -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/dest_out
add wave -noupdate -height 15 -expand -group MEM_WB -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/control
add wave -noupdate -height 15 -expand -group MEM_WB -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/instruction
add wave -noupdate -height 15 -expand -group MEM_WB -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/pc_value
add wave -noupdate -height 15 -expand -group MEM_WB -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/alu_value
add wave -noupdate -height 15 -expand -group MEM_WB -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/mem_out
add wave -noupdate -height 15 -expand -group MEM_WB -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/branch_address
add wave -noupdate -height 15 -expand -group MEM_WB -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/sr2
add wave -noupdate -height 15 -expand -group MEM_WB -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/dest
add wave -noupdate -height 15 /mp3_tb/dut/cpu_d/MEM_WB/dest_in
add wave -noupdate -height 15 -expand -group CC_REG -height 15 /mp3_tb/dut/cpu_d/CC/out
add wave -noupdate -height 15 -expand -group CC_REG -height 15 /mp3_tb/dut/cpu_d/CC/load
add wave -noupdate -height 15 -expand -group CC_REG -height 15 /mp3_tb/dut/cpu_d/CC/in
add wave -noupdate -height 15 -expand -group CC_REG -height 15 /mp3_tb/dut/cpu_d/CC/data
add wave -noupdate -height 15 -expand -group GENCC -height 15 /mp3_tb/dut/cpu_d/GENCC/in
add wave -noupdate -height 15 -expand -group GENCC -height 15 /mp3_tb/dut/cpu_d/GENCC/out
add wave -noupdate -height 15 -expand -group CCCOMP -height 15 /mp3_tb/dut/cpu_d/CCCOMP/dest
add wave -noupdate -height 15 -expand -group CCCOMP -height 15 /mp3_tb/dut/cpu_d/CCCOMP/nzp
add wave -noupdate -height 15 -expand -group CCCOMP -height 15 /mp3_tb/dut/cpu_d/CCCOMP/out
add wave -noupdate -height 15 -expand -group BRANCH_LOGIC -height 15 /mp3_tb/dut/cpu_d/BRANCH_LOGIC/opcode
add wave -noupdate -height 15 -expand -group BRANCH_LOGIC -height 15 /mp3_tb/dut/cpu_d/BRANCH_LOGIC/branch_enable
add wave -noupdate -height 15 -expand -group BRANCH_LOGIC -height 15 /mp3_tb/dut/cpu_d/BRANCH_LOGIC/pcmux_sel
add wave -noupdate -height 15 -expand -group BRANCH_LOGIC -height 15 /mp3_tb/dut/cpu_d/BRANCH_LOGIC/pcmux_sel_updated
add wave -noupdate -height 15 -expand -group PCMUX -height 15 /mp3_tb/dut/cpu_d/PC_MUX/sel
add wave -noupdate -height 15 -expand -group PCMUX -height 15 /mp3_tb/dut/cpu_d/PC_MUX/a
add wave -noupdate -height 15 -expand -group PCMUX -height 15 /mp3_tb/dut/cpu_d/PC_MUX/b
add wave -noupdate -height 15 -expand -group PCMUX -height 15 /mp3_tb/dut/cpu_d/PC_MUX/c
add wave -noupdate -height 15 -expand -group PCMUX -height 15 /mp3_tb/dut/cpu_d/PC_MUX/d
add wave -noupdate -height 15 -expand -group PCMUX -height 15 /mp3_tb/dut/cpu_d/PC_MUX/e
add wave -noupdate -height 15 -expand -group PCMUX -height 15 /mp3_tb/dut/cpu_d/PC_MUX/f
add wave -noupdate -height 15 -expand -group PC -height 15 /mp3_tb/dut/cpu_d/PC/load
add wave -noupdate -height 15 -expand -group PC -height 15 /mp3_tb/dut/cpu_d/PC/in
add wave -noupdate -height 15 -expand -group PC -height 15 /mp3_tb/dut/cpu_d/PC/out
add wave -noupdate -height 15 -expand -group PC -height 15 /mp3_tb/dut/cpu_d/PC/data
add wave -noupdate -height 15 -radix decimal /mp3_tb/dut/cpu_d/pc_out
add wave -noupdate -height 15 -expand -group PC+2 -height 15 /mp3_tb/dut/cpu_d/PC_PLUS2/in
add wave -noupdate -height 15 -expand -group PC+2 -height 15 /mp3_tb/dut/cpu_d/PC_PLUS2/out
add wave -noupdate -height 15 -expand -group LDI_STI_count -height 15 /mp3_tb/dut/cpu_d/LDI_STI_counter/clk
add wave -noupdate -height 15 -expand -group LDI_STI_count -height 15 /mp3_tb/dut/cpu_d/LDI_STI_counter/mem_resp
add wave -noupdate -height 15 -expand -group LDI_STI_count -height 15 /mp3_tb/dut/cpu_d/LDI_STI_counter/mem_read
add wave -noupdate -height 15 -expand -group LDI_STI_count -height 15 /mp3_tb/dut/cpu_d/LDI_STI_counter/mem_write
add wave -noupdate -height 15 -expand -group LDI_STI_count -height 15 /mp3_tb/dut/cpu_d/LDI_STI_counter/cache_misses
add wave -noupdate -height 15 -expand -group LDI_STI_count -height 15 /mp3_tb/dut/cpu_d/LDI_STI_counter/counter
add wave -noupdate -height 15 -expand -group LDI_STI_count -height 15 /mp3_tb/dut/cpu_d/LDI_STI_counter/make_conditions_shorter
add wave -noupdate -height 15 -expand -group {MEM_WB stall} -height 15 /mp3_tb/dut/cpu_d/MEM_WB_stall/clk
add wave -noupdate -height 15 -expand -group {MEM_WB stall} -height 15 /mp3_tb/dut/cpu_d/MEM_WB_stall/op_code
add wave -noupdate -height 15 -expand -group {MEM_WB stall} -height 15 /mp3_tb/dut/cpu_d/MEM_WB_stall/load
add wave -noupdate -height 15 -expand -group {MEM_WB stall} -height 15 /mp3_tb/dut/cpu_d/MEM_WB_stall/resp
add wave -noupdate -height 15 -expand -group {MEM_WB stall} -height 15 /mp3_tb/dut/cpu_d/MEM_WB_stall/mem_read
add wave -noupdate -height 15 -expand -group {MEM_WB stall} -height 15 /mp3_tb/dut/cpu_d/MEM_WB_stall/mem_write
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/load_IF_ID
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/load_ID_EX
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/load_EX_MEM
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/load_MEM_WB
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/opcode
add wave -noupdate -height 15 -label {ID_EX control} -radix hexadecimal -childformat {{/mp3_tb/dut/cpu_d/ID_EX/control.opcode -radix hexadecimal} {/mp3_tb/dut/cpu_d/ID_EX/control.aluop -radix hexadecimal} {/mp3_tb/dut/cpu_d/ID_EX/control.load_cc -radix hexadecimal} {/mp3_tb/dut/cpu_d/ID_EX/control.load_regfile -radix hexadecimal} {/mp3_tb/dut/cpu_d/ID_EX/control.load_pc -radix hexadecimal} {/mp3_tb/dut/cpu_d/ID_EX/control.addermux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/ID_EX/control.regfilemux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/ID_EX/control.ldbmux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/ID_EX/control.datamux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/ID_EX/control.pcmux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/ID_EX/control.alumux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/ID_EX/control.writemux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/ID_EX/control.storemux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/ID_EX/control.mem_read -radix hexadecimal} {/mp3_tb/dut/cpu_d/ID_EX/control.mem_write -radix hexadecimal} {/mp3_tb/dut/cpu_d/ID_EX/control.load_IF_ID -radix hexadecimal} {/mp3_tb/dut/cpu_d/ID_EX/control.load_ID_EX -radix hexadecimal} {/mp3_tb/dut/cpu_d/ID_EX/control.load_EX_MEM -radix hexadecimal} {/mp3_tb/dut/cpu_d/ID_EX/control.load_MEM_WB -radix hexadecimal}} -subitemconfig {/mp3_tb/dut/cpu_d/ID_EX/control.opcode {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/ID_EX/control.aluop {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/ID_EX/control.load_cc {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/ID_EX/control.load_regfile {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/ID_EX/control.load_pc {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/ID_EX/control.addermux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/ID_EX/control.regfilemux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/ID_EX/control.ldbmux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/ID_EX/control.datamux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/ID_EX/control.pcmux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/ID_EX/control.alumux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/ID_EX/control.writemux_sel {-height 12 -radix hexadecimal} /mp3_tb/dut/cpu_d/ID_EX/control.storemux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/ID_EX/control.mem_read {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/ID_EX/control.mem_write {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/ID_EX/control.load_IF_ID {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/ID_EX/control.load_ID_EX {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/ID_EX/control.load_EX_MEM {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/ID_EX/control.load_MEM_WB {-height 15 -radix hexadecimal}} /mp3_tb/dut/cpu_d/ID_EX/control
add wave -noupdate -height 15 -label {EX_MEM control} -radix hexadecimal -childformat {{/mp3_tb/dut/cpu_d/EX_MEM/control.opcode -radix hexadecimal} {/mp3_tb/dut/cpu_d/EX_MEM/control.aluop -radix hexadecimal} {/mp3_tb/dut/cpu_d/EX_MEM/control.load_cc -radix hexadecimal} {/mp3_tb/dut/cpu_d/EX_MEM/control.load_regfile -radix hexadecimal} {/mp3_tb/dut/cpu_d/EX_MEM/control.load_pc -radix hexadecimal} {/mp3_tb/dut/cpu_d/EX_MEM/control.addermux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/EX_MEM/control.regfilemux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/EX_MEM/control.ldbmux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/EX_MEM/control.datamux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/EX_MEM/control.pcmux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/EX_MEM/control.alumux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/EX_MEM/control.writemux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/EX_MEM/control.storemux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/EX_MEM/control.mem_read -radix hexadecimal} {/mp3_tb/dut/cpu_d/EX_MEM/control.mem_write -radix hexadecimal} {/mp3_tb/dut/cpu_d/EX_MEM/control.load_IF_ID -radix hexadecimal} {/mp3_tb/dut/cpu_d/EX_MEM/control.load_ID_EX -radix hexadecimal} {/mp3_tb/dut/cpu_d/EX_MEM/control.load_EX_MEM -radix hexadecimal} {/mp3_tb/dut/cpu_d/EX_MEM/control.load_MEM_WB -radix hexadecimal}} -subitemconfig {/mp3_tb/dut/cpu_d/EX_MEM/control.opcode {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/EX_MEM/control.aluop {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/EX_MEM/control.load_cc {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/EX_MEM/control.load_regfile {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/EX_MEM/control.load_pc {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/EX_MEM/control.addermux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/EX_MEM/control.regfilemux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/EX_MEM/control.ldbmux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/EX_MEM/control.datamux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/EX_MEM/control.pcmux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/EX_MEM/control.alumux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/EX_MEM/control.writemux_sel {-height 12 -radix hexadecimal} /mp3_tb/dut/cpu_d/EX_MEM/control.storemux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/EX_MEM/control.mem_read {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/EX_MEM/control.mem_write {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/EX_MEM/control.load_IF_ID {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/EX_MEM/control.load_ID_EX {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/EX_MEM/control.load_EX_MEM {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/EX_MEM/control.load_MEM_WB {-height 15 -radix hexadecimal}} /mp3_tb/dut/cpu_d/EX_MEM/control
add wave -noupdate -height 15 -label {MEM_WB control} -radix hexadecimal -childformat {{/mp3_tb/dut/cpu_d/MEM_WB/control.opcode -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control.aluop -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control.load_cc -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control.load_regfile -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control.load_pc -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control.addermux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control.regfilemux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control.ldbmux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control.datamux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control.pcmux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control.alumux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control.writemux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control.storemux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control.mem_read -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control.mem_write -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control.load_IF_ID -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control.load_ID_EX -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control.load_EX_MEM -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control.load_MEM_WB -radix hexadecimal}} -subitemconfig {/mp3_tb/dut/cpu_d/MEM_WB/control.opcode {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control.aluop {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control.load_cc {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control.load_regfile {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control.load_pc {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control.addermux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control.regfilemux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control.ldbmux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control.datamux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control.pcmux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control.alumux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control.writemux_sel {-height 12 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control.storemux_sel {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control.mem_read {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control.mem_write {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control.load_IF_ID {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control.load_ID_EX {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control.load_EX_MEM {-height 15 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control.load_MEM_WB {-height 15 -radix hexadecimal}} /mp3_tb/dut/cpu_d/MEM_WB/control
add wave -noupdate -height 15 -label Registers -radix hexadecimal -childformat {{{/mp3_tb/dut/cpu_d/REG_FILE/data[7]} -radix hexadecimal} {{/mp3_tb/dut/cpu_d/REG_FILE/data[6]} -radix hexadecimal} {{/mp3_tb/dut/cpu_d/REG_FILE/data[5]} -radix hexadecimal} {{/mp3_tb/dut/cpu_d/REG_FILE/data[4]} -radix hexadecimal} {{/mp3_tb/dut/cpu_d/REG_FILE/data[3]} -radix hexadecimal} {{/mp3_tb/dut/cpu_d/REG_FILE/data[2]} -radix hexadecimal} {{/mp3_tb/dut/cpu_d/REG_FILE/data[1]} -radix hexadecimal} {{/mp3_tb/dut/cpu_d/REG_FILE/data[0]} -radix hexadecimal}} -expand -subitemconfig {{/mp3_tb/dut/cpu_d/REG_FILE/data[7]} {-height 15 -radix hexadecimal} {/mp3_tb/dut/cpu_d/REG_FILE/data[6]} {-height 15 -radix hexadecimal} {/mp3_tb/dut/cpu_d/REG_FILE/data[5]} {-height 15 -radix hexadecimal} {/mp3_tb/dut/cpu_d/REG_FILE/data[4]} {-height 15 -radix hexadecimal} {/mp3_tb/dut/cpu_d/REG_FILE/data[3]} {-height 15 -radix hexadecimal} {/mp3_tb/dut/cpu_d/REG_FILE/data[2]} {-height 15 -radix hexadecimal} {/mp3_tb/dut/cpu_d/REG_FILE/data[1]} {-height 15 -radix hexadecimal} {/mp3_tb/dut/cpu_d/REG_FILE/data[0]} {-height 15 -radix hexadecimal}} /mp3_tb/dut/cpu_d/REG_FILE/data
add wave -noupdate -height 15 -label storemux_out -radix hexadecimal /mp3_tb/dut/cpu_d/STORE_MUX/f
add wave -noupdate -height 15 -label storemux_b -radix hexadecimal /mp3_tb/dut/cpu_d/STORE_MUX/b
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/STORE_MUX/sel
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/REG_FILE/reg_b
add wave -noupdate -height 15 -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/sr2_out
add wave -noupdate -height 15 -expand -group ALU -height 15 /mp3_tb/dut/cpu_d/ALU/aluop
add wave -noupdate -height 15 -expand -group ALU -height 15 /mp3_tb/dut/cpu_d/ALU/a
add wave -noupdate -height 15 -expand -group ALU -height 15 /mp3_tb/dut/cpu_d/ALU/b
add wave -noupdate -height 15 -expand -group ALU -height 15 /mp3_tb/dut/cpu_d/ALU/f
add wave -noupdate -height 15 -group datamux -radix hexadecimal /mp3_tb/dut/cpu_d/DATA_MUX/sel
add wave -noupdate -height 15 -group datamux -radix hexadecimal /mp3_tb/dut/cpu_d/DATA_MUX/a
add wave -noupdate -height 15 -group datamux -radix hexadecimal /mp3_tb/dut/cpu_d/DATA_MUX/b
add wave -noupdate -height 15 -group datamux -radix hexadecimal /mp3_tb/dut/cpu_d/DATA_MUX/c
add wave -noupdate -height 15 -group datamux -radix hexadecimal /mp3_tb/dut/cpu_d/DATA_MUX/f
add wave -noupdate -height 15 -group regfilemux -radix hexadecimal /mp3_tb/dut/cpu_d/REG_FILE_MUX/sel
add wave -noupdate -height 15 -group regfilemux -radix hexadecimal /mp3_tb/dut/cpu_d/REG_FILE_MUX/a
add wave -noupdate -height 15 -group regfilemux -radix hexadecimal /mp3_tb/dut/cpu_d/REG_FILE_MUX/b
add wave -noupdate -height 15 -group regfilemux -radix hexadecimal /mp3_tb/dut/cpu_d/REG_FILE_MUX/c
add wave -noupdate -height 15 -group regfilemux -radix hexadecimal /mp3_tb/dut/cpu_d/REG_FILE_MUX/d
add wave -noupdate -height 15 -group regfilemux -radix hexadecimal /mp3_tb/dut/cpu_d/REG_FILE_MUX/e
add wave -noupdate -height 15 -group regfilemux -radix hexadecimal /mp3_tb/dut/cpu_d/REG_FILE_MUX/f
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {516732 ps} 0}
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
WaveRestoreZoom {0 ps} {4200 ns}
