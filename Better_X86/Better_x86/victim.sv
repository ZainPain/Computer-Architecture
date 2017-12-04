import lc3b_types::*;

//typedef logic [2:0] lc3b_l2_index;
//typedef logic [8:0] lc3b_l2_tag;
//typedef logic [2:0] lc3b_l2_offset;
//typedef logic [127:0] lc3b_l2_line;
//typedef logic [15:0] lc3b_word;

module victim(
    input clk,

    // inputs from L2 and pmem
    input lc3b_word mem_address,
    input lc3b_l2_line mem_wdata,
    input logic mem_write,
    input logic mem_read,
    input lc3b_l2_line pmem_rdata,
    input logic pmem_resp,

    // outputs to L2 and pmem
    output logic mem_resp,         // to L2
    output logic pmem_read,        // to pmem
    output logic pmem_write,       // to pmem
    output lc3b_word pmem_address, // to pmem
    output lc3b_l2_line pmem_wdata,   // to L2 or pmem
    output lc3b_l2_line mem_rdata     // to L2 or pmem
   );

    /*********VARIABLE DECLARATIONS*************/
    logic valid_from_datapath[15:0];
	 logic hit_from_datapath[15:0];
	 logic dirty_from_datapath[15:0];
    logic valid_from_control;
	 logic dirty_from_control;
	 logic write_from_control;
    logic [4:0] mem_rdata_mux_sel, pmem_wdata_mux_sel, pmem_address_mux_sel;
	 logic [11:0] tag_data_line [15:0];
	 logic [3:0] idx;


    /********INSTANTIATIONS**************/
    victim_control VICTIM_CACHE_CONTROL(
        .clk(clk),
        
        // memory control signals
        .pmem_write(pmem_write),
        .pmem_read(pmem_read),
        .pmem_resp(pmem_resp),

        .mem_write(mem_write),
        .mem_read(mem_read),
        .mem_resp(mem_resp),

        // control signals from victim datapath
        .valid(valid_from_datapath),
        //.hit(hit_from_datapath),
		  .tag_data_line(tag_data_line),
        .mem_address(mem_address),
        .dirty(dirty_from_datapath),

        // control signals to victim datapath
        .mem_rdata_mux_sel(mem_rdata_mux_sel),
        .pmem_wdata_mux_sel(pmem_wdata_mux_sel),
        .pmem_address_mux_sel(pmem_address_mux_sel),

        .out_dirty(dirty_from_control),
        .out_valid(valid_from_control),
        .write(write_from_control),
		  .idx(idx)
        );

    victim_datapath VICTIM_CACHE_DATAPATH(
        .clk(clk),
        .mem_wdata(mem_wdata),
        .mem_address(mem_address),
        .mem_rdata(mem_rdata),
        .pmem_rdata(pmem_rdata),
        .pmem_address(pmem_address),
        .pmem_wdata(pmem_wdata),
        .dirty_out(dirty_from_datapath),
        .valid_out(valid_from_datapath),
        //.hit_out(hit_from_datapath),
        //.pmem_wdata_mux_out(pmem_wdata),
        //.mem_rdata_mux_out(mem_rdata),
        //.pmem_address_mux_out(pmem_address),
		  .tag_data_line(tag_data_line),
        .mem_rdata_mux_sel(mem_rdata_mux_sel),
        .pmem_wdata_mux_sel(pmem_wdata_mux_sel),
        .pmem_address_mux_sel(pmem_address_mux_sel),
        .write(write_from_control),
        .mem_write(mem_write),
        .valid_in(valid_from_control),
        .dirty_in(dirty_from_control),
		  .idx(idx)
        );
endmodule:victim
