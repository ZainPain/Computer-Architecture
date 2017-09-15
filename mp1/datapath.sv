import lc3b_types::*;

module datapath
(
    input clk,
	 
	 /* Load Signals */
	 
	 input load_pc,
	 input load_ir,
	 input load_regfile,
	 input load_mar,
	 input load_mdr,
	 input load_cc,
	 input mask_enable,
	 
	 /* Select signals */
	 
	 input [1:0] pcmux_sel,
	 input storemux_sel,
	 input alumux_sel,
	 input [1:0] regfilemux_sel,
	 input [1:0] marmux_sel,
	 input mdrmux_sel,
	 input adjmux_sel,
	 
	 input lc3b_aluop aluop,
	 input lc3b_aluop aluop_imm,
	 
	 input lc3b_word mem_rdata,
	 output logic branch_enable,
	 output lc3b_opcode opcode,
	 output lc3b_word mem_address,
	 output lc3b_word mem_wdata,
	 
	 output logic imm,
	 output logic bit11
);

/* declare internal signals */
lc3b_word pcmux_out;
lc3b_word pc_out;
lc3b_word br_add_out;
lc3b_word pc_plus2_out;

lc3b_reg sr1;
lc3b_reg sr2;
lc3b_reg dest;
lc3b_reg storemux_out;

logic [4:0] imm5;
    
lc3b_word sr1_out;
lc3b_word sr2_out;

lc3b_word adj5_out;
lc3b_word adj6_out;
lc3b_word adj9_out;
lc3b_word adj11_out;
lc3b_word adjnoshift_out;

lc3b_word mask_out;

lc3b_word alumux_out;
lc3b_word regfilemux_out;
lc3b_word marmux_out;
lc3b_word mdrmux_out;
lc3b_word adjmux_out;
lc3b_word wdata_out;
lc3b_word byte_out;


lc3b_word alu_out;
lc3b_word alu_imm_out;

lc3b_nzp gencc_out;
lc3b_nzp cc_out;

lc3b_offset9 offset9;
lc3b_offset6 offset6;
lc3b_offset11 offset11;
lc3b_word adj11_plus_pc_out;
/* Instantiating mux2 */
mux2 #(.width(3)) storemux
(
	.sel(storemux_sel),
	.a(sr1),
	.b(dest),
	.f(storemux_out)
);


mux4 #(.width(16)) pcmux
(
    .sel(pcmux_sel),
    .a(pc_plus2_out),
    .b(br_add_out),
	 .c(sr1_out),
	 .d(adj11_plus_pc_out),
    .f(pcmux_out)
);

plus2 _plus2
(
	.in(pc_out),
	.out(pc_plus2_out)
);
register pc
(
    .clk,
    .load(load_pc),
    .in(pcmux_out),
    .out(pc_out)
);
adder #(.width(16))_adder
(
	.adj9_out(adj9_out),
	.in(pc_out),
	.out(br_add_out)
);

adj #(.width(11)) ADJ11
(
	.in(offset11),
	.out(adj11_out)
);

adj #(.width(9)) ADJ9
(
	.in(offset9),
	.out(adj9_out)
);
adder #(.width(16))_adder2
(
	.adj9_out(adj11_out),
	.in(pc_out),
	.out(adj11_plus_pc_out)
);
mux3 marmux
(
	.sel(marmux_sel),
	.a(alu_out),
	.b(pc_out),
	.c(mem_wdata),
	.f(marmux_out)
);

register MAR
(
	.clk,
	.load(load_mar),
	.in(marmux_out),
	.out(mem_address)
);

mux2 mdrmux
(
	.sel(mdrmux_sel),
	.a(alu_out),
	.b(mem_rdata),
	.f(mdrmux_out)
);

register MDR 
(
	.clk,
	.load(load_mdr),
	.in(mdrmux_out),
	.out(mem_wdata)
);

mux4 regfilemux
(
	.sel(regfilemux_sel),
	.a(alu_imm_out),
	.b(wdata_out),
	.c(br_add_out),
	.d(pc_out),
	.f(regfilemux_out)
);

gencc GENCC
(
	.in(regfilemux_out),
	.out(gencc_out)
);

register #(.width(3)) CC 
(
	.clk,
	.load(load_cc),
	.in(gencc_out),
	.out(cc_out)
);
cccomp CCCOMP
(
	.dest(dest),
	.nzp(cc_out),
	.out(branch_enable)
);

ir IR
(
	 .clk,
    .load(load_ir),
    .in(mem_wdata),
    .opcode(opcode),
    .dest(dest),
	 .src1(sr1),
	 .src2(sr2),
    .offset6(offset6),
    .offset9(offset9),
	 .offset11(offset11),
	 .imm(imm),
	 .imm5(imm5),
	 .bit11(bit11)
);
adj #(.width(6)) ADJ6 
(
	.in(offset6),
	.out(adj6_out)
);
adj_imm #(.width(6)) adj6_no_shift
(
	.in(offset6),
	.out(adjnoshift_out)
);
mux2 #(.width(16)) adjmux
(
	.sel(adjmux_sel),
	.a(adj6_out),
	.b(adjnoshift_out),
	.f(adjmux_out)
);
mux2 #(.width(16)) alumux
(
	.sel(alumux_sel),
	.a(sr2_out),
	.b(adjmux_out),
	.f(alumux_out)
);

regfile REGFILE 
(
	 .clk,
    .load(load_regfile),
    .in(regfilemux_out),
    .src_a(storemux_out), 
	 .src_b(sr2),
	 .dest(dest),
    .reg_a(sr1_out), 
	 .reg_b(sr2_out)
);


alu ALU
(
    .aluop(aluop),
    .a(sr1_out),
	 .b(alumux_out),
    .f(alu_out)
);
adj_imm #(.width(5))ADJ5
(
	.in(imm5),
	.out(adj5_out)
);

alu ALU_IMM
(
    .aluop(aluop_imm),
    .a(alu_out),
	 .b(adj5_out),
    .f(alu_imm_out)
	 
);
mask #(.width(16)) Mask
(
    .in(mem_wdata),
	 .address(alu_out),
	 .mask_enable(mask_enable),
    .mask_out(wdata_out)
);
//byte_select #(.width(16)) byteSelect
//(
//	.in(mem_wdata),
//	.address(alu_out),
//	.out(byte_out)
//);
//mux2 #(.width(16)) wdata_mux
//(
//	.sel(mask_enable),
//	.a(mem_wdata),
//	.b(byte_out),
//	.f(wdata_out)
//);
//

endmodule : datapath
