import lc3b_types::*;

module comparator #(parameter width = 9)
(
	input [width-1:0] in1,
	input [width-1:0] in2,
	output logic out
);
always_comb
begin
	if(in1 == in2)
		out = 1'b1;
	else out = 1'b0;
end

endmodule : comparator