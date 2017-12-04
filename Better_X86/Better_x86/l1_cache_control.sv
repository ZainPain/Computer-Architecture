import lc3b_types::*;

module l1_cache_control
(
	input clk,

	output logic mem_resp,
	output logic pmem_read,
	output logic pmem_write,
	output logic waymux_sel,
	output logic write_array_sel,
	output logic data0_load,
	output logic data1_load,
	output logic tag0_load,
	output logic tag1_load,
	output logic valid0_load,
	output logic valid1_load,
	output logic dirty0_load,
	output logic dirty1_load,
	output logic lru_load,
	output logic valid0_in,
	output logic valid1_in,
	output logic dirty0_in,
	output logic dirty1_in,
	output logic lru_in,
	output logic [1:0] pmem_address_sel,
	
	input logic mem_read,
	input logic mem_write,  
	input logic pmem_resp,
	input logic valid0_out,
	input logic valid1_out,
	input logic dirty0_out,
	input logic dirty1_out,
	input logic lru_out,
	input logic match0,
	input logic match1
);

logic no_match;
logic match0_invalid;
logic match1_invalid;

assign no_match = ~match0 && ~match1;
assign match0_invalid = match0 && ~valid0_out;
assign match1_invalid = match1 && ~valid1_out;

enum int unsigned {
	/* List of states */
	compare_tag,
	read_block1,
	read_block2,
	/*write_block1,*/
	write_block
} state, next_states;

always_comb
begin : state_actions
	/* Default output assignments */
	/* Actions for each state */
	mem_resp = 0;
	pmem_read = 0;
	pmem_write = 0;
	waymux_sel = 0;
	write_array_sel = 0;
	data0_load = 0;
	data1_load = 0;
	tag0_load = 0;
	tag1_load = 0;
	valid0_load = 0;
	valid1_load = 0;
	dirty0_load = 0;
	dirty1_load = 0;
	lru_load = 0;
	valid0_in = valid0_out;
	valid1_in = valid1_out;
	dirty0_in = dirty0_out;
	dirty1_in = dirty1_out;
	lru_in = lru_out;
	pmem_address_sel = 2'b00;
	
	case(state)
		compare_tag: begin
			if (match0 && valid0_out && (mem_read || mem_write))
			begin
				waymux_sel = 0;
				lru_in = 0;
				mem_resp = 1;
				lru_load = 1;
				if (mem_write)
				begin
					write_array_sel = 0;
					data0_load = 1;
					dirty0_in = 1;
					dirty0_load = 1;
				end
			end
			else if (match1 && valid1_out && (mem_read || mem_write))
			begin
				waymux_sel = 1;
				lru_in = 1;
				mem_resp = 1;
				lru_load = 1;
				if (mem_write)
				begin
					write_array_sel = 0;
					data1_load = 1;
					dirty1_in = 1;
					dirty1_load = 1;
				end
			end
            else if (no_match && ((~lru_out && dirty1_out) || 
				(lru_out && dirty0_out)) && (mem_read || mem_write))
				begin
                    if(lru_out && dirty0_out)  /* set 0 needs to be written back */
                    begin    
                        pmem_address_sel = 2'b01;
                        waymux_sel = 0;
                        //pmem_write = 1;
                    end
                    else if(~lru_out && dirty1_out) /* set 1 needs to be written back */
                    begin
                        pmem_address_sel = 2'b10;
                        waymux_sel = 1;
                        //pmem_write = 1;
                    end
                end
			/*else if ((no_match || match0_invalid || match1_invalid)
				&& (mem_read || mem_write))
				pmem_read = 1;*/
		end
		
		write_block: begin
			if(lru_out && dirty0_out)  /* set 0 needs to be written back */
			begin    
				pmem_address_sel = 2'b01;
				waymux_sel = 0;
            pmem_write = 1;
			end
			else if(~lru_out && dirty1_out) /* set 1 needs to be written back */
			begin
				pmem_address_sel = 2'b10;
				waymux_sel = 1;
            pmem_write = 1;
			end
		end

		/*write_block2: begin
			if(lru_out && dirty0_out)
				pmem_write = 1;
			else if(~lru_out && dirty1_out)
				pmem_write = 1;
		end */
		
		read_block1: begin
			//if (!pmem_resp)
         pmem_read = 1;
         if (pmem_resp && lru_out)
			begin
				tag0_load = 1;
				data0_load = 1;
				write_array_sel = 1;
				lru_in = 0;
				lru_load = 1;
				valid0_in = 1;
				valid0_load = 1;
				dirty0_in = 0;
				dirty0_load = 1;
			end
			else if(pmem_resp && ~lru_out)
			begin
				tag1_load = 1;
				data1_load = 1;
				write_array_sel = 1;
				lru_in = 1;
				lru_load = 1;
				valid1_in = 1;
				valid1_load = 1;
				dirty1_in = 0;
				dirty1_load = 1;
			end
        end

		/*read_block2: begin
			if (lru_out)
			begin
				tag0_load = 1;
				data0_load = 1;
				write_array_sel = 1;
				lru_in = 0;
				lru_load = 1;
				valid0_in = 1;
				valid0_load = 1;
				dirty0_in = 0;
				dirty0_load = 1;
			end
			else if(~lru_out)
			begin
				tag1_load = 1;
				data1_load = 1;
				write_array_sel = 1;
				lru_in = 1;
				lru_load = 1;
				valid1_in = 1;
				valid1_load = 1;
				dirty1_in = 0;
				dirty1_load = 1;
			end
		end*/

		default: /* Do nothing */;

	endcase
end

always_comb
begin : next_state_logic
	/* Next state information and conditions (if any)
	 * for transitioning between states */
	next_states = state;

	case(state)
		compare_tag: begin
			if ((match0 && valid0_out) || (match1 && valid1_out))
				next_states <= compare_tag;
			else if (no_match && ((~lru_out && dirty1_out) || 
				(lru_out && dirty0_out)) && (mem_read || mem_write))
				next_states <= write_block;
			else if ((no_match || match0_invalid || match1_invalid)
				&& (mem_read || mem_write))
				next_states <= read_block1;
			else
				next_states <= compare_tag;
		end

		/*write_block1:
			next_states <= write_block2;*/

		write_block:
			if(pmem_resp)
				next_states <= read_block1;
			else
				next_states <= write_block;
		
		read_block1: begin
			if (pmem_resp)
				next_states <= compare_tag;
			else
				next_states <= read_block1;
		end

		/*read_block2:
			next_states <= compare_tag; */

		default: /* Do nothing */;

	endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
	/* Assignment of next state on clock edge */
	state <= next_states;
end

endmodule : l1_cache_control