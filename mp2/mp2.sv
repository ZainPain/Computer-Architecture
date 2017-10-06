import lc3b_types::*;

module mp2
(
    input clk,
    input pmem_resp,
    input lc3b_data pmem_rdata,
    output pmem_read,
    output pmem_write,
    output lc3b_word pmem_address,
    output lc3b_data pmem_wdata
);

logic mem_resp;
logic mem_read;
logic mem_write;
lc3b_word mem_rdata;
lc3b_word mem_wdata;
lc3b_word mem_address;
logic [1:0] mem_byte_enable;

/** INSTANTIATE CPU **/
cpu CPU
(
    .clk(clk),

    /* Memory signals */
    .mem_resp(mem_resp),
    .mem_rdata(mem_rdata),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .mem_byte_enable(mem_byte_enable),
    .mem_address(mem_address),
    .mem_wdata(mem_wdata)
);
/** INSTANTIATE CACHE **/
cache CACHE
(
	.clk(clk),
	.pmem_address(pmem_address),
	.pmem_rdata(pmem_rdata),
	.pmem_wdata(pmem_wdata),
	.pmem_read(pmem_read),
	.pmem_write(pmem_write),
	.pmem_resp(pmem_resp),
	
	.mem_resp(mem_resp),
	.mem_rdata(mem_rdata),
	.mem_read(mem_read),
	.mem_write(mem_write),
	.mem_byte_enable(mem_byte_enable),
	.mem_address(mem_address),
   .mem_wdata(mem_wdata)

);
endmodule : mp2