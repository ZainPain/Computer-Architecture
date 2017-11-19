onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /mp3_tb/dut/cpu_d/pc_plus2
add wave -noupdate -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/pc_out
add wave -noupdate -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/pc_out
add wave -noupdate -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/pc_out
add wave -noupdate -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/pc_out
add wave -noupdate -group PCMUX -radix hexadecimal /mp3_tb/dut/cpu_d/PC_MUX/sel
add wave -noupdate -group PCMUX -radix hexadecimal /mp3_tb/dut/cpu_d/PC_MUX/a
add wave -noupdate -group PCMUX -radix hexadecimal /mp3_tb/dut/cpu_d/PC_MUX/b
add wave -noupdate -group PCMUX -radix hexadecimal /mp3_tb/dut/cpu_d/PC_MUX/c
add wave -noupdate -group PCMUX -radix hexadecimal /mp3_tb/dut/cpu_d/PC_MUX/d
add wave -noupdate -group PCMUX -radix hexadecimal /mp3_tb/dut/cpu_d/PC_MUX/e
add wave -noupdate -group PCMUX -radix hexadecimal /mp3_tb/dut/cpu_d/PC_MUX/f
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/clk
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/load
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/reset
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/inst_in
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/pc_in
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/inst_out
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/pc_out
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/offset6
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/imm5
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/imm4
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/trap_vect8
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/offset11
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/offset9
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/dest
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/sr1
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/sr2
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/opcode
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/ir11
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/ir5
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/ir4
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/pc_value
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/IF_ID/instruction
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/PC_MUX/sel
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/PC_MUX/a
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/PC_MUX/b
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/PC_MUX/c
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/PC_MUX/d
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/PC_MUX/e
add wave -noupdate -group IF_ID -radix hexadecimal /mp3_tb/dut/cpu_d/PC_MUX/f
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/clk
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/load
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/reset
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/inst_in
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/pc_in
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/control_in
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/reg_a
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/reg_b
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/dest_in
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/sext6_in
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/sext5_in
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/sext4_in
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/adj6_in
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/adj9_in
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/adj11_in
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/trap_vect8_in
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/inst_out
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/pc_out
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/control_out
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/sr1
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/sr2
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/dest_out
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/sext6_out
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/sext5_out
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/sext4_out
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/adj6_out
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/adj9_out
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/adj11_out
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/trap_vect8_out
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/control
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/instruction
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/pc_value
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/data_a
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/data_b
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/dest
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/sext6
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/sext5
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/sext4
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/adj6
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/adj9
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/adj11
add wave -noupdate -group ID_EX -radix hexadecimal /mp3_tb/dut/cpu_d/ID_EX/trap_vect8
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/clk
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/load
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/reset
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/inst_in
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/pc_in
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/control_in
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/alu_out_in
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/sr2_in
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/dest_in
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/trap_vect8_in
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/branch_address_in
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/inst_out
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/pc_out
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/control_out
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/alu_out_out
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/sr2_out
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/dest_out
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/trap_vect8_out
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/branch_address_out
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/control
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/instruction
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/pc_value
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/alu_value
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/sr2
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/branch_address
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/dest
add wave -noupdate -group EX_MEM -radix hexadecimal /mp3_tb/dut/cpu_d/EX_MEM/trap_vect8
add wave -noupdate -group MEM_WB -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/clk
add wave -noupdate -group MEM_WB -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/load
add wave -noupdate -group MEM_WB -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/reset
add wave -noupdate -group MEM_WB -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/inst_in
add wave -noupdate -group MEM_WB -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/pc_in
add wave -noupdate -group MEM_WB -radix hexadecimal -childformat {{/mp3_tb/dut/cpu_d/MEM_WB/control_in.opcode -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_in.aluop -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_in.load_cc -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_in.load_regfile -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_in.addermux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_in.regfilemux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_in.ldbmux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_in.datamux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_in.pcmux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_in.alumux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_in.writemux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_in.storemux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_in.mem_read -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_in.mem_write -radix hexadecimal}} -subitemconfig {/mp3_tb/dut/cpu_d/MEM_WB/control_in.opcode {-height 16 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_in.aluop {-height 16 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_in.load_cc {-height 16 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_in.load_regfile {-height 16 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_in.addermux_sel {-height 16 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_in.regfilemux_sel {-height 16 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_in.ldbmux_sel {-height 16 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_in.datamux_sel {-height 16 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_in.pcmux_sel {-height 16 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_in.alumux_sel {-height 16 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_in.writemux_sel {-height 16 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_in.storemux_sel {-height 16 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_in.mem_read {-height 16 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_in.mem_write {-height 16 -radix hexadecimal}} /mp3_tb/dut/cpu_d/MEM_WB/control_in
add wave -noupdate -group MEM_WB -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/alu_out_in
add wave -noupdate -group MEM_WB -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/mem_out_in
add wave -noupdate -group MEM_WB -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/branch_address_in
add wave -noupdate -group MEM_WB -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/sr2_in
add wave -noupdate -group MEM_WB -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/dest_in
add wave -noupdate -group MEM_WB -radix hexadecimal -childformat {{/mp3_tb/dut/cpu_d/MEM_WB/control_out.opcode -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.aluop -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.load_cc -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.load_regfile -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.addermux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.regfilemux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.ldbmux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.datamux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.pcmux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.alumux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.writemux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.storemux_sel -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.mem_read -radix hexadecimal} {/mp3_tb/dut/cpu_d/MEM_WB/control_out.mem_write -radix hexadecimal}} -subitemconfig {/mp3_tb/dut/cpu_d/MEM_WB/control_out.opcode {-height 16 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.aluop {-height 16 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.load_cc {-height 16 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.load_regfile {-height 16 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.addermux_sel {-height 16 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.regfilemux_sel {-height 16 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.ldbmux_sel {-height 16 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.datamux_sel {-height 16 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.pcmux_sel {-height 16 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.alumux_sel {-height 16 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.writemux_sel {-height 16 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.storemux_sel {-height 16 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.mem_read {-height 16 -radix hexadecimal} /mp3_tb/dut/cpu_d/MEM_WB/control_out.mem_write {-height 16 -radix hexadecimal}} /mp3_tb/dut/cpu_d/MEM_WB/control_out
add wave -noupdate -group MEM_WB -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/pc_out
add wave -noupdate -group MEM_WB -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/alu_out_out
add wave -noupdate -group MEM_WB -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/mem_out_out
add wave -noupdate -group MEM_WB -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/branch_address_out
add wave -noupdate -group MEM_WB -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/sr2_out
add wave -noupdate -group MEM_WB -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/dest_out
add wave -noupdate -group MEM_WB -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/control
add wave -noupdate -group MEM_WB -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/instruction
add wave -noupdate -group MEM_WB -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/pc_value
add wave -noupdate -group MEM_WB -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/alu_value
add wave -noupdate -group MEM_WB -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/mem_out
add wave -noupdate -group MEM_WB -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/branch_address
add wave -noupdate -group MEM_WB -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/sr2
add wave -noupdate -group MEM_WB -radix hexadecimal /mp3_tb/dut/cpu_d/MEM_WB/dest
add wave -noupdate -expand -group ALU -radix hexadecimal /mp3_tb/dut/cpu_d/ALU/aluop
add wave -noupdate -expand -group ALU -radix hexadecimal /mp3_tb/dut/cpu_d/ALU/a
add wave -noupdate -expand -group ALU -radix hexadecimal /mp3_tb/dut/cpu_d/ALU/b
add wave -noupdate -expand -group ALU -radix hexadecimal /mp3_tb/dut/cpu_d/ALU/f
add wave -noupdate -label Registers -radix hexadecimal -childformat {{{/mp3_tb/dut/cpu_d/REG_FILE/data[7]} -radix hexadecimal} {{/mp3_tb/dut/cpu_d/REG_FILE/data[6]} -radix hexadecimal} {{/mp3_tb/dut/cpu_d/REG_FILE/data[5]} -radix hexadecimal} {{/mp3_tb/dut/cpu_d/REG_FILE/data[4]} -radix hexadecimal} {{/mp3_tb/dut/cpu_d/REG_FILE/data[3]} -radix hexadecimal} {{/mp3_tb/dut/cpu_d/REG_FILE/data[2]} -radix hexadecimal} {{/mp3_tb/dut/cpu_d/REG_FILE/data[1]} -radix hexadecimal} {{/mp3_tb/dut/cpu_d/REG_FILE/data[0]} -radix hexadecimal}} -expand -subitemconfig {{/mp3_tb/dut/cpu_d/REG_FILE/data[7]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/cpu_d/REG_FILE/data[6]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/cpu_d/REG_FILE/data[5]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/cpu_d/REG_FILE/data[4]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/cpu_d/REG_FILE/data[3]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/cpu_d/REG_FILE/data[2]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/cpu_d/REG_FILE/data[1]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/cpu_d/REG_FILE/data[0]} {-height 16 -radix hexadecimal}} /mp3_tb/dut/cpu_d/REG_FILE/data
add wave -noupdate -radix hexadecimal /mp3_tb/dut/cpu_d/forward_load
add wave -noupdate -expand -group ForwardA -radix hexadecimal /mp3_tb/dut/cpu_d/forwardA/sel
add wave -noupdate -expand -group ForwardA -radix hexadecimal /mp3_tb/dut/cpu_d/forwardA/a
add wave -noupdate -expand -group ForwardA -radix hexadecimal /mp3_tb/dut/cpu_d/forwardA/b
add wave -noupdate -expand -group ForwardA -radix hexadecimal /mp3_tb/dut/cpu_d/forwardA/c
add wave -noupdate -expand -group ForwardA -radix hexadecimal /mp3_tb/dut/cpu_d/forwardA/f
add wave -noupdate -expand -group ForwardB -radix hexadecimal /mp3_tb/dut/cpu_d/forwardB/sel
add wave -noupdate -expand -group ForwardB -radix hexadecimal /mp3_tb/dut/cpu_d/forwardB/a
add wave -noupdate -expand -group ForwardB -radix hexadecimal /mp3_tb/dut/cpu_d/forwardB/b
add wave -noupdate -expand -group ForwardB -radix hexadecimal /mp3_tb/dut/cpu_d/forwardB/c
add wave -noupdate -expand -group ForwardB -radix hexadecimal /mp3_tb/dut/cpu_d/forwardB/f
add wave -noupdate -expand -group {forward unit} -radix hexadecimal /mp3_tb/dut/cpu_d/Forward_unit/ID_EX_sr1
add wave -noupdate -expand -group {forward unit} -radix hexadecimal /mp3_tb/dut/cpu_d/Forward_unit/ID_EX_sr2
add wave -noupdate -expand -group {forward unit} -radix hexadecimal /mp3_tb/dut/cpu_d/Forward_unit/EX_MEM_write
add wave -noupdate -expand -group {forward unit} -radix hexadecimal /mp3_tb/dut/cpu_d/Forward_unit/MEM_WB_write
add wave -noupdate -expand -group {forward unit} -radix hexadecimal /mp3_tb/dut/cpu_d/Forward_unit/EX_MEM_dest
add wave -noupdate -expand -group {forward unit} -radix hexadecimal /mp3_tb/dut/cpu_d/Forward_unit/MEM_WB_dest
add wave -noupdate -expand -group {forward unit} -radix hexadecimal /mp3_tb/dut/cpu_d/Forward_unit/ForwardA
add wave -noupdate -expand -group {forward unit} -radix hexadecimal /mp3_tb/dut/cpu_d/Forward_unit/ForwardB
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {104824 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 156
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
WaveRestoreZoom {0 ps} {240576 ps}
