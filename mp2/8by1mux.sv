import lc3b_types::*;

module mux16by2 
(
	input lc3b_data in1,
	input lc3b_data in2,
	input logic way_select,
	input [3:0] offset,
	output lc3b_word out
);
always_comb
begin
	if(!way_select)
	begin 
		case(offset)
			4'b0000 :	out = in1[15:0];
			4'b0001 :	out = in1[15:0];
			4'b0010 :	out = in1[31:16];
			4'b0011 :	out = in1[31:16];
			4'b0100 :	out = in1[47:32];
			4'b0101 :	out = in1[47:32];
			4'b0110 :	out = in1[63:48];
			4'b0111 :	out = in1[63:48];
			
			
			4'b1000 :	out = in1[79:64];
			4'b1001 :	out = in1[79:64];
			4'b1010 :	out = in1[95:80];
			4'b1011 :	out = in1[95:80];
			4'b1100 :	out = in1[111:96];
			4'b1101 :	out = in1[111:96];
			4'b1110 :	out = in1[127:112];
			4'b1111 :	out = in1[127:112];
			default: $display("You F'ed up");
		endcase
	end
	else
	begin
		case(offset)
			4'b0000 :	out = in2[15:0];
			4'b0001 :	out = in2[15:0];
			4'b0010 :	out = in2[31:16];
			4'b0011 :	out = in2[31:16];
			4'b0100 :	out = in2[47:32];
			4'b0101 :	out = in2[47:32];
			4'b0110 :	out = in2[63:48];
			4'b0111 :	out = in2[63:48];
			
			
			4'b1000 :	out = in2[79:64];
			4'b1001 :	out = in2[79:64];
			4'b1010 :	out = in2[95:80];
			4'b1011 :	out = in2[95:80];
			4'b1100 :	out = in2[111:96];
			4'b1101 :	out = in2[111:96];
			4'b1110 :	out = in2[127:112];
			4'b1111 :	out = in2[127:112];
			default: $display("You F'ed up");
		endcase
	end
end


endmodule : mux16by2