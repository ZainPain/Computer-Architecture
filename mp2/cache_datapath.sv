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
	output logic way_select,
	/* LOAD SIGNALS END */
	
	/* SELECT SIGNALS  */
	input logic eviction,
	/* SELECT SIGNALS END */
	
	/* DATA IN SIGNALS */

	input logic valid1_in,
	input logic valid2_in,
	input logic dirty1_in,
	input logic dirty2_in,
	input logic lru_in,
	output logic lru_out,
	output logic dirty1_out,
	output logic dirty2_out,
	/* DATA IN SIGNALS END */
	
	/** MEM SIGNALS **/
	input lc3b_word mem_address,
	input lc3b_data pmem_rdata,
	input lc3b_word mem_wdata,
	
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

logic valid1_out;
logic valid2_out;


logic comp1_out;
logic comp2_out;
logic hit1_out;
logic hit2_out;
/* SOME ASSIGNMENTS */
always_comb
begin
	pmem_address = mem_address;
end
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
    .datain(pmem_rdata),
    .dataout(data1_out)

);

Array  data_array2
(

    .clk(clk),
    .write(load_data2),
    .index(index),
    .datain(pmem_rdata),
    .dataout(data2_out)

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
	.way_select(way_select),
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

comparator #(.width(1)) hit1
(
	.in1(comp1_out),
	.in2(valid1_out),
	.out(hit1_out)
	
);

comparator #(.width(1)) hit2
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

mux2 #(.width(1)) way_selector
(
	.sel(eviction),
	.a(hit2_out),
	.b(lru_out),
	.f(way_select)
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
