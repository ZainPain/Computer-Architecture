import lc3b_types::*;
module cache_control
(
	
	input clk,
	/* control signals */
	input hit,
	
	/* load signals */
	output load_tag1,
	output load_tag2,
	output load_lru,
	output load_data1,
	output load_data2,
	output load_valid1,
	output load_valid2,
	output eviction,
	
	/* mem signals */
	input mem_read,
	input mem_write,
	input pmem_resp,
	input [1:0] mem_byte_enable,
	
	output mem_resp,
	output pmem_read,
	output pmem_write
	
);
enum int unsigned {
	idle,
	allocate,
	write_back
} state, next_state;

always_comb
begin : state_actions
/* Default output assignments */
/* FIRST ALWAYS COMB */
	
	load_tag1 = 1'b0;
	load_tag2 = 1'b0;
	load_lru = 1'b0;
	load_data1 = 1'b0;
	load_data2 = 1'b0;
	load_valid1 = 1'b0;
	load_valid2 = 1'b0;
	eviction = 1'b0;
	pmem_read = mem_read;
	pmem_write = mem_write;
	mem_resp = pmem_resp;
	case(state)
	
		idle:
		begin
			
		end
		
		allocate:
		begin
			
		end
		
		write_back:
		begin
		
		end
	
		endcase
end
always_comb
begin : next_state_logic
    /* Next state information and conditions (if any)
     * for transitioning between states */
	 /* SECOND ALWAYS COMB */
	 next_state = state;
	 case(state)
	 
		idle:
		begin
			if(!hit)
				next_state <= allocate;
			else 
				next_state <= idle;
		end
		
		allocate:
		begin
			if(mem_resp)
				next_state <= idle;
			else
				next_state <= allocate;
		end
	default:/* Nothing */;
	 endcase
	 
	 
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
	 state <= next_state;
end

endmodule : cache_control