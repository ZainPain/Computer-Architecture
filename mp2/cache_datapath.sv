import lc3b_types::*;
module cache_datapath
(	
	input clk,
	
	/* LOAD SIGNALS */
	input logic load_tag1,
	input logic load_tag2,
	input logic load_valid1,
	input logic load_valid2,
	input logic load_data1,
	input logic load_data2,
	input logic load_lru,
	input logic load_dirty1,
	input logic load_dirty2,
	output logic hit,
	output logic hit2_out,
	/* LOAD SIGNALS END */

	/* DATA IN SIGNALS */

	input logic valid1_in,
	input logic valid2_in,
	output logic valid1_out,
	output logic valid2_out,
	input logic dirty1_in,
	input logic dirty2_in,
	input logic lru_in,
	output logic lru_out,
	output logic dirty1_out,
	output logic dirty2_out,
	/* DATA IN SIGNALS END */
	input logic writemux1_sel,
	input logic writemux2_sel,
	input logic pmem_write_sel,
	input logic pmem_sel,
	/** MEM SIGNALS **/
	input lc3b_word mem_address,
	input lc3b_data pmem_rdata,
	input lc3b_word mem_wdata,
	
	input logic [1:0] mem_byte_enable,
	
	output lc3b_word mem_rdata,
	output lc3b_data pmem_wdata,
	output lc3b_word pmem_address
	/** MEM SIGNALS END **/
	
);

lc3b_tag tag;
lc3b_index index;
lc3b_offset offset;

lc3b_data data1_out;
lc3b_data data2_out;

lc3b_tag tag1_out;
lc3b_tag tag2_out;

logic comp1_out;
logic comp2_out;
logic hit1_out;
lc3b_data write_data1_out;
lc3b_data write_data2_out;

lc3b_data write1_mux_out;
lc3b_data write2_mux_out;
lc3b_tag tagmux_out;
lc3b_word tagmux_out_extended;
/* SOME ASSIGNMENTS */
mux2 #(.width(9)) tagmux
(
	.sel(lru_out),
	.a(tag1_out),
	.b(tag2_out),
	.f(tagmux_out)
);

always_comb
begin
	tagmux_out_extended = {tagmux_out,index,4'b0000};
end

mux2 #(.width(16)) p_address
(
	.sel(pmem_sel),
	.a(mem_address),
	.b(tagmux_out_extended),
	.f(pmem_address)
);

components Extract
(
	.mem_address(mem_address),
	.tag(tag),
	.index(index),
	.offset(offset)
);
Array  data_array1
(

    .clk(clk),
    .write(load_data1),
    .index(index),
    .datain(write1_mux_out),
    .dataout(data1_out)

);
write_to_dataArray write_data_1
(
	.in(data1_out),
	.mem_wdata(mem_wdata),
	.mem_byte_enable(mem_byte_enable),
	.offset(offset),
	.out(write_data1_out)
	
);

mux2 #(.width(128)) write_data1_mux
(
	.sel(writemux1_sel),
	.a(pmem_rdata),
	.b(write_data1_out),
	.f(write1_mux_out)
);

Array  data_array2
(

    .clk(clk),
    .write(load_data2),
    .index(index),
    .datain(write2_mux_out),
    .dataout(data2_out)

);

write_to_dataArray write_data_2
(
	.in(data2_out),
	.mem_wdata(mem_wdata),
	.mem_byte_enable(mem_byte_enable),
	.offset(offset),
	.out(write_data2_out)
	
);

mux2 #(.width(128)) write_data2_mux
(
	.sel(writemux2_sel),
	.a(pmem_rdata),
	.b(write_data2_out),
	.f(write2_mux_out)
);

mux2 #(.width(128)) write_pmem_mux
(
	.sel(pmem_write_sel),
	.a(data1_out),
	.b(data2_out),
	.f(pmem_wdata)
);

/* tag is loaded into tag array when a miss occurs based on valid bit and lru decision */
Array #(.width(9)) tag_array1//#(.width(9))
(

    .clk(clk),
    .write(load_tag1),
    .index(index),
    .datain(tag),
    .dataout(tag1_out)

);

Array #(.width(9)) tag_array2//#(.width(9))
(

    .clk(clk),
    .write(load_tag2),
    .index(index),
    .datain(tag),
    .dataout(tag2_out)

);

Array #(.width(1)) valid1
(

    .clk(clk),
    .write(load_valid1),
    .index(index),
    .datain(valid1_in),
    .dataout(valid1_out)

);

Array #(.width(1)) valid2
(

    .clk(clk),
    .write(load_valid2),
    .index(index),
    .datain(valid2_in),
    .dataout(valid2_out)

);

mux16by2  datamux
(
	.in1(data1_out),
	.in2(data2_out),
	.way_select(hit2_out),
	.offset(offset),
	.out(mem_rdata)
	
);

Array #(.width(1)) LRU
(

    .clk(clk),
    .write(load_lru),
    .index(index),
    .datain(lru_in),
    .dataout(lru_out)

);

comparator tagcomp1
(
	.in1(tag),
	.in2(tag1_out),
	.out(comp1_out)
);

comparator tagcomp2
(
	.in1(tag),
	.in2(tag2_out),
	.out(comp2_out)
	
);

__AND__ #(.width(1)) hit1
(
	.in1(comp1_out),
	.in2(valid1_out),
	.out(hit1_out)
	
);

__AND__ #(.width(1)) hit2
(
	.in1(comp2_out),
	.in2(valid2_out),
	.out(hit2_out)
	
);

__OR__  _OR_hits
(
	.in1(hit1_out),
	.in2(hit2_out),
	.out(hit)
	
);

Array #(.width(1)) dirty1
(

    .clk(clk),
    .write(load_dirty1),
    .index(index),
    .datain(dirty1_in),
    .dataout(dirty1_out)

);

Array #(.width(1)) dirty2
(

    .clk(clk),
    .write(load_dirty2),
    .index(index),
    .datain(dirty2_in),
    .dataout(dirty2_out)

);

endmodule : cache_datapath
