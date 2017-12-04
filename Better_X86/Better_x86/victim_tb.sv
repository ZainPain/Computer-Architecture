import lc3b_types::*;

module victim_tb;

timeunit 1ns;
timeprecision 1ns;
    logic clk;

    // inputs from L2 and pmem
    lc3b_word mem_address;
    lc3b_l2_line mem_wdata;
    logic mem_write;
    logic mem_read;
    lc3b_l2_line pmem_rdata;
    logic pmem_resp;

    // outputs to L2 and pmem
    logic mem_resp;         // to L2
    logic pmem_read;        // to pmem
    logic pmem_write;       // to pmem
    lc3b_word pmem_address; // to pmem
    lc3b_word pmem_wdata;   // to L2 or pmem
    lc3b_word mem_rdata;     // to L2 or pmem

    victim dut(
        .clk(clk),
        .mem_address(mem_address),
        .mem_wdata(mem_wdata),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .pmem_rdata(pmem_rdata),
        .pmem_resp(pmem_resp),

        // outputs to L2 and pmem
        .mem_resp(mem_resp),         // to L2
        .pmem_read(pmem_read),        // to pmem
        .pmem_write(pmem_write),       // to pmem
        .pmem_address(pmem_address), // to pmem
        .pmem_wdata(pmem_wdata),   // to L2 or pmem
        .mem_rdata(mem_rdata)     // to L2 or pmem
        );

    initial
    begin
        mem_read=1'b0; mem_write=1'b0; #10;

        mem_wdata=128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
        mem_write=1'b1; #10;
    end

    always
    begin
        clk <= 1; #5;
        clk <= 0; #5;
    end

endmodule:victim_tb
