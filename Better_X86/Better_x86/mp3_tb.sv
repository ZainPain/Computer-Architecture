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

/*lc3b_word icache_address;
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

lc3b_word pc;
logic branch_prediction;

lc3b_word updated_pc;

//BTB update
logic unconditional_branch;
logic branch_taken;
lc3b_word branch_taken_pc;
lc3b_word branch_taken_target;

initial
begin
    clk = 1;
    pc = 16'b0;
    branch_prediction = 0;
    unconditional_branch = 0;
    branch_taken = 1;
    branch_taken_pc = 16'h1111;
    branch_taken_target = 16'h1111; #10;

    branch_taken_pc = 16'h2222;
    branch_taken_target = 16'h2222; #10;

    branch_taken_pc = 16'h3333;
    branch_taken_target = 16'h3333; #10;

    branch_taken_pc = 16'h4444;
    branch_taken_target = 16'h4444; #10;

    branch_taken_pc = 16'h5555;
    branch_taken_target = 16'h5555; #10;

    branch_taken_pc = 16'h6666;
    branch_taken_target = 16'h6666; #10;

    branch_taken_pc = 16'h7777;
    branch_taken_target = 16'h7777; #10;

    unconditional_branch = 1;
    branch_taken_pc = 16'h8888;
    branch_taken_target = 16'h8888; #10;

    unconditional_branch = 0;
    branch_taken_pc = 16'h9999;
    branch_taken_target = 16'h9999; #10;

    branch_taken_pc = 16'h9999;
    branch_taken_target = 16'h9999; #10;

    branch_taken_pc = 16'hAAAA;
    branch_taken_target = 16'hAAAA; #10;

    branch_taken_pc = 16'hBBBB;
    branch_taken_target = 16'hBBBB; #10;

    branch_taken_pc = 16'hCCCC;
    branch_taken_target = 16'hCCCC; #10;

    branch_taken_pc = 16'hDDDD;
    branch_taken_target = 16'hDDDD; #10;

    branch_taken_pc = 16'hEEEE;
    branch_taken_target = 16'hEEEE; #10;

    branch_taken_pc = 16'hFFFF;
    branch_taken_target = 16'hFFFF; #10;

    branch_taken_pc = 16'h0000;
    branch_taken_target = 16'h0000; #10;

    branch_taken_pc = 16'h1110;
    branch_taken_target = 16'h1110; #10;

    branch_taken_pc = 16'h2220;
    branch_taken_target = 16'h2220; #10;

    branch_taken_pc = 16'h3330;
    branch_taken_target = 16'h3330; #10;

    branch_taken = 0;

    pc = 16'h4444;
    branch_prediction = 1; #10;

    branch_prediction = 0;
    pc = 16'h8888; #10;

    branch_taken = 1;
    branch_taken_pc = 16'h5550;
    branch_taken_target = 16'h5550; #10;
    /*
    pc = 16'h1234;
    branch_prediction = 1; #10;

    pc = 16'h3456;
    branch_prediction = 1; #10;

    pc = 16'h6598;
    branch_prediction = 1; #10;

    branch_taken = 0;
    branch_taken_pc = 16'h0968;
    branch_taken_target = 16'h096a; #10;

    branch_prediction = 1;
    pc = 16'h1234;
    branch_taken = 0;
    branch_taken_pc = 16'h1234; #10;

    branch_prediction = 1;
    pc = 16'h1111;
    branch_taken = 1;
    branch_taken_pc = 16'h1111;
    branch_taken_target = 16'h2222; #10; */


    /*icache_address = '0;
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

/*btb dut
(
  .clk(clk),
  .pc(pc),
	.branch_prediction(branch_prediction),

	.updated_pc(updated_pc),

	.branch_taken(branch_taken),
  .unconditional_branch(unconditional_branch),
	.branch_taken_pc(branch_taken_pc),
	.branch_taken_target(branch_taken_target)
); */

mp3 dut
(
    .clk(clk),

    //Physical Memory
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
