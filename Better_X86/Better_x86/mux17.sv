module mux17 #(parameter width = 16)
(
	input [4:0] sel,
	input [width-1:0] _0, _1, _2, _3, _4, _5, _6,
	input [width-1:0] _7, _8, _9, _10, _11, _12, 
	input [width-1:0] _13, _14, _15, _16,
	output logic [width-1:0] out
);

always_comb
begin
    unique case (sel)
        5'b00000 : out = _0;
        5'b00001 : out = _1;
        5'b00010 : out = _2;
        5'b00011 : out = _3;
        5'b00100 : out = _4;
        5'b00101 : out = _5;
        5'b00110 : out = _6;
		  5'b00111 : out = _7;
		  5'b01000 : out = _8;
		  5'b01001 : out = _9;
		  5'b01010 : out = _10;
		  5'b01011 : out = _11;
		  5'b01100 : out = _12;
		  5'b01101 : out = _13;
		  5'b01110 : out = _14;
		  5'b01111 : out = _15;
		  5'b10000 : out = _16;
		  default : out={width{1'bx}};
    endcase
end

endmodule : mux17