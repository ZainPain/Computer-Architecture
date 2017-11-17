import lc3b_types::*;

module mp3_tb;

timeunit 1ns;
timeprecision 1ns;

logic clk;
/* I-Cache... not using it yet
logic read_a;
logic write_a;
logic [1:0] wmask_a;
logic [15:0] address_a;
logic [15:0] wdata_a;
logic resp_a;
logic [15:0] rdata_a;

 D-Cache... not using it yet
logic read_b;
logic write_b;
logic [1:0] wmask_b;
logic [15:0] address_b;
logic [15:0] wdata_b;
logic resp_b;
logic [15:0] rdata_b; */

logic pmem_resp;
lc3b_l1_line pmem_rdata;
logic pmem_read;
logic pmem_write;
lc3b_word pmem_address;
lc3b_l1_line pmem_wdata;

lc3b_word icache_address;
lc3b_l1_line icache_rdata;
logic icache_resp;
logic icache_read;

lc3b_word dcache_address;
lc3b_l1_line dcache_wdata;
lc3b_l1_line dcache_rdata;
logic dcache_resp;
logic dcache_read;
logic dcache_write;

lc3b_word l2cache_address;
lc3b_l1_line l2cache_wdata;
lc3b_l1_line l2cache_rdata;
logic l2_resp;
logic l2_read;
logic l2_write;

/*initial 
begin
    clk = 0;
    icache_address = '0;
    icache_read = '0;
    
    dcache_address = '0;
    dcache_wdata = '0;
    dcache_read = '0;
    dcache_write = '0; 
    
    l2cache_rdata = '0;
    l2_resp = 0; #10;
    
    icache_read = 1;
    icache_address = 16'h1234; #10;
    
    l2_resp = 1;
    l2cache_rdata = 128'h1CACE; #10;
    
    icache_read = 0;
    l2_resp = 0; #10;
    
    dcache_read = 1;
    dcache_address = 16'h5678; #10;
    
    l2_resp = 1; 
    l2cache_rdata = 128'hDCACE; #10;
    
    l2_resp = 0;
end */

/* Clock generator */
initial clk = 0;
always #5 clk = ~clk;

mp3 dut
(
    .clk(clk),
    
    /* Physical Memory */
    .pmem_resp(pmem_resp),
    .pmem_rdata(pmem_rdata),
    .pmem_read(pmem_read),
    .pmem_write(pmem_write),
    .pmem_address(pmem_address),
    .pmem_wdata(pmem_wdata)

);

physical_memory memory
(
    .clk(clk),
    .read(pmem_read),
    .write(pmem_write),
    .address(pmem_address),
    .wdata(pmem_wdata),
    .resp(pmem_resp),
    .rdata(pmem_rdata)
);

/*cache_arbiter dut
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

	.l2cache_address(l2cache_address),
	.l2cache_wdata(l2cache_wdata),
	.l2cache_rdata(l2cache_rdata),
	.l2_resp(l2_resp),
	.l2_read(l2_read),
	.l2_write(l2_write)
); */



endmodule : mp3_tb
