import lc3b_types::*;

module cache_arbiter
(
	input clk,

	input lc3b_word icache_address,
	output lc3b_l1_line icache_rdata,
	output logic icache_resp,
	input logic icache_read,

	input lc3b_word dcache_address,
	input lc3b_l1_line dcache_wdata,
	output lc3b_l1_line dcache_rdata,
	output logic dcache_resp,
	input logic dcache_read,
	input logic dcache_write,

	output lc3b_word l2cache_address,
	output lc3b_l1_line l2cache_wdata,
	input lc3b_l1_line l2cache_rdata,
	input logic l2_resp,
	output logic l2_read,
	output logic l2_write
);

logic cache_address_sel;
logic [1:0] cache_read_sel;
logic cache_write_sel;
logic cache_resp_sel;
logic load_mar;
logic load_mdr_l1_to_l2;
logic load_mdr_l2_to_l1;

cache_arbiter_datapath cad
(
	.clk(clk),

	.icache_address(icache_address),
	.icache_rdata(icache_rdata),
	.icache_resp(icache_resp),
	.icache_read(icache_read),

	.dcache_address(dcache_address),
	.dcache_wdata(dcache_wdata),
	.dcache_rdata(dcache_rdata),
	.dcache_resp(dcache_resp),
	.dcache_read(dcache_read),
	.dcache_write(dcache_write),

	.cache_address_sel(cache_address_sel),
	.cache_read_sel(cache_read_sel),
	.cache_write_sel(cache_write_sel),
	.cache_resp_sel(cache_resp_sel),

	.load_mar(load_mar),
	.load_mdr_l1_to_l2(load_mdr_l1_to_l2),
	.load_mdr_l2_to_l1(load_mdr_l2_to_l1),

	.l2cache_address(l2cache_address),
	.l2cache_wdata(l2cache_wdata),
	.l2cache_rdata(l2cache_rdata),
	.l2_resp(l2_resp)

	//.load_dcache_resp(load_dcache_resp),
	//.load_icache_resp(load_icache_resp)
);

cache_arbiter_control cac
(
	.clk(clk),
	
	.icache_read(icache_read),
	.dcache_read(dcache_read),
	.dcache_write(dcache_write),
	.l2_resp(l2_resp),

	.cache_address_sel(cache_address_sel),
	.cache_read_sel(cache_read_sel),
	.cache_write_sel(cache_write_sel),
	.cache_resp_sel(cache_resp_sel),
	.load_mar(load_mar),
	.load_mdr_l1_to_l2(load_mdr_l1_to_l2),
	.load_mdr_l2_to_l1(load_mdr_l2_to_l1),
	.l2_read(l2_read),
	.l2_write(l2_write)

	//.load_dcache_resp(load_dcache_resp),
	//.load_icache_resp(load_icache_resp)
);
endmodule : cache_arbiter