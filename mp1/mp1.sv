import lc3b_types::*;

module mp1
(
    input clk,

    /* Memory signals */
    input mem_resp,
    input lc3b_word mem_rdata,
    output mem_read,
    output mem_write,
    output lc3b_mem_wmask mem_byte_enable,
    output lc3b_word mem_address,
    output lc3b_word mem_wdata
);
/* Instantiate MP 0 top level blocks here */

	 /* DATAPATH/CONTROL signals */
	 logic load_pc;
	 logic load_ir;
	 logic load_regfile;
	 logic load_mar;
	 logic load_mdr;
	 logic load_cc;
	 logic mask_enable;
	 logic truncate;
	 logic shift;
	 logic [1:0] pcmux_sel;
	 logic storemux_sel;
	 logic [1:0] alumux_sel;
	 logic [1:0] regfilemux_sel;
	 logic [1:0]marmux_sel;
	 logic mdrmux_sel;
	 logic adjmux_sel;
	 lc3b_aluop aluop;
	 lc3b_aluop aluop_imm;
	 logic branch_enable;
	 lc3b_opcode opcode;
	 logic imm;
	 logic bit11;
	 logic bit4;
	 lc3b_word alu_out;
	 
datapath Datapath
(
	.clk,
	 
	 /* Load Signals */
	 
	 .load_pc(load_pc),
	 .load_ir(load_ir),
	 .load_regfile(load_regfile),
	 .load_mar(load_mar),
	 .load_mdr(load_mdr),
	 .load_cc(load_cc),
	 .mask_enable(mask_enable),
	 .truncate(truncate),
	 .shift(shift),
	 /* Select signals */
	 
	 .pcmux_sel(pcmux_sel),
	 .storemux_sel(storemux_sel),
	 .alumux_sel(alumux_sel),
	 .regfilemux_sel(regfilemux_sel),
	 .marmux_sel(marmux_sel),
	 .mdrmux_sel(mdrmux_sel),
	 .adjmux_sel(adjmux_sel),
	 
	 .aluop(aluop),
	 .aluop_imm(aluop_imm),
	 
	 .mem_rdata(mem_rdata),
	 .branch_enable(branch_enable),
	 .opcode(opcode),
	 .mem_address(mem_address),
	 .mem_wdata(mem_wdata),
	 .imm(imm),
	 .bit11(bit11),
	 .bit4(bit4),
	 .alu_out(alu_out)
	
);

control Control
(
	.clk,
	 
	 /* Datapath controls */
	 
	 .opcode(opcode),
	 .branch_enable(branch_enable), 
	 .imm(imm),
	 .bit11(bit11),
	 .bit4(bit4),
	 .alu_out(alu_out),
	 /* Datapath Loads */
	 .load_pc(load_pc),
	 .load_ir(load_ir),
	 .load_regfile(load_regfile),
	 .load_mar(load_mar),
	 .load_mdr(load_mdr),
	 .load_cc(load_cc),
	 .mask_enable(mask_enable),
	 .truncate(truncate),
	 .shift(shift),
	 /* Datapath mux select bits */
	 .pcmux_sel(pcmux_sel),
	 .storemux_sel(storemux_sel),
	 .alumux_sel(alumux_sel),
	 .regfilemux_sel(regfilemux_sel),
	 .marmux_sel(marmux_sel),
	 .mdrmux_sel(mdrmux_sel),
	 .adjmux_sel(adjmux_sel),
	 
	 /*Datapth ALU */
	 .aluop(aluop),
	 .aluop_imm(aluop_imm),
	 
	 /* Memory signals */
	.mem_resp(mem_resp),
	.mem_read(mem_read),
	.mem_write(mem_write),
	.mem_byte_enable(mem_byte_enable)

);

endmodule : mp1
