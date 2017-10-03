import lc3b_types::*;
module cache
(
	input clk,
	
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
	/* LOAD SIGNALS END */
	
	/* SELECT SIGNALS  */
	logic eviction;
	/* SELECT SIGNALS END */
	
	/* DATA IN SIGNALS */
	lc3b_data data1_in;
	lc3b_data data2_in;
	lc3b_tag tag1_in;
	lc3b_tag tag2_in;
	logic valid1_in;
	logic valid2_in;
	logic dirty1_in;
	logic dirty2_in;
	logic lru_in;
	logic dirty1_out;
	logic dirty2_out;
	/* DATA IN SIGNALS END */
	
/* SOME ASSIGNMENTS */
assign pmem_address = mem_address;
assign pmem_read = mem_read;
assign pmem_write = mem_write;
assign mem_resp = pmem_resp;

/** INSTANTIATE CACHE DATAPATH **/
cache_datapath DATAPATH
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
	/* LOAD SIGNALS END */
	
	/* SELECT SIGNALS  */
	.eviction(eviction),
	/* SELECT SIGNALS END */
	
	/* DATA IN SIGNALS */
	.data1_in(data1_in),
	.data2_in(data2_in),
	.tag1_in(tag1_in),
	.tag2_in(tag2_in),
	.valid1_in(valid1_in),
	.valid2_in(valid2_in),
	.dirty1_in(dirty1_in),
	.dirty2_in(dirty2_in),
	.lru_in(lru_in),
	.dirty1_out(dirty1_out),
	.dirty2_out(dirty2_out),
	/* DATA IN SIGNALS END */
	
	/** MEM SIGNALS **/
	.mem_address(mem_address),
	.mem_rdata(mem_rdata)
	/** MEM SIGNALS END **/
	
);
/** INSTANTIATE CACHE CONTROL **/
endmodule : cache