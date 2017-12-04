import lc3b_types::*;

module cpu_datapath
(
    input clk,

    /* Instruction Memory */
    output icache_read,
    output icache_write,
    output [1:0] icache_wmask,
    output [15:0] icache_address,
    output [15:0] icache_wdata,
    input logic icache_resp,
    input logic [15:0] icache_rdata,

    /* Data Memory */
    output dcache_read,
    output dcache_write,
    output [1:0] dcache_wmask,
    output [15:0] dcache_address,
    output [15:0] dcache_wdata,
    input logic dcache_resp,
    input logic [15:0] dcache_rdata,
	 input logic l2cache_resp
);

//NOTE NEED TO PUT LOAD_PC ELSEWHERE

logic load_pc;
logic load_IF_ID;
logic load_ID_EX;
logic load_EX_MEM;
logic load_MEM_WB;

logic reset_IF_ID;
logic reset_ID_EX;
logic reset_EX_MEM;
logic reset_MEM_WB;

lc3b_word pcmux_out;
lc3b_word pc_out;
lc3b_word pc_plus2;
lc3b_word EX_MEM_pc_adder_out;
lc3b_word MEM_WB_sr1;

lc3b_control_word IF_ID_ctrl;
lc3b_control_word ID_EX_ctrl;
lc3b_control_word EX_MEM_ctrl;
lc3b_control_word MEM_WB_ctrl;

lc3b_word MEM_WB_trap_vect8;
lc3b_word trapmux_out;

logic btb_speculatively_taken;
lc3b_word btb_updated_pc;
lc3b_word btb_branch_target;
logic [1:0] btb_target_mux_sel;

/* WIRES FOR IF_ID_EX */

lc3b_word IF_ID_EX_inst;
lc3b_word IF_ID_EX_pc;
lc3b_reg IF_ID_EX_dest;

lc3b_offset6 IF_ID_offset6;
lc3b_imm5 IF_ID_imm5;
lc3b_imm4 IF_ID_imm4;
lc3b_trapvect8 IF_ID_trapvect8;
lc3b_offset11 IF_ID_offset11;
lc3b_offset9 IF_ID_offset9;

lc3b_reg IF_ID_sr1;
lc3b_reg IF_ID_sr2;

lc3b_opcode IF_ID_opcode;
logic IF_ID_ir11;
logic IF_ID_ir5;
logic IF_ID_ir4;

lc3b_word IF_ID_EX_sr1;
lc3b_word IF_ID_EX_sr2;

lc3b_reg storemux_out;

lc3b_word IF_ID_EX_sext6_out;
lc3b_word IF_ID_EX_sext5_out;
lc3b_word IF_ID_EX_zext4_out;
lc3b_word IF_ID_EX_trapvect8_out;
lc3b_word IF_ID_EX_adj6_out;
lc3b_word IF_ID_EX_adj9_out;
lc3b_word IF_ID_EX_adj11_out;
lc3b_word IF_ID_EX_ztrapvect8;
logic IF_ID_speculatively_taken;


/* WIRES FOR ID_EX_MEM */

lc3b_word ID_EX_MEM_inst;
lc3b_word ID_EX_MEM_pc;

lc3b_word ID_EX_sr1;
lc3b_word ID_EX_sr2;
lc3b_reg ID_EX_MEM_dest;

lc3b_word ID_EX_sext6;
lc3b_word ID_EX_sext5;
lc3b_word ID_EX_zext4;
lc3b_word ID_EX_adj6;
lc3b_word ID_EX_adj9;
lc3b_word ID_EX_adj11;
lc3b_word ID_EX_MEM_ztrapvect8;

lc3b_word ID_EX_alumux_out;
lc3b_word ID_EX_MEM_alu;
lc3b_word ID_EX_addermux_out;
lc3b_word ID_EX_MEM_pc_adder_out;

logic ID_EX_speculatively_taken;

/* WIRES FOR EX_MEM_WB */
lc3b_word EX_MEM_WB_inst;
lc3b_word EX_MEM_WB_pc;

lc3b_word EX_MEM_alu_out;
lc3b_word EX_MEM_sr2;
lc3b_reg EX_MEM_WB_dest;
lc3b_word EX_MEM_WB_pc_adder;
lc3b_word EX_MEM_ztrapvect8;
lc3b_word LDI_STI_address_out;
logic [1:0] EX_MEM_counter;

logic[1:0] EX_MEM_datamux_sel;
logic reset_LDI_STI_counter;
logic load_pipeline_reg;
logic load_LDI_STI_ADDRESS;
logic [2:0] cc_forward_mux_out;

logic EX_MEM_speculatively_taken;

/* WIRES FOR MEM_WB_ID */
lc3b_word MEM_WB_inst;
lc3b_word MEM_WB_pc;

lc3b_word MEM_WB_alu_out;
lc3b_word MEM_WB_dmem;
lc3b_word MEM_WB_pc_adder;
lc3b_word MEM_WB_sr2;
lc3b_reg MEM_WB_dest;

lc3b_nzp gencc_out;
lc3b_nzp cc_out;
lc3b_word regfilemux_out;
logic branch_enable;
logic branch_enable_true;
logic [2:0] pcmux_sel_updated;
logic [7:0] ldbmux_out;
logic unconditional_branch;
logic require_reset;
logic incorrect_target;


/* FORWARD IMPLEMENTATION HERE */
logic [1:0] forwardA_sel;
logic [1:0] forwardB_sel;
lc3b_word forwardA_out;
lc3b_word forwardB_out;
lc3b_reg forward_regA;
lc3b_reg forward_regB;
logic ID_EX_ir5;
logic writemux_sel_updated;
logic forward_load;
logic hazard;
lc3b_word writebackmux_out;
logic EX_MEM_mux_sel;
lc3b_word EX_MEM_forward_out;
logic sr2mux_sel;
lc3b_word sr2mux_out;
logic [1:0] writeback_mux_sel;

logic [3:0] BHR_out;
logic [1:0] pht_prediction_out;
logic [9:0]pht_index_out;

logic [9:0]bcu_updated_index;
logic [1:0] bcu_updated_counter;
logic [9:0]pc_cat_bhr;
logic bcu_update;

/* IF_ID */
logic [9:0]IF_ID_pht_index;
logic [1:0] IF_ID_pht_prediction;

/* ID_EX */
logic [9:0]ID_EX_pht_index;
logic [1:0] ID_EX_pht_prediction;

/* EX_MEM */
logic [9:0]EX_MEM_pht_index;
logic [1:0] EX_MEM_pht_prediction;

assign pc_cat_bhr = {pc_out[5:1], BHR_out};
BHR __bhr__
(
	.clk(clk),
	.branch(branch_enable_true),
  .opcode(EX_MEM_ctrl.opcode),
  .nzp(EX_MEM_WB_dest),
  .BHR_out(BHR_out)
);

PHT  __pht__
(
	.clk(clk),
	.index(pc_cat_bhr),
	.updated_index(bcu_updated_index),	
	.updated_counter(bcu_updated_counter),		
	.update(bcu_update),
	
	.prediction(pht_prediction_out),		
	.index_out(pht_index_out)			
);

branch_counter_update bcu
(
	.prediction(EX_MEM_pht_prediction),		
	.actual_decision(branch_enable_true),	    /* BRANCH */
	.index(EX_MEM_pht_index),				
	.counter(bcu_updated_counter),		
	.update(bcu_update),					
	.index_out(bcu_updated_index),
  .opcode(EX_MEM_ctrl.opcode),
  .nzp(EX_MEM_WB_dest)

);


mux3 forwardA
(
	.sel(forwardA_sel),
	.a(ID_EX_sr1),
	.b(writebackmux_out),		/* need to change to account for mem_out as well */
	.c(EX_MEM_forward_out),
	.f(forwardA_out)
);
mux3 forwardB
(
	.sel(forwardB_sel),
	.a(ID_EX_alumux_out),
	.b(writebackmux_out),		/* need to change to account for mem_out as well */
	.c(EX_MEM_forward_out),
	.f(forwardB_out)
);

forward Forward_unit
(
	.ID_EX_opcode(ID_EX_ctrl.opcode),
	.EX_MEM_opcode(EX_MEM_ctrl.opcode),
	.bit5(ID_EX_ir5),
	.ID_EX_sr1(forward_regA),
	.ID_EX_sr2(forward_regB),
	
	.EX_MEM_reg_write(EX_MEM_ctrl.load_regfile),
	.MEM_WB_reg_write(MEM_WB_ctrl.load_regfile),
	.EX_MEM_mem_write(EX_MEM_ctrl.mem_write),
	
	.ID_EX_mem_write(ID_EX_ctrl.mem_write),
	
	.EX_MEM_dest(EX_MEM_WB_dest),
	.MEM_WB_dest(MEM_WB_dest),
	.IF_ID_EX_dest(ID_EX_MEM_dest),
	
	.writemux_sel(MEM_WB_ctrl.writemux_sel),	
	
	.ForwardA(forwardA_sel),
	.ForwardB(forwardB_sel),
	.writemux_sel_updated(writemux_sel_updated),
	.EX_MEM_mux_sel(EX_MEM_mux_sel),
	.sr2mux_sel(sr2mux_sel)
		
);

hazard_detection HD
(
	.opcode(IF_ID_opcode),
	.bit5(IF_ID_ir5),
	.bit11(IF_ID_ir11),
	.ID_EX_mem_read(ID_EX_ctrl.mem_read),
	.ID_EX_dest(ID_EX_MEM_dest),
	.IF_ID_sr1(IF_ID_sr1),
	.IF_ID_sr2(IF_ID_sr2),
	
	.forward_load(forward_load),
	.hazard(hazard)
);

/* this mux will forward either alu_out or mem_out depending on if the instruction at writeback stage was a load or not */
writeback_forward		writebackmux_select_signal
(
	.MEM_WB_ctrl(MEM_WB_ctrl),
	.writeback_mux_sel(writeback_mux_sel)
);
/*mux3 writeback_to_EX_MEM_mux
(
	.sel(writeback_mux_sel),
	.a(MEM_WB_alu_out),
	.b(MEM_WB_dmem),
	.c(MEM_WB_pc_adder),
	.f(writebackmux_out)
); */
assign writebackmux_out = regfilemux_out;

mux2 EX_MEM_forward_mux
(
	.sel(EX_MEM_mux_sel),
	.a(EX_MEM_alu_out),
	.b(EX_MEM_WB_pc_adder),
	.f(EX_MEM_forward_out)
);
mux2 WB_to_ID_EX_sr2_mux
(
	.sel(sr2mux_sel),
	.a(ID_EX_sr2),
	.b(writebackmux_out),
	.f(sr2mux_out)
);
/*
logic delayed_forward_load;
register #(.width(1)) forward_load_reg
(
    .clk(clk),
    .load(1'b1),
    .in(forward_load),
	 .out(delayed_forward_load)
);
*/
lc3b_control_word NOP_ctrl;
lc3b_control_word controlmux_out;
NOPS zero_signal
(
	.zero_signal(NOP_ctrl)
);
mux2 #(.width(($bits(lc3b_control_word)))) controlmux
(
	.sel(hazard),
	.a(IF_ID_ctrl),
	.b(NOP_ctrl),
	.f(controlmux_out)
);
/* FORWARD IMPLEMENTATION END */
/* PERFORMANCE COUNTER  START */

logic mem_read_checked;
logic mem_write_checked;
logic MMIO_read;
logic MMIO_write;
logic [3:0] performance_counter;
logic memoryout_sel;
lc3b_word performance_counter_out;
logic branch_for_counter;
logic branch_not_taken_for_counter;
lc3b_word memorymux_out;
address_checker AC
(
	.address(dcache_address),
	.mem_read(EX_MEM_ctrl.mem_read),
	.mem_write(EX_MEM_ctrl.mem_write),
	.mem_read_update(mem_read_checked),
	.mem_write_update(mem_write_checked),
	.MMIO_read(MMIO_read),
	.MMIO_write(MMIO_write),
	.counter_address(performance_counter),
	.memoryout_sel(memoryout_sel)
	
);
Memory_Mapped_IO MMIO
(
	.clk(clk),
	.counter(performance_counter),
	.mem_read(EX_MEM_ctrl.mem_read),
	.mem_write(EX_MEM_ctrl.mem_write),
	.MMIO_read(MMIO_read),
	.MMIO_write(MMIO_write),
	.branch(branch_for_counter),
	.branch_not(branch_not_taken_for_counter),
	.Icache_resp(icache_resp),
	.Dcache_resp(dcache_resp),
	.L2cache_resp(l2cache_resp),
	.stall_IF_ID(!load_IF_ID),
	.stall_ID_EX(!load_ID_EX),
	.stall_EX_MEM(!load_EX_MEM),
	.stall_MEM_WB(!load_MEM_WB),
	.counter_out(performance_counter_out),
  .misprediction_in(misprediction)
);

mux2 #(.width(16)) MEMORYMUX
(
	.sel(memoryout_sel),
	.a(dcache_rdata),
	.b(performance_counter_out),
	.f(memorymux_out)
);
/* PERFORMANCE COUNTER END */
assign icache_wmask = 2'b11;
// assign I-mem signals
assign icache_read = 1'b1;
assign icache_write = 1'b0;
assign icache_address = pc_out;

//assign unconditional_branch = EX_MEM_ctrl.opcode == op_jsr || EX_MEM_ctrl.opcode == op_trap || EX_MEM_ctrl.opcode == op_jmp;

////assign load_pc = 1'b1;
//assign load_pc = (icache_resp && (load_pipeline_reg || branch_enable_true || unconditional_branch));

// assigning RESET SIGNALS
//assign reset_IF_ID = ((~load_pc && load_pipeline_reg && !hazard) || (MEM_WB_ctrl.opcode == op_jsr|| MEM_WB_ctrl.opcode == op_trap || MEM_WB_ctrl.opcode == op_jmp || branch_enable_true)) ? 1'b1 : 1'b0;//1'b0;
//assign reset_ID_EX = (branch_enable_true || MEM_WB_ctrl.opcode == op_jsr || MEM_WB_ctrl.opcode == op_trap || MEM_WB_ctrl.opcode == op_jmp) ? 1'b1 : 1'b0;
//assign reset_EX_MEM = (branch_enable_true || MEM_WB_ctrl.opcode == op_jsr || MEM_WB_ctrl.opcode == op_trap || MEM_WB_ctrl.opcode == op_jmp) ? 1'b1 : 1'b0;
//assign reset_MEM_WB = (icache_resp && (MEM_WB_ctrl.opcode == op_jsr|| MEM_WB_ctrl.opcode == op_trap || MEM_WB_ctrl.opcode == op_jmp || branch_enable_true)) ? 1'b1 : 1'b0;


//assign load_IF_ID=load_pipeline_reg && forward_load;
//assign load_ID_EX=load_pipeline_reg;
//assign load_EX_MEM=load_pipeline_reg;
//assign load_MEM_WB=(load_pipeline_reg && MEM_WB_ctrl.opcode != op_br && ~unconditional_branch) || (load_pipeline_reg && ~branch_enable_true && ~unconditional_branch) || (load_pipeline_reg && branch_enable_true && icache_resp) 
//|| (load_pipeline_reg && unconditional_branch && icache_resp);

logic incorrectly_taken;
logic incorrectly_not_taken;
assign branch_for_counter = unconditional_branch || branch_enable_true;

assign branch_not_taken_for_counter = !branch_enable_true && (EX_MEM_ctrl.opcode == op_br) && (EX_MEM_WB_inst[11] || EX_MEM_WB_inst[10] || EX_MEM_WB_inst[9]); 

assign misprediction = incorrectly_taken || incorrectly_not_taken;

stall_reset_logic pipeline_stall_reset(
	.EX_MEM_opcode(EX_MEM_ctrl.opcode),
  .MEM_WB_opcode(MEM_WB_ctrl.opcode),
  .icache_resp(icache_resp),
	.dcache_resp(dcache_resp),
	.mem_read(mem_read_checked),
	.mem_write(mem_write_checked),
  //.branch_enable_true(branch_enable_true),
  //.unconditional_branch(unconditional_branch),
  .require_reset(require_reset),
  .hazard(hazard),
  .forward_load(forward_load),
	.counter(EX_MEM_counter),
  .datamux_sel(EX_MEM_ctrl.datamux_sel),

	.datamux_sel_updated(EX_MEM_datamux_sel),
	.mem_read_updated(dcache_read),
	.mem_write_updated(dcache_write),
  .load_pc(load_pc),
  .load_IF_ID(load_IF_ID),
  .load_ID_EX(load_ID_EX),
  .load_EX_MEM(load_EX_MEM),
  .load_MEM_WB(load_MEM_WB),
  .load_LDI_STI_ADDRESS(load_LDI_STI_ADDRESS),
  .reset_IF_ID(reset_IF_ID),
  .reset_ID_EX(reset_ID_EX),
  .reset_EX_MEM(reset_EX_MEM),
  .reset_MEM_WB(reset_MEM_WB),
	.reset_LDI_STI_counter(reset_LDI_STI_counter)
);

// REGISTERS
register PC
(
  .clk(clk),
  .load(load_pc),
  .in(pcmux_out),
  .out(pc_out)
);

mux8 #(.width(16)) PC_MUX
(
	.sel(pcmux_sel_updated),
	.a(EX_MEM_sr2),
	.b(EX_MEM_WB_pc_adder),
	.c(memorymux_out),
	.d(pc_plus2),
  .e(EX_MEM_alu_out),
  .f(btb_updated_pc),
  .g(EX_MEM_WB_pc),
  .h(16'bX),
	.out(pcmux_out)

);

mux3 #(.width(16)) BTB_TARGET_MUX
(
  .sel(btb_target_mux_sel),
	.a(EX_MEM_WB_pc_adder),
	.b(memorymux_out),
	.c(EX_MEM_alu_out),
  .f(btb_branch_target)
);

//assign btb_speculatively_taken = 0;
//assign updated_pc = 16'b0;

plus2 PC_PLUS2
(
	.in(pc_out),
	.out(pc_plus2)
);

btb branch_target_buffer
(
  .clk(clk),
  .pc(pc_plus2),
	.branch_prediction(pht_prediction_out[1]),

	.updated_pc(btb_updated_pc),
  .speculatively_taken(btb_speculatively_taken),

	.branch_taken(branch_enable_true),
  .unconditional_branch(unconditional_branch),
	.branch_taken_pc(EX_MEM_WB_pc),
	.branch_taken_target(btb_branch_target),
  .incorrect_target(incorrect_target)
);


IF_ID_reg IF_ID
(
	.clk(clk),
	.load(load_IF_ID),
	.reset(reset_IF_ID),

	.inst_in(icache_rdata),
	.pc_in(pc_plus2),
  .btb_speculatively_taken_in(btb_speculatively_taken),
  
  .pht_prediction_out_in(pht_prediction_out),
	.pht_index_out_in(pht_index_out),
  
	.inst_out(IF_ID_EX_inst),
	.pc_out(IF_ID_EX_pc),

	.offset6(IF_ID_offset6),
	.imm5(IF_ID_imm5),
	.imm4(IF_ID_imm4),
	.trap_vect8(IF_ID_trapvect8),
	.offset9(IF_ID_offset9),
	.offset11(IF_ID_offset11),

	.dest(IF_ID_EX_dest),
	.sr1(IF_ID_sr1),
	.sr2(IF_ID_sr2),
  .btb_speculatively_taken_out(IF_ID_speculatively_taken),
  .pht_prediction_out_out(IF_ID_pht_prediction),
  .pht_index_out_out(IF_ID_pht_index),
	.opcode(IF_ID_opcode),
	.ir11(IF_ID_ir11),
	.ir5(IF_ID_ir5),
	.ir4(IF_ID_ir4)
);

regfile REG_FILE
(
  .clk(clk),
  .load(MEM_WB_ctrl.load_regfile),
  .in(regfilemux_out),
  .src_a(IF_ID_sr1),
  .src_b(storemux_out),
  .dest(MEM_WB_dest),
  .reg_a(IF_ID_EX_sr1),
  .reg_b(IF_ID_EX_sr2)
);


mux2 #(.width(3)) STORE_MUX
(
  .sel(IF_ID_ctrl.storemux_sel),
  .a(IF_ID_sr2),
  .b(IF_ID_EX_dest),
  .f(storemux_out)
);

control_rom Control
(
  .opcode(IF_ID_opcode),
  .bit11(IF_ID_ir11),
  .bit5(IF_ID_ir5),
  .bit4(IF_ID_ir4),
  .ctrl(IF_ID_ctrl)
);

sext #(.width(6)) SEXT6
(
  .in(IF_ID_offset6),
  .out(IF_ID_EX_sext6_out)
);

sext #(.width(5)) SEXT5
(
  .in(IF_ID_imm5),
  .out(IF_ID_EX_sext5_out)
);

assign IF_ID_EX_zext4_out = {12'b0, IF_ID_imm4};
/*zext #(.width(4)) ZEXT4
(
  .in(IF_ID_imm4),
  .out(IF_ID_EX_zext4_out)
); */

adj #(.width(6)) ADJ6
(
  .in(IF_ID_offset6),
  .out(IF_ID_EX_adj6_out)
);

zext #(.width(8)) ZEXT8
(
  .in(IF_ID_trapvect8),
  .out(IF_ID_EX_ztrapvect8)
);

adj #(.width(9)) ADJ9
(
  .in(IF_ID_offset9),
  .out(IF_ID_EX_adj9_out)
);

adj #(.width(11)) ADJ11
(
  .in(IF_ID_offset11),
  .out(IF_ID_EX_adj11_out)
);

ID_EX_reg ID_EX
(
  .clk(clk),
  .load(load_ID_EX),
  .reset(reset_ID_EX),


  .inst_in(IF_ID_EX_inst),	/* Maybe for debugging purpose only */
  .pc_in(IF_ID_EX_pc),

  .control_in(controlmux_out),
  .src1_in(IF_ID_sr1),
  .src2_in(IF_ID_sr2),
  .reg_a(IF_ID_EX_sr1),
  .reg_b(IF_ID_EX_sr2),
  .dest_in(IF_ID_EX_dest),
  
  .btb_speculatively_taken_in(IF_ID_speculatively_taken),
  .pht_index_out_in(IF_ID_pht_index),
  .pht_prediction_out_in(IF_ID_pht_prediction),
  .src1_out(forward_regA),				
  .src2_out(forward_regB),

  .sext6_in(IF_ID_EX_sext6_out),
  .sext5_in(IF_ID_EX_sext5_out),
  .sext4_in(IF_ID_EX_zext4_out),
  .adj6_in(IF_ID_EX_adj6_out),
  .adj9_in(IF_ID_EX_adj9_out),
  .adj11_in(IF_ID_EX_adj11_out),
  .trap_vect8_in(IF_ID_EX_ztrapvect8),
  .ir5_in(IF_ID_ir5),

  .inst_out(ID_EX_MEM_inst),	/* Maybe for debugging purpose only */
  .pc_out(ID_EX_MEM_pc),

  .control_out(ID_EX_ctrl),
  .sr1(ID_EX_sr1),
  .sr2(ID_EX_sr2),
  .dest_out(ID_EX_MEM_dest),
  .ir5_out(ID_EX_ir5),
  .btb_speculatively_taken_out(ID_EX_speculatively_taken),
  .pht_index_out_out(ID_EX_pht_index),
  .pht_prediction_out_out(ID_EX_pht_prediction),
  .sext6_out(ID_EX_sext6),
  .sext5_out(ID_EX_sext5),
  .sext4_out(ID_EX_zext4),
  .adj6_out(ID_EX_adj6),
  .adj9_out(ID_EX_adj9),
  .adj11_out(ID_EX_adj11),
  .trap_vect8_out(ID_EX_MEM_ztrapvect8)
);

mux5 #(.width(16)) ALU_MUX
(
  .sel(ID_EX_ctrl.alumux_sel),
  .a(ID_EX_sr2),
  .b(ID_EX_sext6),
  .c(ID_EX_adj6),
  .d(ID_EX_sext5),
  .e(ID_EX_zext4),
  .f(ID_EX_alumux_out)
);

alu ALU
(
  .aluop(ID_EX_ctrl.aluop),
  .a(forwardA_out),
  .b(forwardB_out),
  .f(ID_EX_MEM_alu)
);

mux2 #(.width(16)) ADDER_MUX
(
  .sel(ID_EX_ctrl.addermux_sel),
  .a(ID_EX_adj9),
  .b(ID_EX_adj11),
  .f(ID_EX_addermux_out)
);

adder #(.width(16)) PC_ADDER
(
  .in1(ID_EX_addermux_out),
  .in2(ID_EX_MEM_pc),
  .out(ID_EX_MEM_pc_adder_out)
);

EX_MEM_reg EX_MEM
(
  .clk(clk),
  .load(load_EX_MEM),
  .reset(reset_EX_MEM),

  .inst_in(ID_EX_MEM_inst),
  .pc_in(ID_EX_MEM_pc),

  .control_in(ID_EX_ctrl),
  .alu_out_in(ID_EX_MEM_alu),
  .sr2_in(sr2mux_out),				/* ID_EX_sr2 */
  .dest_in(ID_EX_MEM_dest),
  .trap_vect8_in(ID_EX_MEM_ztrapvect8),

  .branch_address_in(ID_EX_MEM_pc_adder_out),
  .btb_speculatively_taken_in(ID_EX_speculatively_taken),
  .pht_index_out_in(ID_EX_pht_index),
  .pht_prediction_out_in(ID_EX_pht_prediction),
  .inst_out(EX_MEM_WB_inst),
  .pc_out(EX_MEM_WB_pc),

  .control_out(EX_MEM_ctrl),
  .alu_out_out(EX_MEM_alu_out),
  .sr2_out(EX_MEM_sr2),
  .dest_out(EX_MEM_WB_dest),
  .trap_vect8_out(EX_MEM_ztrapvect8),

  .branch_address_out(EX_MEM_WB_pc_adder),
  .btb_speculatively_taken_out(EX_MEM_speculatively_taken),
  .pht_index_out_out(EX_MEM_pht_index),
  .pht_prediction_out_out(EX_MEM_pht_prediction)
);

byteDetect STOREADDRESS
(
    .in(EX_MEM_alu_out),
	 .signal(EX_MEM_ctrl.writemux_sel),
	 .wmask(dcache_wmask)
);

/* REQUIRED FOR STI/LDI BUT NOT FOR CP1 */
n_bit_counter #(.width(2)) LDI_STI_COUNTER
(
  .out(EX_MEM_counter),
  .load(dcache_resp && (EX_MEM_ctrl.opcode==op_sti || EX_MEM_ctrl.opcode==op_ldi)),
  .clk(clk),
  .reset(reset_LDI_STI_counter)
);
/*
mux2 #(.width(16)) WRITEMUX
(
  .sel(EX_MEM_ctrl.writemux_sel),
  .a(EX_MEM_sr2),
  .b({EX_MEM_sr2[7:0],EX_MEM_sr2[7:0]}),
  .f(dcache_wdata)
);
*/
mux4 #(.width(16)) WRITEMUX 
(
	.sel({writemux_sel_updated,EX_MEM_ctrl.writemux_sel}),
	.a(EX_MEM_sr2),
	.b({EX_MEM_sr2[7:0],EX_MEM_sr2[7:0]}),
	.c(writebackmux_out),
	.d({writebackmux_out[7:0],writebackmux_out[7:0]}),
	.f(dcache_wdata)
);
/*
lc3b_word WB_MEM_mux_out;
mux2 #(.width(16)) WRITEMUX
(
  .sel(EX_MEM_ctrl.writemux_sel),
  .a(WB_MEM_mux_out),
  .b({WB_MEM_mux_out[7:0],WB_MEM_mux_out[7:0]}),
  .f(dcache_wdata)
);
mux2 WB_to_MEM_dest_mux
(
	.sel(writemux_sel_updated),
	.a(EX_MEM_sr2),
	.b(writebackmux_out),
	.f(WB_MEM_mux_out)
);
*/
/*
mux4 #(.width(16)) WRITEMUX
(
  .sel(writemux_sel_updated),
  .a(EX_MEM_sr2),
  .b({EX_MEM_sr2[7:0],EX_MEM_sr2[7:0]}),
  .c(writebackmux_out),
  .d({writebackmux_out[7:0],writebackmux_out[7:0]}),
  .f(dcache_wdata)
);*/

register #(.width(16)) LDI_STI_ADDRESS
(
	.clk(clk),
	.load(load_LDI_STI_ADDRESS),
	.in(dcache_rdata),
	.out(LDI_STI_address_out)
);

mux3 #(.width(16)) DATA_MUX
(
  .sel(EX_MEM_datamux_sel),
  .a(LDI_STI_address_out),
  .b(EX_MEM_ztrapvect8),
  .c(EX_MEM_alu_out),
  .f(dcache_address)
);

MEM_WB_reg MEM_WB
(
  .clk(clk),
  .load(load_MEM_WB),
  .reset(reset_MEM_WB),

  .inst_in(EX_MEM_WB_inst),
  .pc_in(EX_MEM_WB_pc),

  .control_in(EX_MEM_ctrl),
  .alu_out_in(EX_MEM_alu_out),
  .mem_out_in(memorymux_out),
  .branch_address_in(EX_MEM_WB_pc_adder),
  .sr2_in(EX_MEM_sr2),
  .dest_in(EX_MEM_WB_dest),
	
  .control_out(MEM_WB_ctrl),
  .pc_out(MEM_WB_pc),
  .alu_out_out(MEM_WB_alu_out),
  .mem_out_out(MEM_WB_dmem),
  .branch_address_out(MEM_WB_pc_adder),
  .sr2_out(MEM_WB_sr2),
  .dest_out(MEM_WB_dest)
);

mux2 #(.width(8)) LDB_MUX
(
  .sel(MEM_WB_alu_out[0]),      /* changed from ID_EX_ctrl.ldbmux_sel */
  .a(MEM_WB_dmem[7:0]),
  .b(MEM_WB_dmem[15:8]),
  .f(ldbmux_out)
);

mux5 #(.width(16)) REG_FILE_MUX
(
  .sel(MEM_WB_ctrl.regfilemux_sel),
  .a({8'd0, ldbmux_out}),
  .b(MEM_WB_dmem),
  .c(MEM_WB_pc_adder),
  .d(MEM_WB_pc),
  .e(MEM_WB_alu_out),
  .f(regfilemux_out)
);

gencc GENCC
(
  .in(regfilemux_out),
  .out(gencc_out)
);

register #(.width(3)) CC
(
  .clk(clk),
  .load(MEM_WB_ctrl.load_cc),
  .in(gencc_out),
  .out(cc_out)
);

mux2 #(.width(3)) CC_FORWARDING_MUX
(
  .sel(MEM_WB_ctrl.load_cc),
  .a(cc_out),
  .b(gencc_out),
  .f(cc_forward_mux_out)
);

cccomp CCCOMP
(
  .dest(EX_MEM_WB_dest),
  .nzp(cc_forward_mux_out),
  .out(branch_enable)
);

branch_logic BRANCH_LOGIC
(
  .opcode(EX_MEM_ctrl.opcode),
  .branch_enable(branch_enable),
  .pcmux_sel(EX_MEM_ctrl.pcmux_sel),
  .pcmux_sel_updated(pcmux_sel_updated),
  .branch_enable_true(branch_enable_true),
  .unconditional_branch(unconditional_branch),
  .speculatively_taken(EX_MEM_speculatively_taken),
  .incorrect_target(incorrect_target),
  .require_reset(require_reset),
  .branch_predictor_taken_and_btb_valid(btb_speculatively_taken),
  .btb_target_mux_sel(btb_target_mux_sel),
  .incorrectly_taken(incorrectly_taken),
  .incorrectly_not_taken(incorrectly_not_taken)
);

endmodule : cpu_datapath
