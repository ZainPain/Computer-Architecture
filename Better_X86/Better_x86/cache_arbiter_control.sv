module cache_arbiter_control
(
	input clk,
	
	input logic icache_read,
	input logic dcache_read,
	input logic dcache_write,
	input logic l2_resp,

	output logic cache_address_sel,
	output logic [1:0] cache_read_sel,
	output logic cache_write_sel,
	output logic cache_resp_sel,
	output logic load_mar,
	output logic load_mdr_l1_to_l2,
	output logic load_mdr_l2_to_l1,
	output logic l2_read,
	output logic l2_write
);

enum int unsigned {
	/* List of states */
	idle,
	data_write,
	data_read,
	instruction_read
} state, next_state;

always_comb
begin: state_actions
	/* Default output assignments */

	load_mar = 0;
	load_mdr_l1_to_l2 = 0;
	load_mdr_l2_to_l1 = 0;
	cache_write_sel = 0;
	cache_address_sel = 0;
   cache_resp_sel = 0;
	l2_read = 0;
	l2_write = 0;

	case(state)
		idle: begin
			if(dcache_read) begin
				cache_address_sel = 1;
				load_mar = 1;
			end
			else if (dcache_write) begin
				cache_address_sel = 1;
				load_mar = 1;
				load_mdr_l1_to_l2 = 1;
			end
			else if (icache_read) begin
				cache_address_sel = 0;
				load_mar = 1;
			end
		end
		
		data_write: begin
			if (l2_resp && dcache_read) begin
				cache_resp_sel = 1;
				cache_address_sel = 1;
				load_mar = 1;
			end
			else if (l2_resp && icache_read) begin
				cache_resp_sel = 1;
				cache_address_sel = 0;
				load_mar = 1;
			end
			else if (l2_resp)
				cache_resp_sel = 1;
			else begin
				l2_write = 1;
            cache_address_sel = 1;
            end
		end

		data_read: begin
			if (l2_resp && icache_read) begin
				load_mdr_l2_to_l1 = 1;
				cache_resp_sel = 1;
				cache_address_sel = 0;
				load_mar = 1;
			end
			else if (l2_resp) begin
				load_mdr_l2_to_l1 = 1;
				cache_resp_sel = 1;
			end
			else begin
				l2_read = 1;
				 cache_address_sel = 1;
            end
		end

		instruction_read: begin
			if (l2_resp && dcache_write) begin
				load_mdr_l2_to_l1 = 1;
				cache_resp_sel = 0;
				cache_address_sel = 1;
				load_mar = 1;
				load_mdr_l1_to_l2 = 1;
            end
			else if (l2_resp && dcache_read) begin
				load_mdr_l2_to_l1 = 1;
				cache_resp_sel = 0;
				cache_address_sel = 1;
				load_mar = 1;
			end
			else if (l2_resp) begin
				load_mdr_l2_to_l1 = 1;
				cache_resp_sel = 0;
			end
			else
				l2_read = 1;
		end

		default: ;

	endcase
end

always_comb
begin: next_state_logic
	next_state = state;

	case(state)
		idle: begin
			if(dcache_read)
				next_state <= data_read;
			else if (dcache_write)
				next_state <= data_write;
			else if (icache_read)
				next_state <= instruction_read;
			else
				next_state <= idle;
		end

		data_write: begin
			if (l2_resp && dcache_read)
				next_state <= data_read;
			else if (l2_resp && icache_read)
				next_state <= instruction_read;
			else if (l2_resp)
				next_state <= idle;
			else
				next_state <= data_write;
		end

		data_read: begin
			if (l2_resp && icache_read)
				next_state <= instruction_read;
			else if (l2_resp)
				next_state <= idle;
			else
				next_state <= data_read;
		end

		instruction_read:
			if (l2_resp && dcache_write)
				next_state <= data_write;
			else if (l2_resp && dcache_read)
				next_state <= data_read;
			else if (l2_resp)
				next_state <= idle;
			else
				next_state <= instruction_read;

		default: ;
	endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
	/* Assignment of next state on clock edge */
	state <= next_state;
end

endmodule : cache_arbiter_control