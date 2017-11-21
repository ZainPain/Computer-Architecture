import lc3b_types::*;

module l2_cache
(
    input clk,
    output lc3b_l1_line mem_rdata,
    input lc3b_word mem_address,
    input lc3b_l1_line mem_wdata,
    output logic mem_resp,
    input logic mem_read,
    input logic mem_write,
    
    input lc3b_l2_line pmem_rdata,
    output lc3b_word pmem_address,
    output lc3b_l2_line pmem_wdata,
    input logic pmem_resp,
    output logic pmem_read,
    output logic pmem_write
);

logic [1:0] waymux_sel;
logic write_array_sel;
logic data0_load;
logic data1_load;
logic data2_load;
logic data3_load;
logic tag0_load;
logic tag1_load;
logic tag2_load;
logic tag3_load;
logic valid0_load;
logic valid1_load;
logic valid2_load;
logic valid3_load;
logic dirty0_load;
logic dirty1_load;
logic dirty2_load;
logic dirty3_load;
logic lru_load;
logic valid0_in;
logic valid1_in;
logic valid2_in;
logic valid3_in;
logic dirty0_in;
logic dirty1_in;
logic dirty2_in;
logic dirty3_in;
logic [1:0] lru_in;
logic valid0_out;
logic valid1_out;
logic valid2_out;
logic valid3_out;
logic dirty0_out;
logic dirty1_out;
logic dirty2_out;
logic dirty3_out;
logic [1:0] lru_out;
logic match0;
logic match1;
logic match2;
logic match3;
logic [2:0] pmem_address_sel;

l2_cache_datapath l2_cd
(
    .clk,
    .mem_rdata,
    .mem_address,
    .mem_wdata,

    .pmem_rdata,
    .pmem_address,
    .pmem_wdata,

    .waymux_sel,
    .write_array_sel,
    .data0_load,
    .data1_load,
    .data2_load,
    .data3_load,
    .tag0_load,
    .tag1_load,
    .tag2_load,
    .tag3_load,
    .valid0_load,
    .valid1_load,
    .valid2_load,
    .valid3_load,
    .dirty0_load,
    .dirty1_load,
    .dirty2_load,
    .dirty3_load,
    .lru_load,
    .valid0_in,
    .valid1_in,
    .valid2_in,
    .valid3_in,
    .dirty0_in,
    .dirty1_in,
    .dirty2_in,
    .dirty3_in,
    .lru_in,
    .pmem_address_sel,

    .valid0_out,
    .valid1_out,
    .valid2_out,
    .valid3_out,
    .dirty0_out,
    .dirty1_out,
    .dirty2_out,
    .dirty3_out,
    .lru_out,
    .match0,
    .match1,
    .match2,
    .match3
);

l2_cache_control l2_cc
(
    .clk,

    .mem_resp,
    .pmem_read,
    .pmem_write,
    .waymux_sel,
    .write_array_sel,
    .data0_load,
    .data1_load,
    .data2_load,
    .data3_load,
    .tag0_load,
    .tag1_load,
    .tag2_load,
    .tag3_load,
    .valid0_load,
    .valid1_load,
    .valid2_load,
    .valid3_load,
    .dirty0_load,
    .dirty1_load,
    .dirty2_load,
    .dirty3_load,
    .lru_load,
    .valid0_in,
    .valid1_in,
    .valid2_in,
    .valid3_in,
    .dirty0_in,
    .dirty1_in,
    .dirty2_in,
    .dirty3_in,
    .lru_in,
    .pmem_address_sel,
    
    .mem_read,
    .mem_write,  
    .pmem_resp,
    .valid0_out,
    .valid1_out,
    .valid2_out,
    .valid3_out,
    .dirty0_out,
    .dirty1_out,
    .dirty2_out,
    .dirty3_out,
    .lru_out,
    .match0,
    .match1,
    .match2,
    .match3
);

endmodule : l2_cache