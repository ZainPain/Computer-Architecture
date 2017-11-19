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
    input logic [15:0] dcache_rdata
);


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
lc3b_word IF_ID_EX_sext4_out;
lc3b_word IF_ID_EX_trapvect8_out;
lc3b_word IF_ID_EX_adj6_out;
lc3b_word IF_ID_EX_adj9_out;
lc3b_word IF_ID_EX_adj11_out;
lc3b_word IF_ID_EX_ztrapvect8;

/* WIRES FOR ID_EX_MEM */

lc3b_word ID_EX_MEM_inst;
lc3b_word ID_EX_MEM_pc;

lc3b_word ID_EX_sr1;
lc3b_word ID_EX_sr2;
lc3b_reg ID_EX_MEM_dest;

lc3b_word ID_EX_sext6;
lc3b_word ID_EX_sext5;
lc3b_word ID_EX_sext4;
lc3b_word ID_EX_adj6;
lc3b_word ID_EX_adj9;
lc3b_word ID_EX_adj11;
lc3b_word ID_EX_MEM_ztrapvect8;

lc3b_word ID_EX_alumux_out;
lc3b_word ID_EX_MEM_alu;
lc3b_word ID_EX_addermux_out;
lc3b_word ID_EX_MEM_pc_adder_out;

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
logic reset_counter;
logic load_pipeline_reg;

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

/* FORWARDING IMPLEMENTED HERE */
logic [1:0] forwardA_sel;
logic [1:0] forwardB_sel;
lc3b_word forwardA_out;
lc3b_word forwardB_out;
lc3b_reg forward_regA;
lc3b_reg forward_regB;
logic forward_load;
logic controlmux_sel;
lc3b_control_word zero;
lc3b_control_word controlmux_out;
logic ID_EX_bit5_out;

mux3 forwardA
( 
	.sel(forwardA_sel),
	.a(ID_EX_sr1), 
	.b(MEM_WB_alu_out), 
	.c(EX_MEM_alu_out),
	.f(forwardA_out)
);

mux3 forwardB
(
	.sel(forwardB_sel),
	.a(ID_EX_alumux_out), 
	.b(MEM_WB_alu_out), 
	.c(EX_MEM_alu_out),
	.f(forwardB_out)
);
forward Forward_unit
(
	.opcode(ID_EX_ctrl.opcode),
	.bit5(ID_EX_bit5_out),
	.ID_EX_sr1(forward_regA),
	.ID_EX_sr2(forward_regB),
	.EX_MEM_write(EX_MEM_ctrl.load_regfile),
	.MEM_WB_write(MEM_WB_ctrl.load_regfile),
	.EX_MEM_dest(EX_MEM_WB_dest),
	.MEM_WB_dest(MEM_WB_dest),
	.ForwardA(forwardA_sel),
	.ForwardB(forwardB_sel)
		
);

/* HAZARD DETECTION (FOR FORWARDING) */
hazard_detection hd
(
	.ID_EX_mem_read(ID_EX_ctrl.mem_read),
	.ID_EX_dest(ID_EX_MEM_dest),
	.IF_ID_sr1(IF_ID_sr1),
	.IF_ID_sr2(IF_ID_sr2),

	.forward_load(forward_load),
	.controlmux_sel(controlmux_sel)
);
NOPS nops
(
	.zero_signal(zero)
);

mux2 #(.width($bits(lc3b_control_word))) ControlMux
(
	.sel(controlmux_sel),
	.a(IF_ID_ctrl),
	.b(zero),
	.f(controlmux_out)
);
/* FORWARDING IMPLEMENTATION ENDED */


// SET THESE TO ALWAYS STORE 2 BYTES FOR CP1
assign icache_wmask = 2'b11;


//assign load_pc = 1'b1;
assign load_pc = (icache_resp && (load_EX_MEM || branch_enable_true || MEM_WB_ctrl.opcode == op_jsr || MEM_WB_ctrl.opcode == op_trap || MEM_WB_ctrl.opcode == op_jmp));

// assigning RESET SIGNALS
assign reset_IF_ID = (~(icache_resp && (load_EX_MEM || branch_enable_true || MEM_WB_ctrl.opcode == op_jsr || MEM_WB_ctrl.opcode == op_trap || MEM_WB_ctrl.opcode == op_jmp)) && load_pipeline_reg) ? 1'b1 : 1'b0;//1'b0;
assign reset_ID_EX = ((branch_enable_true || MEM_WB_ctrl.opcode == op_jsr || MEM_WB_ctrl.opcode == op_trap || MEM_WB_ctrl.opcode == op_jmp)) ? 1'b1 : 1'b0;//1'b0;
assign reset_EX_MEM = (branch_enable_true || MEM_WB_ctrl.opcode == op_jsr || MEM_WB_ctrl.opcode == op_trap || MEM_WB_ctrl.opcode == op_jmp) ? 1'b1 : 1'b0;//1'b0;
//assign reset_MEM_WB = 1'b0; //branch_enable_true ? 1'b1 : 1'b0;
// assign I-mem signals
assign icache_read = 1'b1;
assign icache_write = 1'b0;
assign icache_address = pc_out;

assign unconditional_branch = MEM_WB_ctrl.opcode == op_jsr || MEM_WB_ctrl.opcode == op_trap || MEM_WB_ctrl.opcode == op_jmp;
assign load_IF_ID=load_pipeline_reg;
assign load_ID_EX=load_pipeline_reg;
assign load_EX_MEM=load_pipeline_reg;
assign load_MEM_WB=(load_pipeline_reg && MEM_WB_ctrl.opcode != op_br && ~unconditional_branch) || (load_pipeline_reg && ~branch_enable_true && ~unconditional_branch) || (load_pipeline_reg && branch_enable_true && icache_resp) 
|| (load_pipeline_reg && unconditional_branch && icache_resp);


staller MEM_WB_stall(
	.op_code(EX_MEM_ctrl.opcode),
	.resp(dcache_resp),
	.mem_read( EX_MEM_ctrl.mem_read),
	.mem_write( EX_MEM_ctrl.mem_write),
	.counter(EX_MEM_counter),
	
	.datamux_sel(EX_MEM_ctrl.datamux_sel),
	.datamux_sel_updated(EX_MEM_datamux_sel),
	.mem_read_updated(dcache_read),
	.mem_write_updated(dcache_write),
	.reset_counter(reset_counter),
	
	.load(load_pipeline_reg)
);

// REGISTERS
register PC
(
  .clk(clk),
  .load(load_pc && forward_load),
  .in(pcmux_out),
  .out(pc_out)
);
/* need to look at this further in our design */
mux5 #(.width(16)) PC_MUX
(
	.sel(pcmux_sel_updated),
	.a(MEM_WB_sr2),
	.b(MEM_WB_pc_adder),
	.c(MEM_WB_dmem),
	.d(pc_plus2),
    .e(MEM_WB_alu_out),                                              
	.f(pcmux_out)

);

plus2 PC_PLUS2
(
	.in(pc_out),
	.out(pc_plus2)
);

/*register #(.width(1)) reset_IF_ID_reg
(
    .clk(clk),
    .load(1'b1),
    .in(~icache_resp)
);*/

IF_ID_reg IF_ID
(
	.clk(clk),
	.load(load_IF_ID && forward_load),
	.reset(reset_IF_ID),

	.inst_in(icache_rdata),
	.pc_in(pc_plus2),

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

sext #(.width(4)) SEXT4
(
  .in(IF_ID_imm4),
  .out(IF_ID_EX_sext4_out)
);

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
  .load(load_ID_EX && !controlmux_sel),
  .reset(reset_ID_EX || controlmux_sel),

  .inst_in(IF_ID_EX_inst),			/* Maybe for debugging purpose only */
  .pc_in(IF_ID_EX_pc),

  .control_in(controlmux_out),	/* changed from ID_ID_ctrl -> controlmux_out */
  .src1_in(IF_ID_sr1),				/* NEWLY ADDED FOR FORWARDING */
  .src2_in(IF_ID_sr2),				/* NEWLY ADDED FOR FORWARDING */
  .reg_a(IF_ID_EX_sr1),
  .reg_b(IF_ID_EX_sr2),
  .dest_in(IF_ID_EX_dest),

  .sext6_in(IF_ID_EX_sext6_out),
  .sext5_in(IF_ID_EX_sext5_out),
  .sext4_in(IF_ID_EX_sext4_out),
  .adj6_in(IF_ID_EX_adj6_out),
  .adj9_in(IF_ID_EX_adj9_out),
  .adj11_in(IF_ID_EX_adj11_out),
  .trap_vect8_in(IF_ID_EX_ztrapvect8),
  .ir5(IF_ID_ir5),					/* ADDED FOR VERIFICATION OF FORWARDING */

  .inst_out(ID_EX_MEM_inst),		/* Maybe for debugging purpose only */
  .pc_out(ID_EX_MEM_pc),

  .control_out(ID_EX_ctrl),
  .sr1(ID_EX_sr1),
  .sr2(ID_EX_sr2),
  .dest_out(ID_EX_MEM_dest),
  .src1_out(forward_regA),									/*NEWLY ADDED FOR FORWARDING */
  .src2_out(forward_regB),									/*NEWLY ADDED FOR FORWARDING */
  .ir5_out(ID_EX_bit5_out),								/* ADDED FOR VERIFICATION OF FORWARDING */
  .sext6_out(ID_EX_sext6),
  .sext5_out(ID_EX_sext5),
  .sext4_out(ID_EX_sext4),
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
  .e(ID_EX_sext4),
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
  .sr2_in(ID_EX_sr2),
  .dest_in(ID_EX_MEM_dest),
  .trap_vect8_in(ID_EX_MEM_ztrapvect8),

  .branch_address_in(ID_EX_MEM_pc_adder_out),

  .inst_out(EX_MEM_WB_inst),
  .pc_out(EX_MEM_WB_pc),

  .control_out(EX_MEM_ctrl),
  .alu_out_out(EX_MEM_alu_out),
  .sr2_out(EX_MEM_sr2),
  .dest_out(EX_MEM_WB_dest),
  .trap_vect8_out(EX_MEM_ztrapvect8),

  .branch_address_out(EX_MEM_WB_pc_adder)
);

byteDetect STOREADDRESS
(
    .in(EX_MEM_alu_out),
	 .signal(EX_MEM_ctrl.writemux_sel),
	 .wmask(dcache_wmask)
);

/* REQUIRED FOR STI/LDI BUT NOT FOR CP1 */
n_bit_counter #(.width(2)) ONE_BIT_COUNTER
(
  .out(EX_MEM_counter),
  .load(dcache_resp && (EX_MEM_ctrl.opcode==op_sti || EX_MEM_ctrl.opcode==op_ldi)),
  .clk(clk),
  .reset(reset_counter)
);

mux2 #(.width(16)) WRITEMUX
(
  .sel(EX_MEM_ctrl.writemux_sel),
  .a(EX_MEM_sr2),
  .b({EX_MEM_sr2[7:0],EX_MEM_sr2[7:0]}),
  .f(dcache_wdata)
);

register #(.width(16)) LDI_STI_ADDRESS
(
	.clk(clk),
	.load(1'b1),
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
  .mem_out_in(dcache_rdata),
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

register #(.width(3)) CC
(
  .clk(clk),
  .load(MEM_WB_ctrl.load_cc),
  .in(gencc_out),
  .out(cc_out)
);

gencc GENCC
(
  .in(regfilemux_out),
  .out(gencc_out)
);

cccomp CCCOMP
(
  .dest(MEM_WB_dest),
  .nzp(cc_out),
  .out(branch_enable)
);

branch_logic BRANCH_LOGIC
(
  .opcode(MEM_WB_ctrl.opcode),
  .branch_enable(branch_enable),
  .pcmux_sel(MEM_WB_ctrl.pcmux_sel),
  .pcmux_sel_updated(pcmux_sel_updated),
  .branch_enable_true(branch_enable_true)
);

register #(.width(1)) reset_MEM_WB_reg
(  
    .clk(clk),
    .load(1'b1),
    .in(icache_resp && (MEM_WB_ctrl.opcode == op_jsr|| MEM_WB_ctrl.opcode == op_trap || MEM_WB_ctrl.opcode == op_jmp || branch_enable_true)),
    .out(reset_MEM_WB)
);

endmodule : cpu_datapath
