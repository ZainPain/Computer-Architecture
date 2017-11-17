import lc3b_types::*;

module adder #(parameter width = 16)
(
	input [width-1:0] in1,
	input [width-1:0] in2,
	output logic [width-1:0] out
);

always_comb 
begin
	
	out = in1+in2;

end
endmodule : adder