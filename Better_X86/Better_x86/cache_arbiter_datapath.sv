import lc3b_types::*;

module cache_arbiter_datapath
(
	input clk,

	input lc3b_word icache_address,
//	input lc3b_l1_line icache_wdata,
	output lc3b_l1_line icache_rdata,
	output logic icache_resp,
	input logic icache_read,
//	input logic icache_write,

	input lc3b_word dcache_address,
	input lc3b_l1_line dcache_wdata,
	output lc3b_l1_line dcache_rdata,
	output logic dcache_resp,
	input logic dcache_read,
	input logic dcache_write,

	input logic cache_address_sel,
	input logic [1:0] cache_read_sel,
	input logic cache_write_sel,
	input logic cache_resp_sel,
	
	input logic load_mar,
	input logic load_mdr_l1_to_l2,
	input logic load_mdr_l2_to_l1,

	output lc3b_word l2cache_address,
	output lc3b_l1_line l2cache_wdata,
	input lc3b_l1_line l2cache_rdata,
	input logic l2_resp
);

lc3b_word addressmux_out;

lc3b_l1_line mdr_l2_to_l1_out;

logic l2_resp_reg_out;
logic cache_resp_sel_reg;
logic readmux_out;
logic writemux_out;

assign icache_rdata = mdr_l2_to_l1_out;
assign dcache_rdata = mdr_l2_to_l1_out;

mux2 #(.width(16)) address
(
	.sel(cache_address_sel),
	.a(icache_address),
	.b(dcache_address),
	.f(addressmux_out)
);

/*mux3 #(.width(1)) read
(
	.sel(cache_read_sel),
	.a(1'b0),
	.b(icache_read),
	.c(dcache_read),
	.f(l2_read)
);

mux2 #(.width(1)) write
(
	.sel(cache_write_sel),
	.a(1'b0),
	.b(dcache_write),
	.f(l2_write)
);*/

demux2 #(.width(1)) resp_demux
(
	.sel(cache_resp_sel_reg),
	.in(l2_resp_reg_out),
	.a(icache_resp),
	.b(dcache_resp)
);

register #(.width(1)) resp_sel_reg
(
    .clk(clk),
    .load(1'b1),
    .in(cache_resp_sel),
    .out(cache_resp_sel_reg)
);

register #(.width(1)) l2_resp_reg
(
    .clk(clk),
    .load(1'b1),
    .in(l2_resp),
    .out(l2_resp_reg_out)
);

/*register #(.width(1)) l2_write_reg
(
    .clk(clk),
    .load(1'b1),
    .in(writemux_out),
    .out(l2_write)
);

register #(.width(1)) l2_read_reg
(
    .clk(clk),
    .load(1'b1),
    .in(readmux_out),
    .out(l2_read)
); */

register #(.width(16)) mar
(
    .clk(clk),
    .load(1'b1),
    .in(addressmux_out),
    .out(l2cache_address)
);

register #(.width(128)) mdr_l1_to_l2
(
    .clk(clk),
    .load(1'b1),
    .in(dcache_wdata),
    .out(l2cache_wdata)
);

register #(.width(128)) mdr_l2_to_l1
(
    .clk(clk),
    .load(1'b1),
    .in(l2cache_rdata),
    .out(mdr_l2_to_l1_out)
);

endmodule : cache_arbiter_datapath