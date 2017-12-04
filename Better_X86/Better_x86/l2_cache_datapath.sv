import lc3b_types::*;

module l2_cache_datapath
(
    input clk,
    output lc3b_l1_line mem_rdata,
    input lc3b_word mem_address,
    input lc3b_l1_line mem_wdata,
    //input lc3b_mem_wmask mem_byte_enable,

    input lc3b_l2_line pmem_rdata,
    output lc3b_word pmem_address,
    output lc3b_l2_line pmem_wdata,

    input logic [1:0] waymux_sel,
    input logic write_array_sel,
    input logic data0_load,
    input logic data1_load,
    input logic data2_load,
    input logic data3_load,
    input logic tag0_load,
    input logic tag1_load,
    input logic tag2_load,
    input logic tag3_load,
    input logic valid0_load,
    input logic valid1_load,
    input logic valid2_load,
    input logic valid3_load,
    input logic dirty0_load,
    input logic dirty1_load,
    input logic dirty2_load,
    input logic dirty3_load,
    input logic lru_load,
    input logic valid0_in,
    input logic valid1_in,
    input logic valid2_in,
    input logic valid3_in,
    input logic dirty0_in,
    input logic dirty1_in,
    input logic dirty2_in,
    input logic dirty3_in,
    input logic [1:0] lru_in,
    input logic [2:0] pmem_address_sel,

    output logic valid0_out,
    output logic valid1_out,
    output logic valid2_out,
    output logic valid3_out,
    output logic dirty0_out,
    output logic dirty1_out,
    output logic dirty2_out,
    output logic dirty3_out,
    output logic [1:0] lru_out,
    output logic match0,
    output logic match1,
    output logic match2,
    output logic match3
);

lc3b_l2_line write_data;
lc3b_l2_line data0_out;
lc3b_l2_line data1_out;
lc3b_l2_line data2_out;
lc3b_l2_line data3_out;
lc3b_l2_line waymux_out;
lc3b_l2_line write_mux_out;
//lc3b_l2_offset offset;
lc3b_l2_index index;
lc3b_l2_tag tag;
lc3b_l2_tag tag0_out;
lc3b_l2_tag tag1_out;
lc3b_l2_tag tag2_out;
lc3b_l2_tag tag3_out;

assign offset = mem_address[3:1];
assign index = mem_address[6:4];
assign tag = mem_address[15:7];
assign pmem_wdata = waymux_out;
assign match0 = tag0_out == mem_address[15:7];
assign match1 = tag1_out == mem_address[15:7];
assign match2 = tag2_out == mem_address[15:7];
assign match3 = tag3_out == mem_address[15:7];

assign mem_rdata = waymux_out;

array data0
(
    .clk(clk),
    .write(data0_load),
    .index(index),
    .datain(write_data),
    .dataout(data0_out)
);

array data1
(
    .clk(clk),
    .write(data1_load),
    .index(index),
    .datain(write_data),
    .dataout(data1_out)
);

array data2
(
    .clk(clk),
    .write(data2_load),
    .index(index),
    .datain(write_data),
    .dataout(data2_out)
);

array data3
(
    .clk(clk),
    .write(data3_load),
    .index(index),
    .datain(write_data),
    .dataout(data3_out)
);

array #(.width(9)) tag0
(
    .clk(clk),
    .write(tag0_load),
    .index(index),
    .datain(tag),
    .dataout(tag0_out)
);

array #(.width(9)) tag1
(
    .clk(clk),
    .write(tag1_load),
    .index(index),
    .datain(tag),
    .dataout(tag1_out)
);

array #(.width(9)) tag2
(
    .clk(clk),
    .write(tag2_load),
    .index(index),
    .datain(tag),
    .dataout(tag2_out)
);

array #(.width(9)) tag3
(
    .clk(clk),
    .write(tag3_load),
    .index(index),
    .datain(tag),
    .dataout(tag3_out)
);

array #(.width(1)) valid0
(
    .clk(clk),
    .write(valid0_load),
    .index(index),
    .datain(valid0_in),
    .dataout(valid0_out)
);


array #(.width(1)) valid1
(
    .clk(clk),
    .write(valid1_load),
    .index(index),
    .datain(valid1_in),
    .dataout(valid1_out)
);

array #(.width(1)) valid2
(
    .clk(clk),
    .write(valid2_load),
    .index(index),
    .datain(valid2_in),
    .dataout(valid2_out)
);


array #(.width(1)) valid3
(
    .clk(clk),
    .write(valid3_load),
    .index(index),
    .datain(valid3_in),
    .dataout(valid3_out)
);

array #(.width(1)) dirty0
(
    .clk(clk),
    .write(dirty0_load),
    .index(index),
    .datain(dirty0_in),
    .dataout(dirty0_out)
);


array #(.width(1)) dirty1
(
    .clk(clk),
    .write(dirty1_load),
    .index(index),
    .datain(dirty1_in),
    .dataout(dirty1_out)
);

array #(.width(1)) dirty2
(
    .clk(clk),
    .write(dirty2_load),
    .index(index),
    .datain(dirty2_in),
    .dataout(dirty2_out)
);


array #(.width(1)) dirty3
(
    .clk(clk),
    .write(dirty3_load),
    .index(index),
    .datain(dirty3_in),
    .dataout(dirty3_out)
);

LRU_register LRU
(
    .clk(clk),
    .load(lru_load),
    .index(index),
    .hit(lru_in),
    .dataout(lru_out)
);

mux5 #(.width(16)) pmem_address_mux
(
    .sel(pmem_address_sel),
    .a({mem_address[15:4], 4'b0000}),
    .b({tag0_out,index,4'b0000}),
    .c({tag1_out,index,4'b0000}),
    .d({tag2_out,index,4'b0000}),
    .e({tag3_out,index,4'b0000}),
    .f(pmem_address)
);

mux4 #(.width(128)) waymux
(
    .sel(waymux_sel),
    .a(data0_out),
    .b(data1_out),
    .c(data2_out),
    .d(data3_out),
    .f(waymux_out)
);

mux2 #(.width(128)) writemux
(
    .sel(write_array_sel),
    .a(mem_wdata),
    .b(pmem_rdata),
    .f(write_data)
);

endmodule : l2_cache_datapath
