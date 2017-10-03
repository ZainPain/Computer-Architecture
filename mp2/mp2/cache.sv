import lc3b_types::*;
module cache
(
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
	
/** INSTANTIATE CACHE DATAPATH **/

/** INSTANTIATE CACHE CONTROL **/
endmodule : cache