module byte_select #(parameter width = 16)
(

	input [width-1:0] in,address,
	output logic [width-1:0] out 
);

assign out = address[0] ? $unsigned({8'b00000000,in[15:8]}) : $unsigned({8'b00000000,in[7:0]}) ;

endmodule : byte_select