import lc3b_types::*;

module comparator #(parameter width = 9)
(
	input lc3b_tag  in1,
	input lc3b_tag in2,
	output logic out
);
assign out = in1 & in2;

endmodule : comparator