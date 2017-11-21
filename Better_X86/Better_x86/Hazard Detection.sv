import lc3b_types::*;

module hazard_detection
(
	input lc3b_opcode opcode,
	input logic bit5,
	input ID_EX_mem_read,
	input lc3b_reg ID_EX_dest,
	input lc3b_reg IF_ID_sr1,
	input lc3b_reg IF_ID_sr2,	

	output logic forward_load,
	output logic hazard
);

always_comb
begin
	
	hazard = 1'b0;
	forward_load = 1'b1;
	if(ID_EX_mem_read && ((ID_EX_dest == IF_ID_sr1) || (ID_EX_dest == IF_ID_sr2 && (opcode == op_add || opcode == op_and) && !bit5 ) ) )
	begin
		forward_load = 1'b0;		// stop loading for pc and IF_ID
		hazard = 1'b1;	
		
	end

	
end
endmodule : hazard_detection