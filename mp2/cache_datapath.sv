import lc3b_types::*;
module cache_datapath
(	
	input clk,
	
	/* LOAD SIGNALS */
	input load_tag1,
	input load_tag2,
	input load_valid1,
	input load_valid2,
	input load_data1,
	input load_data2,
	input load_lru,
	input load_dirty1,
	input load_dirty2,
	output hit,
	/* LOAD SIGNALS END */
	
	/* SELECT SIGNALS  */
	input eviction,
	/* SELECT SIGNALS END */
	
	/* DATA IN SIGNALS */
	input lc3b_data data1_in,
	input lc3b_data data2_in,
	input lc3b_tag tag1_in,
	input lc3b_tag tag2_in,
	input valid1_in,
	input valid2_in,
	input dirty1_in,
	input dirty2_in,
	input lru_in,
	output dirty1_out,
	output dirty2_out,
	/* DATA IN SIGNALS END */
	
	/** MEM SIGNALS **/
	input lc3b_word mem_address,
	output lc3b_word mem_rdata
	/** MEM SIGNALS END **/
	
);

lc3b_tag tag = mem_address[15:7];
lc3b_index index = mem_address[6:4];
lc3b_offset offset = mem_address[3:0];

lc3b_data data1_out;
lc3b_data data2_out;

lc3b_tag tag1_out;
lc3b_tag tag2_out;

logic valid1_out;
logic valid2_out;

logic lru_out;

logic comp1_out;
logic comp2_out;
logic hit1_out;
logic hit2_out;
logic way_select;


array #(.width(128)) data_array1
(

    .clk(clk),
    .write(load_data1),
    .index(index),
    .datain(data1_in),
    .dataout(data1_out)

);

array #(.width(128)) data_array2
(

    .clk(clk),
    .write(load_data2),
    .index(index),
    .datain(data2_in),
    .dataout(data2_out)

);

array #(.width(9)) tag_array1
(

    .clk(clk),
    .write(load_tag1),
    .index(index),
    .datain(tag1_in),
    .dataout(tag1_out)

);

array #(.width(9)) tag_array2
(

    .clk(clk),
    .write(load_tag2),
    .index(index),
    .datain(tag2_in),
    .dataout(tag2_out)

);

array #(.width(1)) valid1
(

    .clk(clk),
    .write(load_valid1),
    .index(index),
    .datain(valid1_in),
    .dataout(valid1_out)

);

array #(.width(1)) valid2
(

    .clk(clk),
    .write(load_valid2),
    .index(index),
    .datain(valid2_in),
    .dataout(valid2_out)

);

mux16by2 #(.width(28)) datamux
(
	.in1(data1_out),
	.in2(data2_out),
	.way_select(way_select),
	.offset(offset),
	.out(address_content)
	
);

array #(.width(1)) LRU
(

    .clk(clk),
    .write(load_lru),
    .index(index),
    .datain(lru_in),
    .dataout(lru_out)

);

comparator #(.width(9)) tagcomp1
(
	.in1(tag),
	.in2(tag1_out),
	.out(comp1_out)
);

comparator #(.width(9)) tagcomp2
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

__OR__ #(.width(1)) _OR
(
	.in1(hit1_out),
	.in2(hit2_out),
	.out(hit)
	
);

mux2 #(.width(1)) way_selector
(
	.sel(eviction),
	.a(hit2),
	.b(lru_out),
	.f(way_select)
);

array #(.width(1)) dirty1
(

    .clk(clk),
    .write(load_dirty1),
    .index(index),
    .datain(dirty1_in),
    .dataout(dirty1_out)

);

array #(.width(1)) dirty2
(

    .clk(clk),
    .write(load_dirty2),
    .index(index),
    .datain(dirty2_in),
    .dataout(dirty2_out)

);

endmodule : cache_datapath
