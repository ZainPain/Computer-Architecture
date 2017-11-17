import lc3b_types::*;

module l1_cache
(
    input clk,
    output lc3b_word mem_rdata,
    input lc3b_word mem_address,
    input lc3b_word mem_wdata,
    output logic mem_resp,
    input logic mem_read,
    input logic mem_write,
    input lc3b_mem_wmask mem_byte_enable,
    
    input lc3b_l1_line pmem_rdata,
    output lc3b_word pmem_address,
    output lc3b_l1_line pmem_wdata,
    input logic pmem_resp,
    output logic pmem_read,
    output logic pmem_write
);

logic waymux_sel;
logic write_array_sel;
logic data0_load;
logic data1_load;
logic tag0_load;
logic tag1_load;
logic valid0_load;
logic valid1_load;
logic dirty0_load;
logic dirty1_load;
logic lru_load;
logic valid0_in;
logic valid1_in;
logic dirty0_in;
logic dirty1_in;
logic lru_in;
logic valid0_out;
logic valid1_out;
logic dirty0_out;
logic dirty1_out;
logic lru_out;
logic match0;
logic match1;
logic [1:0] pmem_address_sel;

l1_cache_datapath l1_cd
(
    .clk,
    .mem_rdata,
    .mem_address,
    .mem_wdata,
    .mem_byte_enable,
    
    .pmem_rdata,
    .pmem_address,
    .pmem_wdata,

    .waymux_sel,
    .write_array_sel,
    .data0_load,
    .data1_load,
    .tag0_load,
    .tag1_load,
    .valid0_load,
    .valid1_load,
    .dirty0_load,
    .dirty1_load,
    .lru_load,
    .valid0_in,
    .valid1_in,
    .dirty0_in,
    .dirty1_in,
    .lru_in,
    .pmem_address_sel,
    
    .valid0_out,
    .valid1_out,
    .dirty0_out,
    .dirty1_out,
    .lru_out,
    .match0,
    .match1
);

l1_cache_control l1_cc
(
    .clk,

    .mem_resp,
    .pmem_read,
    .pmem_write,
    
    .waymux_sel,
    .write_array_sel,
    .data0_load,
    .data1_load,
    .tag0_load,
    .tag1_load,
    .valid0_load,
    .valid1_load,
    .dirty0_load,
    .dirty1_load,
    .lru_load,
    .valid0_in,
    .valid1_in,
    .dirty0_in,
    .dirty1_in,
    .lru_in,
    .pmem_address_sel,
    
    .mem_read,
    .mem_write,  
    .pmem_resp,
    
    .valid0_out,
    .valid1_out,
    .dirty0_out,
    .dirty1_out,
    .lru_out,
    .match0,
    .match1
);

endmodule : l1_cache