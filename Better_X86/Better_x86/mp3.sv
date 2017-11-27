import lc3b_types::*;

module mp3
(
    input clk,
    
    /* Physical Memory */
    input pmem_resp,
    input lc3b_l1_line pmem_rdata,
    output pmem_read,
    output pmem_write,
    output lc3b_word pmem_address,
    output lc3b_l1_line pmem_wdata
);

lc3b_word icache_address;
lc3b_word icache_wdata;
lc3b_word icache_rdata;
logic icache_resp;
logic icache_read;
logic icache_write;
logic [1:0] icache_wmask;

lc3b_word dcache_address;
lc3b_word dcache_wdata;
lc3b_word dcache_rdata;
logic dcache_resp;
logic dcache_read;
logic dcache_write;
logic [1:0] dcache_wmask;

logic l2cache_resp;

cpu_datapath cpu_d
(
    .clk(clk),

    /* Instruction Memory */
    .icache_read(icache_read),
    .icache_write(icache_write),
    .icache_wmask(icache_wmask),
    .icache_address(icache_address),
    .icache_wdata(icache_wdata),
    .icache_resp(icache_resp),
    .icache_rdata(icache_rdata),

    /* Data Memory */
    .dcache_read(dcache_read),
    .dcache_write(dcache_write),
    .dcache_wmask(dcache_wmask),
    .dcache_address(dcache_address),
    .dcache_wdata(dcache_wdata),
    .dcache_resp(dcache_resp),
    .dcache_rdata(dcache_rdata),
	 
	 .l2cache_resp(l2cache_resp)
);

memory_caches caches
(
    .clk(clk),

    /* Instruction Memory */
    .icache_read_cpu(icache_read),
    .icache_write_cpu(icache_write),
    .icache_wmask_cpu(icache_wmask),
    .icache_address_cpu(icache_address),
    .icache_wdata_cpu(icache_wdata),
    .icache_resp_cpu(icache_resp),
    .icache_rdata_cpu(icache_rdata),

    /* Data Memory */
    .dcache_read_cpu(dcache_read),
    .dcache_write_cpu(dcache_write),
    .dcache_wmask_cpu(dcache_wmask),
    .dcache_address_cpu(dcache_address),
    .dcache_wdata_cpu(dcache_wdata),
    .dcache_resp_cpu(dcache_resp),
    .dcache_rdata_cpu(dcache_rdata),

    /* Physical Memory */
    .pmem_resp(pmem_resp),
    .pmem_rdata(pmem_rdata),
    .pmem_read(pmem_read),
    .pmem_write(pmem_write),
    .pmem_address(pmem_address),
    .pmem_wdata(pmem_wdata),
	 
	 .l2cache_resp(l2cache_resp)
);

endmodule : mp3