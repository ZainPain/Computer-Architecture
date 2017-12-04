import lc3b_types::*;

module PHT
(
	input clk,
	input [9:0]index,
	input [9:0]updated_index,	//	index used to update counter with
	input [1:0] updated_counter,		// counter value to be updated to
	input update,						// flag used for updating counter with
	
	output logic [1:0] prediction,		// prediction taken out of counter
	output logic [9:0]index_out			// index out of that prediction
);

// logic [127:0] mem [0:2**($bits(address)-4)-1];
logic [1:0] pht [(2**($bits(index))-1):0];

initial
begin
	for(int i = 0; i < $size(pht);i++)
	begin
		pht[i] = 2'b01;
	end
end

always_ff @(negedge clk )
begin
	if(update)		/* update counter */
	begin
		pht[updated_index] = updated_counter;
	end

end

always_comb
begin
	/* extract prediction from pht */
	index_out = index;
  prediction = pht[index];

end

endmodule : PHT
