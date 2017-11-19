import lc3b_types::*;

module hazard_detection
(
	input ID_EX_mem_read,
	input lc3b_reg ID_EX_dest,
	input lc3b_reg IF_ID_sr1,
	input lc3b_reg IF_ID_sr2,
	
	output logic forward_load,
	output logic controlmux_sel
);

always_comb
begin
	
	forward_load = 1'b1;
	controlmux_sel = 1'b0;
	
	if(ID_EX_mem_read && ((ID_EX_dest == IF_ID_sr1) || (ID_EX_dest == IF_ID_sr2)))
	begin
		forward_load = 1'b0;		// stop loading for pc and IF_ID
		controlmux_sel = 1'b1;	// switch from controlword to NOPS
	end
end
endmodule : hazard_detection