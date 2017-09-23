import lc3b_types::*;

module cccomp #(parameter width = 3)
(
	input lc3b_reg dest,
	input lc3b_nzp nzp,
	output logic out

);

always_comb
begin
	
	/* if the condition is met, we enable branching */
	if((nzp[2] && dest[2])  || (nzp[1] && dest[1]) || (nzp[0] && dest[0]))
		out = 1;
	else
		out = 0;

end

endmodule : cccomp