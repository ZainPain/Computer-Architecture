import lc3b_types::*;

module memory_caches
(
	input clk,

    /* Instruction Memory */
    input icache_read_cpu,
    input icache_write_cpu,
    input [1:0] icache_wmask_cpu,
    input lc3b_word icache_address_cpu,
    input lc3b_word icache_wdata_cpu,
    output logic icache_resp_cpu,
    output lc3b_word icache_rdata_cpu,

    /* Data Memory */
    input dcache_read_cpu,
    input dcache_write_cpu,
    input [1:0] dcache_wmask_cpu,
    input lc3b_word dcache_address_cpu,
    input lc3b_word dcache_wdata_cpu,
    output logic dcache_resp_cpu,
    output lc3b_word dcache_rdata_cpu,

    /* Physical Memory */
    input pmem_resp,
    input lc3b_l1_line pmem_rdata,
    output pmem_read,
    output pmem_write,
    output lc3b_word pmem_address,
    output lc3b_l1_line pmem_wdata

);

lc3b_word icache_address_arbiter;
lc3b_l1_line icache_rdata_arbiter;
logic icache_resp_arbiter;
logic icache_read_arbiter;

lc3b_word dcache_address_arbiter;
lc3b_l1_line dcache_wdata_arbiter;
lc3b_l1_line dcache_rdata_arbiter;
logic dcache_resp_arbiter;
logic dcache_read_arbiter;
logic dcache_write_arbiter;

cache_arbiter arbiter
(
	.clk(clk),
	
	.icache_address(icache_address_arbiter),
	.icache_rdata(icache_rdata_arbiter),
	.icache_resp(icache_resp_arbiter),
	.icache_read(icache_read_arbiter),

	.dcache_address(dcache_address_arbiter),
	.dcache_wdata(dcache_wdata_arbiter),
	.dcache_rdata(dcache_rdata_arbiter),
	.dcache_resp(dcache_resp_arbiter),
	.dcache_read(dcache_read_arbiter),
	.dcache_write(dcache_write_arbiter),

	/* These inputs are connected to physical memory
	for CP2. They will be swicthed L2 for CP3 and
	L2 will be connected to physical memory instead */
	.l2cache_address(pmem_address),
	.l2cache_wdata(pmem_wdata),
	.l2cache_rdata(pmem_rdata),
	.l2_resp(pmem_resp),
	.l2_read(pmem_read),
	.l2_write(pmem_write)
);

l1_cache icache
(
	.clk(clk),
    .mem_rdata(icache_rdata_cpu),
    .mem_address(icache_address_cpu),
    .mem_wdata(icache_wdata_cpu),
    .mem_resp(icache_resp_cpu),
    .mem_read(icache_read_cpu),
    .mem_write(icache_write_cpu),
    .mem_byte_enable(icache_wmask_cpu),
    
    .pmem_rdata(icache_rdata_arbiter),
    .pmem_address(icache_address_arbiter),
    .pmem_wdata(),
    .pmem_resp(icache_resp_arbiter),
    .pmem_read(icache_read_arbiter),
    .pmem_write()
);

l1_cache dcache
(
	.clk(clk),
    .mem_rdata(dcache_rdata_cpu),
    .mem_address(dcache_address_cpu),
    .mem_wdata(dcache_wdata_cpu),
    .mem_resp(dcache_resp_cpu),
    .mem_read(dcache_read_cpu),
    .mem_write(dcache_write_cpu),
    .mem_byte_enable(dcache_wmask_cpu),
    
    .pmem_rdata(dcache_rdata_arbiter),
    .pmem_address(dcache_address_arbiter),
    .pmem_wdata(dcache_wdata_arbiter),
    .pmem_resp(dcache_resp_arbiter),
    .pmem_read(dcache_read_arbiter),
    .pmem_write(dcache_write_arbiter)
);

endmodule : memory_caches