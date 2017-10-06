import lc3b_types::*;

module __AND__ #(parameter width = 9)
(
	input [width-1:0] in1,
	input [width-1:0] in2,
	output logic out
);
assign out = in1 && in2;
endmodule : __AND__