import lc3b_types::*;

/*
 * SEXT[offset-n << 1]
 */
module mask #(parameter width = 16)
(
    input [width-1:0] in,
	 input lc3b_word address,
	 input logic mask_enable,
    output [width-1:0] mask_out
);


//assign mask_out = mask_enable ? (address[0] ? $unsigned({8'b00000000,in[15:8]}) : $unsigned({8'b00000000,in[7:0]}))  : in;
lc3b_word shit;

always_comb
begin
	if(mask_enable)
		begin
			if(address[0])
				shit = 16'(unsigned'(in[15:8]));
			else
				shit = 16'(unsigned'(in[7:0]));
		
		end
		
	else
		shit = in;
end
assign mask_out = shit;
	

endmodule : mask
