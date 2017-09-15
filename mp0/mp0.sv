import lc3b_types::*;

module mp0
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
	 logic pcmux_sel;
	 logic storemux_sel;
	 logic alumux_sel;
	 logic regfilemux_sel;
	 logic marmux_sel;
	 logic mdrmux_sel;
	 lc3b_aluop aluop;
	 logic branch_enable;
	 lc3b_opcode opcode;
	 
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
	 
	 /* Select signals */
	 
	 .pcmux_sel(pcmux_sel),
	 .storemux_sel(storemux_sel),
	 .alumux_sel(alumux_sel),
	 .regfilemux_sel(regfilemux_sel),
	 .marmux_sel(marmux_sel),
	 .mdrmux_sel(mdrmux_sel),
	 .aluop(aluop),
	 
	 .mem_rdata(mem_rdata),
	 .branch_enable(branch_enable),
	 .opcode(opcode),
	 .mem_address(mem_address),
	 .mem_wdata(mem_wdata)
	
);

control Control
(
	.clk,
	 
	 /* Datapath controls */
	 
	 .opcode(opcode),
	 .branch_enable(branch_enable), 
	 
	 /* Datapath Loads */
	 .load_pc(load_pc),
	 .load_ir(load_ir),
	 .load_regfile(load_regfile),
	 .load_mar(load_mar),
	 .load_mdr(load_mdr),
	 .load_cc(load_cc),
	 
	 /* Datapath mux select bits */
	 .pcmux_sel(pcmux_sel),
	 .storemux_sel(storemux_sel),
	 .alumux_sel(alumux_sel),
	 .regfilemux_sel(regfilemux_sel),
	 .marmux_sel(marmux_sel),
	 .mdrmux_sel(mdrmux_sel),
	 
	 /*Datapth ALU */
	 .aluop(aluop),
	 
	 /* Memory signals */
	.mem_resp(mem_resp),
	.mem_read(mem_read),
	.mem_write(mem_write),
	.mem_byte_enable(mem_byte_enable)

);

endmodule : mp0
