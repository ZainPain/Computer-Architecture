import lc3b_types::*;

module pseudo_lru_16_way_pos
(
	input clk,
	input load,
	input logic [3:0] hit,
	output logic [3:0] dataout
);

logic [14:0] lru_bits;

logic [14:0] update_way_array [15:0];

/*initial
begin
	update_way_array[0] = 15'b0;
	update_way_array[1] = {7'b0,1'b1,7'b0};
	update_way_array[2] = {11'b0,1'b1,3'b0};
	update_way_array[3] = {7'b0,1'b1,8'b0};
end */

initial
begin
	lru_bits = {15{1'b1}};
end

always_ff @(posedge clk)
begin
	if (load) begin
		unique case (hit)
			4'd0: begin
				lru_bits[0] = 0;
				lru_bits[1] = 0;
				lru_bits[3] = 0;
				lru_bits[7] = 0;
			end

			4'd1: begin
				lru_bits[0] = 0;
				lru_bits[1] = 0;
				lru_bits[3] = 0;
				lru_bits[7] = 1;
			end
			4'd2: begin
				lru_bits[0] = 0;
				lru_bits[1] = 0;
				lru_bits[3] = 1;
				lru_bits[8] = 0;
			end

			4'd3: begin
				lru_bits[0] = 0;
				lru_bits[1] = 0;
				lru_bits[3] = 1;
				lru_bits[8] = 1;
			end

			4'd4: begin
				lru_bits[0] = 0;
				lru_bits[1] = 1;
				lru_bits[4] = 0;
				lru_bits[9] = 0;
			end

			4'd5: begin
				lru_bits[0] = 0;
				lru_bits[1] = 1;
				lru_bits[4] = 0;
				lru_bits[9] = 1;
			end
			4'd6: begin
				lru_bits[0] = 0;
				lru_bits[1] = 1;
				lru_bits[4] = 1;
				lru_bits[10] = 0;
			end

			4'd7: begin
				lru_bits[0] = 0;
				lru_bits[1] = 1;
				lru_bits[4] = 1;
				lru_bits[10] = 1;
      end

			4'd8: begin
				lru_bits[0] = 1;
				lru_bits[2] = 0;
				lru_bits[5] = 0;
				lru_bits[11] = 0;
			end

			4'd9: begin
				lru_bits[0] = 1;
				lru_bits[2] = 0;
				lru_bits[5] = 0;
				lru_bits[11] = 1;
			end
			4'd10: begin
				lru_bits[0] = 1;
				lru_bits[2] = 0;
				lru_bits[5] = 1;
				lru_bits[12] = 0;
			end

			4'd11: begin
				lru_bits[0] = 1;
				lru_bits[2] = 0;
				lru_bits[5] = 1;
				lru_bits[12] = 1;
			end

			4'd12: begin
				lru_bits[0] = 1;
				lru_bits[2] = 1;
				lru_bits[6] = 0;
				lru_bits[13] = 0;
			end

			4'd13: begin
				lru_bits[0] = 1;
				lru_bits[2] = 1;
				lru_bits[6] = 0;
				lru_bits[13] = 1;
			end
			4'd14: begin
				lru_bits[0] = 1;
				lru_bits[2] = 1;
				lru_bits[6] = 1;
				lru_bits[14] = 0;
			end

			4'd15: begin
				lru_bits[0] = 1;
				lru_bits[2] = 1;
				lru_bits[6] = 1;
				lru_bits[14] = 1;
			end

			default: /* do nothing */ ;
		endcase
	end
end

always_comb
begin
	if (lru_bits[0] == 1) /* Go to 0 side of L0 */
	begin
		if (lru_bits[1] == 1) /* Go to 0 side of L1 */
		begin
			if (lru_bits[3] == 1) /* Go to 0 side of L3 */
			begin
				if (lru_bits[7] == 1) /* Go to 0 side of L7 */
				begin
					dataout = 4'd0;
				end

				else /* Go to 1 side of L7 */
				begin
					dataout = 4'd1;
				end
			end

			else /* Go to 1 side of L3 */
			begin
				if (lru_bits[8] == 1) /* Go to 0 side of L8 */
				begin
					dataout = 4'd2;
				end
				else /* Go to 1 side of L8 */
				begin
					dataout = 4'd3;
				end
			end
		end

		else /* Go to 1 side of L1 */
		begin
			if (lru_bits[4] == 1) /* Go to 0 side of L4 */
			begin
				if (lru_bits[9] == 1) /* Go to 0 side of L9 */
				begin
					dataout = 4'd4;
				end
				else /* Go to 1 side of L9 */
				begin
					dataout = 4'd5;
				end
			end
			else /* Go to 1 side of L4 */
			begin
				if (lru_bits[10] == 1) /* Go to 0 side of L10 */
				begin
					dataout = 4'd6;
				end
				else
				begin /* Go to 1 side of L10 */
					dataout = 4'd7;
				end
			end
		end
	end
	
	else /* Go to 1 side of L0 */
	begin
		if (lru_bits[2] == 1) /* Go to 0 side of L2 */
		begin
			if (lru_bits[5] == 1) /* Go to 0 side of L5 */
			begin
				if (lru_bits[11] == 1) /* Go to 0 side of L11 */
				begin
					dataout = 4'd8;
				end

				else /* Go to 1 side of L11 */
				begin
					dataout = 4'd9;
				end
			end

			else /* Go to 1 side of L5 */
			begin
				if (lru_bits[12] == 1) /* Go to 0 side of L12 */
				begin
					dataout = 4'd10;
				end
				else /* Go to 1 side of L12 */
				begin
					dataout = 4'd11;
				end
			end
		end

		else /* Go to 1 side of L2 */
		begin
			if (lru_bits[6] == 1) /* Go to 0 side of L6 */
			begin
				if (lru_bits[13] == 1) /* Go to 0 side of L13 */
				begin
					dataout = 4'd12;
				end
				else /* Go to 1 side of L13 */
				begin
					dataout = 4'd13;
				end
			end
			else /* Go to 1 side of L6 */
			begin
				if (lru_bits[14] == 1) /* Go to 0 side of L14 */
				begin
					dataout = 4'd14;
				end
				else
				begin /* Go to 1 side of L14 */
					dataout = 4'd15;
				end
			end
		end
	end
end

endmodule : pseudo_lru_16_way_pos