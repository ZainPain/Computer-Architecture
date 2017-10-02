import lc3b_types::*;

module adder #(parameter width = 16)
(
	input lc3b_word adj9_out,
	input [width-1:0] in,
	output logic [width-1:0] out
);

always_comb 
begin
	
	out = in + adj9_out;

end
endmodule : adder