import lc3b_types::*;

// TODO: IN_VALID IN_DIRTY logic

//typedef logic [2:0] lc3b_l2_index;
//typedef logic [8:0] lc3b_l2_tag;
//typedef logic [2:0] lc3b_l2_offset;
//typedef logic [127:0] lc3b_l2_line;
//typedef logic [15:0] lc3b_word;

module victim_datapath(
    input clk,

    // inputs from victim top level
    input lc3b_l2_line mem_wdata,
    input lc3b_word mem_address,

    // outputs to L2
    output lc3b_l2_line mem_rdata,
    
    // inputs from pmem
    input lc3b_l2_line pmem_rdata,

    // outputs to pmem
    output lc3b_word pmem_address,
    output lc3b_l2_line pmem_wdata,

    // outputs to toplevel, victim control
    output logic dirty_out [15:0],
    output logic valid_out [15:0],
    //output logic hit_out,

    //output lc3b_l2_line pmem_wdata_mux_out,
    //output lc3b_l2_line mem_rdata_mux_out,
    //output lc3b_word pmem_address_mux_out,
	 
	 output logic [11:0] tag_data_line [15:0],

    // control inputs from toplevel, victim control
    input logic [4:0] mem_rdata_mux_sel,
    input logic [4:0] pmem_wdata_mux_sel,
    input logic [4:0] pmem_address_mux_sel,
    
    input logic write, // determines whether we update the victim cache or now
    input logic mem_write,
    input logic valid_in,
    input logic dirty_in,
	 input logic [3:0] idx // this determines which array we write into
    );


    //********** VARIABLE DECLARATIONS *************/
    // this is the data_line tag that we send to pmem
    //logic [11:0] tag_data_line; 
	 lc3b_l2_index index_data_line;
    lc3b_l2_offset offset_data_line;
	 
    // this writeback addres comes from the tag portion of data line +0's
    lc3b_word wb_address0, wb_address1, wb_address2, wb_address3, wb_address4, wb_address5, wb_address6;
	 lc3b_word wb_address7, wb_address8, wb_address9, wb_address10, wb_address11, wb_address12;
	 lc3b_word wb_address13, wb_address14, wb_address15;

    // local register data line
    lc3b_l2_line data_line[15:0];

    // NOTE: Currently do not need LRU as this is one line
    
    lc3b_l2_line mem_rdata_mux_out;
    lc3b_word pmem_address_mux_out;
    lc3b_l2_line pmem_wdata_mux_out; 

    /***************ASSSIGNS**************/
    assign mem_rdata=mem_rdata_mux_out;
    assign pmem_wdata=pmem_wdata_mux_out;
    assign pmem_address=pmem_address_mux_out;

    assign index_data_line=mem_address[6:4];
    assign offset_data_line=mem_address[3:1];

    assign wb_address0={tag_data_line[0], 4'b0};
	 assign wb_address1={tag_data_line[1], 4'b0};
	 assign wb_address2={tag_data_line[2], 4'b0};
	 assign wb_address3={tag_data_line[3], 4'b0};
	 assign wb_address4={tag_data_line[4], 4'b0};
	 assign wb_address5={tag_data_line[5], 4'b0};
	 assign wb_address6={tag_data_line[6], 4'b0};
	 assign wb_address7={tag_data_line[7], 4'b0};
	 assign wb_address8={tag_data_line[8], 4'b0};
	 assign wb_address9={tag_data_line[9], 4'b0};
	 assign wb_address10={tag_data_line[10], 4'b0};
	 assign wb_address11={tag_data_line[11], 4'b0};
	 assign wb_address12={tag_data_line[12], 4'b0};
	 assign wb_address13={tag_data_line[13], 4'b0};
	 assign wb_address14={tag_data_line[14], 4'b0};
	 assign wb_address15={tag_data_line[15], 4'b0};


    // victim control will then choose the mem_rdata_mux_sel
    //assign hit_out=(tag_data_line==mem_address[15:4]) && valid_in; // check if we have a hit or not

    /**********INSTANTIATIONS***********/
    
    /*************ARRAYS****************/
    victim_array #(.width(12)) TAG_VICTIM(
        .clk(clk),
        .write(write), // load tag only if its a write
		  .index(idx),
        .datain(mem_address[15:4]),
        .dataout(tag_data_line)
        );

    victim_array #(.width(1)) VALID_VICTIM(
        .clk(clk),
        .write(|write),
		  .index(idx),
        .datain(valid_in),
        .dataout(valid_out)
        );

    victim_array #(.width(1)) DIRTY_VICTIM(
        .clk(clk),
        .write(write),
		  .index(idx),
        .datain(dirty_in),
        .dataout(dirty_out)
        );

    victim_array #(.width(128)) DATA_VICTIM(
        .clk(clk),
        .write(write),
		  .index(idx),
        .datain(mem_wdata),
        .dataout(data_line)
        );


    /*****************MUXES******************/
    // Select which data we want out from pmem or the victim
    mux17 #(.width(128)) mem_rdata_mux(
        .sel(mem_rdata_mux_sel),
        ._0(pmem_rdata),
        ._1(data_line[0]),
		  ._2(data_line[1]),
		  ._3(data_line[2]),
		  ._4(data_line[3]),
		  ._5(data_line[4]),
		  ._6(data_line[5]),
		  ._7(data_line[6]),
		  ._8(data_line[7]),
		  ._9(data_line[8]),
		  ._10(data_line[9]),
		  ._11(data_line[10]),
		  ._12(data_line[11]),
		  ._13(data_line[12]),
		  ._14(data_line[13]),
		  ._15(data_line[14]),
		  ._16(data_line[15]),
        .out(mem_rdata_mux_out)
        );

   // Select which address we want to write to in pmem 
    mux17 #(.width(16)) pmem_address_mux(
        .sel(pmem_address_mux_sel),
        ._0(mem_address),
        ._1(wb_address0),
		  ._2(wb_address1),
		  ._3(wb_address2),
		  ._4(wb_address3),
		  ._5(wb_address4),
		  ._6(wb_address5),
		  ._7(wb_address6),
		  ._8(wb_address7),
		  ._9(wb_address8),
		  ._10(wb_address9),
		  ._11(wb_address10),
		  ._12(wb_address11),
		  ._13(wb_address12),
		  ._14(wb_address13),
		  ._15(wb_address14),
		  ._16(wb_address15),
        .out(pmem_address_mux_out)
        );

    // Select which data we want to send to physical memory
    mux17 #(.width(128)) pmem_wdata_mux(
        .sel(pmem_wdata_mux_sel),
        ._0(mem_wdata),
		  ._1(data_line[0]),
		  ._2(data_line[1]),
		  ._3(data_line[2]),
		  ._4(data_line[3]),
		  ._5(data_line[4]),
		  ._6(data_line[5]),
		  ._7(data_line[6]),
		  ._8(data_line[7]),
		  ._9(data_line[8]),
		  ._10(data_line[9]),
		  ._11(data_line[10]),
		  ._12(data_line[11]),
		  ._13(data_line[12]),
		  ._14(data_line[13]),
		  ._15(data_line[14]),
		  ._16(data_line[15]),
        .out(pmem_wdata_mux_out)
        );

endmodule: victim_datapath
