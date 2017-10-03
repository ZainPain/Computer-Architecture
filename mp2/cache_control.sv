import lc3b_types::*;
module cache_control
(
	
	input logic clk,
	/* control signals */
	input logic hit,
	input logic way_select,
	/* load signals */
	output logic load_tag1,
	output logic load_tag2,
	output logic load_lru,
	output logic load_data1,
	output logic load_data2,
	output logic load_valid1,
	output logic load_valid2,
	output logic eviction,
	
	/* set value */
	output logic valid1_in,
	output logic valid2_in,
	input logic valid1_out,
	input logic valid2_out,
	output logic lru_in,
	input logic lru_out,
	/* mem signals */
	input logic mem_read,
	input logic mem_write,
	input logic pmem_resp,
	input logic [1:0] mem_byte_enable,
	
	output logic mem_resp,
	output logic pmem_read,
	output logic pmem_write
	
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
	pmem_read = 1'b0;
	pmem_write = 1'b0;
	mem_resp = 1'b0; 
	lru_in = 1'b0;
	valid1_in = 1'b0;
	valid2_in = 1'b0;
	case(state)
	
		idle:
		begin
			/* pretty much do nothing until a miss occurs*/
			if(hit && mem_read)
			begin
				/* if we have a hit and we want to read data from the cache*/
				/* check way_select where the mux's select bit == 0 */
				load_lru = 1'b1;
				mem_resp = 1'b1;
				if(way_select)
				begin
					/* this is the case where way_select is 1 which corresponds to way 1 having a hit */
					lru_in = 1'b1;
				end
				else 
					lru_in = 1'b0;
					
			end
		end
		
		allocate:
		begin
			/* state for when a miss occurs */
			if(!valid1_out)
			begin
				load_valid1 = 1'b1;
				valid1_in = 1'b1;
				
				load_data1 = 1'b1;
				load_tag1 = 1'b1;
				mem_resp = pmem_resp;
				pmem_read = mem_read;
				load_lru = 1'b1;
				lru_in = 1'b0;
			end
			else if (!valid2_out && valid1_out)
			begin
				load_valid2 = 1'b1;
				valid2_in = 1'b1;
				
				load_data2 = 1'b1;
				load_tag2 = 1'b1;
				mem_resp = pmem_resp;
				pmem_read = mem_read;
				load_lru = 1'b1;
				lru_in = 1'b1;
			end
			else
			eviction = 1'b1;
			begin/* eviction case*/
				if(lru_out) /* if lru out is 1 that means way 1 was recently used thus we replace way 0 */
				begin
					load_data1 = 1'b1;
					load_tag1 = 1'b1;
					load_lru = 1'b1;
					lru_in = 1'b0;
					
				end
				else
				begin
					load_data2 = 1'b1;
					load_tag2 = 1'b1;
					load_lru = 1'b1;
					lru_in = 1'b1;
				end
			end
		end
		
		write_back:
		begin
			/* Do nothing for this checkpoint */
		end
		default: /* Do Nothing */;
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
			/* stay in idle unless there is a cache miss */
			if((!hit && mem_read) || (!hit && mem_write))
				next_state <= allocate;
			else 
				next_state <= idle;
		end
		
		allocate:
		begin
			/* wait until we hear back from memory */
			if(pmem_resp)
				next_state <= idle;
			else
				next_state <= allocate;
		end
		write_back:
		begin
			next_state <= idle;	/* Not using write-back for this checkpoint*/
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