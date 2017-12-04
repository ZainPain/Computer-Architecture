import lc3b_types::*;

//typedef logic [2:0] lc3b_l2_index;
//typedef logic [8:0] lc3b_l2_tag;
//typedef logic [2:0] lc3b_l2_offset;
//typedef logic [127:0] lc3b_l2_line;
//typedef logic [15:0] lc3b_word;

// TODO: Update valid, dirty, write , tag to 16
// TODO: Update muxes to take 16 things
// TODO: Use LRU
// TODO: EVERYTHING TO 16!

module victim_control(
    input clk,
    
    // memory control signals
    output logic pmem_write,
    output logic pmem_read,
    input logic pmem_resp,

    input logic mem_write,
    input logic mem_read,
    output logic mem_resp,

    // control signals from victim datapath
    input logic valid[15:0],
	 input logic [11:0] tag_data_line [15:0],
    input lc3b_word mem_address,
    input logic dirty[15:0],

    // control signals to victim datapath
    output logic [4:0] mem_rdata_mux_sel,
    output logic [4:0] pmem_wdata_mux_sel,
    output logic [4:0] pmem_address_mux_sel,

    output logic out_dirty,
    output logic out_valid,
    output logic write,
	 output logic [3:0] idx
    );

    enum{
        IDLE,       // IDLE state where we can service any request
        WB,         // WB where we are writing back to physical memory
        NO_REQ,     // NO_REQ state where we have no L2 request and writing data back to pmem
        DONE_WB,
        DONE_NO_REQ,
        READ_PMEM,   // L2 requested data and we are servicing this request
        DONE_READ_PMEM
    } state, next_state;

    /*********HIT LOGIC****************/
	 logic hit0, hit1, hit2, hit3, hit4, hit5, hit6 , hit7, hit8, hit9, hit10, hit11, hit12, hit13, hit14, hit15;
	 logic [3:0] hit_decimal; // used as an input to the LRU
	 logic [15:0] hit_complete;
	 assign hit0=(tag_data_line[0]==mem_address[15:4]) && valid[0]; // check if we have a hit or not
	 assign hit1=(tag_data_line[1]==mem_address[15:4]) && valid[1]; // check if we have a hit or not
	 assign hit2=(tag_data_line[2]==mem_address[15:4]) && valid[2]; // check if we have a hit or not
	 assign hit3=(tag_data_line[3]==mem_address[15:4]) && valid[3]; // check if we have a hit or not
	 assign hit4=(tag_data_line[4]==mem_address[15:4]) && valid[4]; // check if we have a hit or not
	 assign hit5=(tag_data_line[5]==mem_address[15:4]) && valid[5]; // check if we have a hit or not
	 assign hit6=(tag_data_line[6]==mem_address[15:4]) && valid[6]; // check if we have a hit or not
	 assign hit7=(tag_data_line[7]==mem_address[15:4]) && valid[7]; // check if we have a hit or not
	 assign hit8=(tag_data_line[8]==mem_address[15:4]) && valid[8]; // check if we have a hit or not
	 assign hit9=(tag_data_line[9]==mem_address[15:4]) && valid[9]; // check if we have a hit or not
	 assign hit10=(tag_data_line[10]==mem_address[15:4]) && valid[10]; // check if we have a hit or not
	 assign hit11=(tag_data_line[11]==mem_address[15:4]) && valid[11]; // check if we have a hit or not
	 assign hit12=(tag_data_line[12]==mem_address[15:4]) && valid[12]; // check if we have a hit or not
	 assign hit13=(tag_data_line[13]==mem_address[15:4]) && valid[13]; // check if we have a hit or not
	 assign hit14=(tag_data_line[14]==mem_address[15:4]) && valid[14]; // check if we have a hit or not
	 assign hit15=(tag_data_line[15]==mem_address[15:4]) && valid[15]; // check if we have a hit or not
	 
	 assign hit_complete={hit0, hit1, hit2, hit3, hit4, hit5, hit6, hit7, hit8, hit9, hit10, hit11, hit12, hit13, hit14, hit15};
	 
	 
	 always_comb
	 begin: determine_hit_dec
		hit_decimal=4'b0000;
		
		if(hit0)
			hit_decimal=4'b0000;
		else if(hit1)
			hit_decimal=4'b0001;
		else if(hit2)
			hit_decimal=4'b0010;
		else if(hit3)
			hit_decimal=4'b0011;
		else if(hit4)
			hit_decimal=4'b0100;
		else if(hit5)
			hit_decimal=4'b0101;
		else if(hit6)
			hit_decimal=4'b0110;
		else if(hit7)
			hit_decimal=4'b0111;
		else if(hit8)
			hit_decimal=4'b1000;
		else if(hit9)
			hit_decimal=4'b1001;
		else if(hit10)
			hit_decimal=4'b1010;
		else if(hit11)
			hit_decimal=4'b1011;
		else if(hit12)
			hit_decimal=4'b1100;
		else if(hit13)
			hit_decimal=4'b1101;
		else if(hit14)
			hit_decimal=4'b1110;
		else
			hit_decimal=4'b1111;
	 end
	 
	 
 
	 /**********LRU LOGIC************/
	 logic [3:0] LRU_out;
	 logic [3:0] prev_LRU_out;
	 pseudo_lru_16_way_pos LRU_VICTIM(
		.clk(clk),
		.load(write),
		.hit(prev_LRU_out),
		.dataout(LRU_out)
	 );

    /***********MORE VARIABLE DECLARATIONS**************/
    logic just_finished_no_req_write;
    logic just_finished_wb_write;
    logic no_req_writing;


    /****************STATE_LOGIC***********************/
    always_comb
    begin: state_actions
        // init values
        mem_resp=1'b0; pmem_write=1'b0; pmem_read=1'b0;
        out_dirty=1'b0; out_valid=1'b0; write=1'b0;
        mem_rdata_mux_sel=5'b00000;
        pmem_wdata_mux_sel=5'b00000;
        pmem_address_mux_sel=5'b00000;
        no_req_writing = 1'b0;
		  idx=4'b0000;
		  prev_LRU_out=4'b0000;
	 
        case(state)
            IDLE: begin
                // if hit and mem_read send to CPU
                if((|hit_complete) && mem_read==1'b1) begin
                    mem_resp=1'b1;
                    mem_rdata_mux_sel=hit_decimal+1'b1;//1'b1; // read from victim cache
                    out_valid=1'b1;
                    //out_dirty=1'b1; // mark as dirty so we can write NO_REQ
                end

                // hit and mem_write
                else if((|hit_complete) && mem_write==1'b1) begin
                    out_dirty=1'b1;
                    out_valid=1'b1;
                    write=1'b1;
                    mem_resp=1'b1;
						  idx=hit_decimal; // assign idx as the index that we want to write to
						  
						  prev_LRU_out=LRU_out;
                end

                //// if write and room in victim cache update victim cache
                //else if(valid==1'b1 && dirty==1'b0 && mem_write==1'b1) begin
                    //mem_resp=1'b1;
                    //write=1'b1; // we can write to the data line in datapath

                    //// data is now dirty and valid
                    //out_dirty=1'b1; out_valid=1'b1;
                //end

                else if(mem_write==1'b1 && valid[LRU_out]==1'b0 && dirty[LRU_out]==1'b0) begin
                    mem_resp=1'b1;
                    write=1'b1;
                    out_dirty=1'b1;
                    out_valid=1'b1;
						  idx=LRU_out;
						  
						  prev_LRU_out=LRU_out;
                end

            end

            WB: begin
                pmem_wdata_mux_sel=LRU_out+1; //1'b1; // choose to write the victim to pmem
                pmem_address_mux_sel=LRU_out+1; //1'b1;
                pmem_write=1'b1;
                // after writing back we need to invalidate the victim cache

            end

            DONE_WB: begin
                if(mem_write==1'b0) begin
                    mem_resp=1'b1;
                    out_valid=1'b0; out_dirty=1'b0; // out_dirty=1'b1; out_valid=1'b1;
                    write=1'b1;
						  idx=LRU_out;
						  
                    // out_valid=1'b1; // THIS NEEDS TO BE HIGH IF IT COMES FROM 
                    //no_req_writing=1'b0;
                end
                // finished write back now return to idle which will handle the new write
                else if(mem_write==1'b1) begin
                    mem_resp=1'b1;
                    out_valid=1'b1; out_dirty=1'b0;
                    write=1'b1;
						  idx=LRU_out;
						  
						  prev_LRU_out=LRU_out;
                end
            end

            DONE_NO_REQ: begin
                if(mem_write==1'b1) begin
                    mem_resp=1'b1;
                    write=1'b1;
                     out_valid=1'b1; // THIS NEEDS TO BE HIGH IF IT COMES FROM NO_REQ
                    out_dirty=1'b1;
                    no_req_writing=1'b0;
						  idx=LRU_out;
						  
						  prev_LRU_out=LRU_out;
                end

                else begin
                    write=1'b1;
                    out_valid=1'b0;
                    out_dirty=1'b0;
                    no_req_writing=1'b0;
						  idx=LRU_out;						  
                end

            end

            NO_REQ: begin
                // but what if mem_read comes now? if its a hit respond otherwise
                // we need to definitely need to finish writing back
                if((|hit_complete) && mem_read==1'b1) begin // && no_req_writing==1'b0) begin
                    mem_resp=1'b1;
                    mem_rdata_mux_sel=hit_decimal+1;//1'b1;

                    pmem_wdata_mux_sel=hit_decimal+1;//1'b1;
                    pmem_address_mux_sel=hit_decimal+1;//1'b1;
                    pmem_write=1'b1;
                    no_req_writing=1'b1;
                end

                // but what if mem_write comes now? if its not dirty we can immediately write
                else if((|hit_complete) && mem_write==1'b1 && dirty[hit_decimal]==1'b0) begin // && no_req_writing==1'b0) begin
                    out_valid=1'b1; // data in victim is now valid
                    out_dirty=1'b1; // data is also dirty FIXME: IS THIS CORRECT?

                    write=1'b1;
                    mem_resp=1'b1;
						  idx=hit_decimal;

                    pmem_wdata_mux_sel=hit_decimal+1;//1'b1;
                    pmem_address_mux_sel=hit_decimal+1;//1'b1;
                    pmem_write=1'b1;
                    no_req_writing=1'b1;
						  
						  prev_LRU_out=LRU_out;
                end

                //else if(mem_write==1'b1 && valid==1'b0 && no_req_writing==1'b0) begin
                    //out_valid=1'b1; // data in victim is now valid
                    //out_dirty=1'b0; // data is also dirty FIXME: IS THIS CORRECT?

                    //write=1'b1;
                    //mem_resp=1'b1;
                //end
					 
                else begin // else we can continue with the NO_REQ design feature
                    pmem_wdata_mux_sel=LRU_out+1;//1'b1; // write to pmem from data_line as no req
                    pmem_address_mux_sel=LRU_out+1;//1'b1;
                    pmem_write=1'b1;
                    no_req_writing=1'b1;
						  
						  prev_LRU_out=LRU_out;
                    //write=1'b1; // update the dirty to 0 in datapath so we do not come back to NO_REQ
                    // data is now not valid and not dirty assigned by default
                    //out_valid=1'b0; out_dirty=1'b0; // FIXME: NOT SURE
                end

            end

            READ_PMEM: begin
                // assign pmem_resp to mem_resp as this is a passthrough to L2
                mem_resp=pmem_resp;
                mem_rdata_mux_sel=4'b0000; // we want to read from pmem now
                pmem_address_mux_sel=4'b0000;
                pmem_read=1'b1;
                // no need to invalidate data in the victim as it is still valid
            end

            DONE_READ_PMEM: begin
                mem_resp=pmem_resp;
                mem_rdata_mux_sel=1'b0;
            end

            default: ;
        endcase
    end

    /****************NEXT_STATE_LOGIC******************/
    always_comb
    begin: next_state_logic
        next_state=state;

        case(state)
            IDLE: begin
                // if mem read and data is not present in the victim cache
                // read from pmem like normal if data is not valid as well we will read
                if(mem_read==1'b1 && (|hit_complete)==1'b0) begin // && just_serviced_read==1'b0) begin
                    next_state=READ_PMEM;
                end

                // if hit and mem_write and valid we can update
                else if(mem_write==1'b1 && (|hit_complete)==1'b1 && valid[hit_decimal]==1'b1) begin
                    next_state=IDLE;
                end

                // else if dirty and mem_write prioritize this and write victim to pmem
                else if(mem_write==1'b1 && dirty[LRU_out]==1'b1) begin // hit==1'b0 && dirty==1'b1 && valid==1'b1 && mem_write==1'b1) begin
                    next_state=WB;
                end
                
                // there is data but it hasnt been written to pmem yet and we cannot overwrite this as this is not a hit
                else if(valid[LRU_out]==1'b1 && dirty[LRU_out]==1'b0 && mem_write==1'b1 && (|hit_complete)==1'b0) begin
                    next_state=WB;
                end

                else if(valid[LRU_out]==1'b1 && dirty[LRU_out]==1'b0 && mem_read==1'b1 && (|hit_complete)==1'b0) begin
                    next_state=READ_PMEM;
                end

                // else if dirty data in victim and we have no requests to service
                else if(dirty[LRU_out]) begin// && just_serviced_write==1'b0) begin//valid && just_serviced_write==1'b0) begin //dirty && valid) begin
                    next_state=NO_REQ;
                end
                
                // else continue IDLE
                else begin
                    next_state=IDLE;
                end
            end

            WB: begin
                if(pmem_resp==1) begin
                    next_state=DONE_WB;
                end
                else begin
                    next_state=WB;
                end
            end

            DONE_WB: begin
                next_state=IDLE;
            end

            DONE_NO_REQ: begin
                next_state=IDLE;
            end


            NO_REQ: begin
                if(pmem_resp==1) begin
                    next_state=DONE_NO_REQ;
                end
                else begin
                    next_state=NO_REQ;
                end
            end

            READ_PMEM: begin
                if(pmem_resp==1) begin
                    next_state=DONE_READ_PMEM;
                end
                else begin
                    next_state=READ_PMEM;
                end
            end

            DONE_READ_PMEM: begin
                next_state=IDLE;
            end

            default: ;
        endcase
    end

    /**********ASSIGN NEXT STATE************/
    always_ff @(posedge clk)
    begin:next_state_assignment
        state<=next_state;
    end

endmodule:victim_control
