module stb_shifter #(parameter width = 16)
(

	input [width-1:0] in,
	input logic shift,
	output logic [width-1:0] out 
);

assign out = shift ? $unsigned({in[7:0],8'b00000000}) : in ;

endmodule : stb_shifter