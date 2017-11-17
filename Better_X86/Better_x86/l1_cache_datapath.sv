import lc3b_types::*;

module l1_cache_datapath
(
    input clk,
    output lc3b_word mem_rdata,
    input lc3b_word mem_address,
    input lc3b_word mem_wdata,
    input lc3b_mem_wmask mem_byte_enable,
    
    input lc3b_l1_line pmem_rdata,
    output lc3b_word pmem_address,
    output lc3b_l1_line pmem_wdata,

    input logic waymux_sel,
    input logic write_array_sel,
    input logic data0_load,
    input logic data1_load,
    input logic tag0_load,
    input logic tag1_load,
    input logic valid0_load,
    input logic valid1_load,
    input logic dirty0_load,
    input logic dirty1_load,
    input logic lru_load,
    input logic valid0_in,
    input logic valid1_in,
    input logic dirty0_in,
    input logic dirty1_in,
    input logic lru_in,
    input logic [1:0] pmem_address_sel,
    
    output logic valid0_out,
    output logic valid1_out,
    output logic dirty0_out,
    output logic dirty1_out,
    output logic lru_out,
    output logic match0,
    output logic match1    
);

lc3b_l1_line write_data;
lc3b_l1_line data0_out;
lc3b_l1_line data1_out;
lc3b_l1_line waymux_out;
lc3b_l1_line write_mux_out;
lc3b_l1_offset offset;
lc3b_l1_index index;
lc3b_l1_tag tag;
lc3b_l1_tag tag0_out;
lc3b_l1_tag tag1_out;

logic [7:0] dec_out;

logic mux7_msb_sel;
logic mux7_lsb_sel;
logic mux6_msb_sel;
logic mux6_lsb_sel;
logic mux5_msb_sel;
logic mux5_lsb_sel;
logic mux4_msb_sel;
logic mux4_lsb_sel;
logic mux3_msb_sel;
logic mux3_lsb_sel;
logic mux2_msb_sel;
logic mux2_lsb_sel;
logic mux1_msb_sel;
logic mux1_lsb_sel;
logic mux0_msb_sel;
logic mux0_lsb_sel;

assign offset = mem_address[3:1];
assign index = mem_address[6:4];
assign tag = mem_address[15:7];
assign pmem_wdata = waymux_out;
assign match0 = tag0_out == mem_address[15:7];
assign match1 = tag1_out == mem_address[15:7];

assign mux7_msb_sel = mem_byte_enable[1] & dec_out[7];
assign mux7_lsb_sel = mem_byte_enable[0] & dec_out[7];
assign mux6_msb_sel = mem_byte_enable[1] & dec_out[6];
assign mux6_lsb_sel = mem_byte_enable[0] & dec_out[6];
assign mux5_msb_sel = mem_byte_enable[1] & dec_out[5];
assign mux5_lsb_sel = mem_byte_enable[0] & dec_out[5];
assign mux4_msb_sel = mem_byte_enable[1] & dec_out[4];
assign mux4_lsb_sel = mem_byte_enable[0] & dec_out[4];
assign mux3_msb_sel = mem_byte_enable[1] & dec_out[3];
assign mux3_lsb_sel = mem_byte_enable[0] & dec_out[3];
assign mux2_msb_sel = mem_byte_enable[1] & dec_out[2];
assign mux2_lsb_sel = mem_byte_enable[0] & dec_out[2];
assign mux1_msb_sel = mem_byte_enable[1] & dec_out[1];
assign mux1_lsb_sel = mem_byte_enable[0] & dec_out[1];
assign mux0_msb_sel = mem_byte_enable[1] & dec_out[0];
assign mux0_lsb_sel = mem_byte_enable[0] & dec_out[0];

decoder dec_3_8
(
    .in(offset),
    .out(dec_out)
);

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

array #(.width(1)) LRU
(
    .clk(clk),
    .write(lru_load),
    .index(index),
    .datain(lru_in),
    .dataout(lru_out)
);

mux4 pmem_address_mux
(
    .sel(pmem_address_sel),
    .a({mem_address[15:4], 4'b0000}),
    .b({tag0_out,index,4'b0000}),
    .c({tag1_out,index,4'b0000}),
    .d(16'hXXXX),
    .f(pmem_address)
);

mux2 #(.width(128)) waymux
(
    .sel(waymux_sel),
    .a(data0_out),
    .b(data1_out),
    .f(waymux_out)
);

mux8 readmux
(
    .sel(offset),
    .a(waymux_out[15:0]),
    .b(waymux_out[31:16]),
    .c(waymux_out[47:32]),
    .d(waymux_out[63:48]),
    .e(waymux_out[79:64]),
    .f(waymux_out[95:80]),
    .g(waymux_out[111:96]),
    .h(waymux_out[127:112]),
    .out(mem_rdata)
);

mux2 #(.width(128)) writemux
(
    .sel(write_array_sel),
    .a(write_mux_out),
    .b(pmem_rdata),
    .f(write_data)
);

mux2 #(.width(8)) mux7_msb
(
    .sel(mux7_msb_sel),
    .a(waymux_out[127:120]),
    .b(mem_wdata[15:8]),
    .f(write_mux_out[127:120])
);

mux2 #(.width(8)) mux7_lsb
(
    .sel(mux7_lsb_sel),
    .a(waymux_out[119:112]),
    .b(mem_wdata[7:0]),
    .f(write_mux_out[119:112])
);

mux2 #(.width(8)) mux6_msb
(
    .sel(mux6_msb_sel),
    .a(waymux_out[111:104]),
    .b(mem_wdata[15:8]),
    .f(write_mux_out[111:104])
);

mux2 #(.width(8)) mux6_lsb
(
    .sel(mux6_lsb_sel),
    .a(waymux_out[103:96]),
    .b(mem_wdata[7:0]),
    .f(write_mux_out[103:96])
);

mux2 #(.width(8)) mux5_msb
(
    .sel(mux5_msb_sel),
    .a(waymux_out[95:88]),
    .b(mem_wdata[15:8]),
    .f(write_mux_out[95:88])
);

mux2 #(.width(8)) mux5_lsb
(
    .sel(mux5_lsb_sel),
    .a(waymux_out[87:80]),
    .b(mem_wdata[7:0]),
    .f(write_mux_out[87:80])
);

mux2 #(.width(8)) mux4_msb
(
    .sel(mux4_msb_sel),
    .a(waymux_out[79:72]),
    .b(mem_wdata[15:8]),
    .f(write_mux_out[79:72])
);

mux2 #(.width(8)) mux4_lsb
(
    .sel(mux4_lsb_sel),
    .a(waymux_out[71:64]),
    .b(mem_wdata[7:0]),
    .f(write_mux_out[71:64])
);

mux2 #(.width(8)) mux3_msb
(
    .sel(mux3_msb_sel),
    .a(waymux_out[63:56]),
    .b(mem_wdata[15:8]),
    .f(write_mux_out[63:56])
);

mux2 #(.width(8)) mux3_lsb
(
    .sel(mux3_lsb_sel),
    .a(waymux_out[55:48]),
    .b(mem_wdata[7:0]),
    .f(write_mux_out[55:48])
);

mux2 #(.width(8)) mux2_msb
(
    .sel(mux2_msb_sel),
    .a(waymux_out[47:40]),
    .b(mem_wdata[15:8]),
    .f(write_mux_out[47:40])
);

mux2 #(.width(8)) mux2_lsb
(
    .sel(mux2_lsb_sel),
    .a(waymux_out[39:32]),
    .b(mem_wdata[7:0]),
    .f(write_mux_out[39:32])
);

mux2 #(.width(8)) mux1_msb
(
    .sel(mux1_msb_sel),
    .a(waymux_out[31:24]),
    .b(mem_wdata[15:8]),
    .f(write_mux_out[31:24])
);

mux2 #(.width(8)) mux1_lsb
(
    .sel(mux1_lsb_sel),
    .a(waymux_out[23:16]),
    .b(mem_wdata[7:0]),
    .f(write_mux_out[23:16])
);

mux2 #(.width(8)) mux0_msb
(
    .sel(mux0_msb_sel),
    .a(waymux_out[15:8]),
    .b(mem_wdata[15:8]),
    .f(write_mux_out[15:8])
);

mux2 #(.width(8)) mux0_lsb
(
    .sel(mux0_lsb_sel),
    .a(waymux_out[7:0]),
    .b(mem_wdata[7:0]),
    .f(write_mux_out[7:0])
);

endmodule : l1_cache_datapath