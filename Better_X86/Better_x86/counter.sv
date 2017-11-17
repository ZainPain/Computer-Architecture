import lc3b_types::*;

module counter
(
    input clk,
    input logic mem_resp,
    input logic mem_read,
    input mem_write,
    output logic[15:0] cache_misses
);
    logic[15:0] counter;
    logic make_conditions_shorter;

    always_comb
        assign cache_misses=counter;

    initial
    begin
        make_conditions_shorter=0;
        cache_misses=counter;
    end

    always_ff @(posedge clk)
    begin
        make_conditions_shorter<=(mem_read | mem_write)&~mem_resp;

        if((mem_read | mem_write & ~mem_resp & ~make_conditions_shorter))
            counter<=counter+1;
    end

endmodule : counter
