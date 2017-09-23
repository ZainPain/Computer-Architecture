import lc3b_types::*;

/*
 * SEXT[offset-n << 1]
 */
module mod #(parameter width = 16)
(
    input [width-1:0] in,
    output logic mod_out
);

always_comb
	begin
	if(in%2'b10)
		mod_out = 1'b1;
	else
		mod_out = 1'b0;
	
	end
	

endmodule : mod
