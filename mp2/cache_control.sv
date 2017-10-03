import lc3b_types::*;
module cache_control
(
	input clk,
	input hit,
	output load_tag0,
	output load_tag1,
	output load_lru,
	output load_data0,
	output load_data1,
	output load_valid0,
	output load_valid1,
	output inviction,
	
	input mem_resp,
	input logic mem_read,
	input logic mem_write,
	input lc3b_mem_wmask mem_byte_enable
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
	
	load_tag0 = 1'b0;
	load_tag1 = 1'b0;
	load_lru = 1'b0;
	load_data0 = 1'b0;
	load_data1 = 1'b0;
	load_valid0 = 1'b0;
	load_valid1 = 1'b0;
	inviction = 1'b0;
	
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

	 endcase
	 
	 
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
	 state <= next_state;
end

endmodule : cache_control