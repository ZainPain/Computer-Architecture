import lc3b_types::*;

module truncator
(
	input sel,
	input lc3b_word in,
	output lc3b_word out
);
always_comb
	begin
		if(sel)
			out = $unsigned(in[7:0]);
		else
			out = in;
	end

endmodule : truncator
