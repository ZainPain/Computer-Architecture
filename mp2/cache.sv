import lc3b_types::*;
module cache
(
	input logic clk,
	
	output lc3b_word pmem_address,
	input lc3b_data pmem_rdata,
	output lc3b_data pmem_wdata,
	output pmem_read,
	output pmem_write,
	input pmem_resp,
	
	output mem_resp,
	output lc3b_word mem_rdata,
   input mem_read,
   input mem_write,
   input lc3b_mem_wmask mem_byte_enable,
   input lc3b_word mem_address,
   input lc3b_word mem_wdata

);
/* LOAD SIGNALS */
	logic load_tag1;
	logic load_tag2;
	logic load_valid1;
	logic load_valid2;
	logic load_data1;
	logic load_data2;
	logic load_lru;
	logic load_dirty1;
	logic load_dirty2;
	logic hit;
	logic way_select;
	/* LOAD SIGNALS END */
	
	/* SELECT SIGNALS  */
	logic hit2_out;
	/* SELECT SIGNALS END */
	
	/* DATA IN SIGNALS */
	lc3b_data data1_in;
	lc3b_data data2_in;
	lc3b_tag tag1_in;
	lc3b_tag tag2_in;
	logic valid1_in;
	logic valid2_in;
	logic valid1_out;
	logic valid2_out;
	logic dirty1_in;
	logic dirty2_in;
	logic lru_in;
	logic lru_out;
	logic dirty1_out;
	logic dirty2_out;
	logic writemux1_sel;
	logic writemux2_sel;
	logic pmem_write_sel;
	logic pmem_sel;
	/* DATA IN SIGNALS END */
	
/** INSTANTIATE CACHE DATAPATH **/
cache_datapath CACHE_DATAPATH
(	
	.clk(clk),
	
	/* LOAD SIGNALS */
	.load_tag1(load_tag1),
	.load_tag2(load_tag2),
	.load_valid1(load_valid1),
	.load_valid2(load_valid2),
	.load_data1(load_data1),
	.load_data2(load_data2),
	.load_lru(load_lru),
	.load_dirty1(load_dirty1),
	.load_dirty2(load_dirty2),
	.hit(hit),
	.hit2_out(hit2_out),
	/* LOAD SIGNALS END */

	/* DATA IN SIGNALS */

	.valid1_in(valid1_in),
	.valid2_in(valid2_in),
	.valid1_out(valid1_out),
	.valid2_out(valid2_out),
	.dirty1_in(dirty1_in),
	.dirty2_in(dirty2_in),
	.lru_in(lru_in),
	.lru_out(lru_out),
	
	.dirty1_out(dirty1_out),
	.dirty2_out(dirty2_out),
	/* DATA IN SIGNALS END */
	.writemux1_sel(writemux1_sel),
	.writemux2_sel(writemux2_sel),
	.pmem_write_sel(pmem_write_sel),
	.pmem_sel(pmem_sel),
	/** MEM SIGNALS **/
	.mem_address(mem_address),
	.pmem_rdata(pmem_rdata),
	.mem_wdata(mem_wdata),
	.mem_byte_enable(mem_byte_enable),
	.mem_rdata(mem_rdata),
	.pmem_wdata(pmem_wdata),	
	.pmem_address(pmem_address)
	/** MEM SIGNALS END **/
	
);
/** INSTANTIATE CACHE CONTROL **/
cache_control CACHE_CONTROLLER
(
	
	.clk(clk),
	/* control signals */
	.hit(hit),
	.hit2_out(hit2_out),
	/* load signals */
	.load_tag1(load_tag1),
	.load_tag2(load_tag2),
	.load_lru(load_lru),
	.load_data1(load_data1),
	.load_data2(load_data2),
	.load_valid1(load_valid1),
	.load_valid2(load_valid2),
	.load_dirty1(load_dirty1),
	.load_dirty2(load_dirty2),
	
	.valid1_in(valid1_in),
	.valid2_in(valid2_in),
	.valid1_out(valid1_out),
	.valid2_out(valid2_out),
	.lru_in(lru_in),
	.lru_out(lru_out),
	.dirty1_in(dirty1_in),
	.dirty2_in(dirty2_in),
	.dirty1_out(dirty1_out),
	.dirty2_out(dirty2_out),
	
	.writemux1_sel(writemux1_sel),
	.writemux2_sel(writemux2_sel),
	.pmem_write_sel(pmem_write_sel),
	.pmem_sel(pmem_sel),
	/* mem signals */
	.mem_read(mem_read),
	.mem_write(mem_write),
	.pmem_resp(pmem_resp),
	.mem_byte_enable(mem_byte_enable),
	
	.mem_resp(mem_resp),
	.pmem_read(pmem_read),
	.pmem_write(pmem_write)
	
);
endmodule : cache