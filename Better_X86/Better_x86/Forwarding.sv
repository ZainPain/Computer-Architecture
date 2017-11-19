import lc3b_types::*;

module forward
(
	input lc3b_reg ID_EX_sr1,
	input lc3b_reg ID_EX_sr2,
	input logic EX_MEM_write,
	input logic MEM_WB_write,
	input lc3b_reg EX_MEM_dest,
	input lc3b_reg MEM_WB_dest,
	output logic [1:0] ForwardA,
	output logic [1:0] ForwardB
		
);
always_comb
begin

	/* MEM HAZARD */
	if( MEM_WB_write && !( /*EX_MEM_write && */(EX_MEM_dest == ID_EX_sr1)) && ( MEM_WB_dest == ID_EX_sr1) && ( MEM_WB_dest != ID_EX_sr2))
	begin
		ForwardA = 2'b01;
		ForwardB = 2'b00;
	end
	else if( MEM_WB_write && !( /*EX_MEM_write && */(EX_MEM_dest == ID_EX_sr2)) && ( MEM_WB_dest != ID_EX_sr1) && ( MEM_WB_dest == ID_EX_sr2))
	begin
		ForwardA = 2'b00;
		ForwardB = 2'b01;
	end
	
	else if( MEM_WB_write && !(/* EX_MEM_write && */(EX_MEM_dest == ID_EX_sr2)) && ( MEM_WB_dest == ID_EX_sr2) && ( MEM_WB_dest == ID_EX_sr1))
	begin
		ForwardA = 2'b01;
		ForwardB = 2'b01;
	end
	
	/* EX HAZARD */
	else if( EX_MEM_write && ( EX_MEM_dest == ID_EX_sr1) && ( EX_MEM_dest != ID_EX_sr2))
	begin
		ForwardA = 2'b10;
		ForwardB = 2'b00;
	end
	else if( EX_MEM_write && ( EX_MEM_dest == ID_EX_sr2) && ( EX_MEM_dest != ID_EX_sr1))
	begin
		ForwardA = 2'b00;
		ForwardB = 2'b10;
	end
	else if( EX_MEM_write && ( EX_MEM_dest == ID_EX_sr2) && ( EX_MEM_dest == ID_EX_sr1))
	begin
		ForwardA = 2'b10;
		ForwardB = 2'b10;
	end
	/* Default to let sr1 and alumux_out to pass to ALU */
	else
	begin
		ForwardA = 2'b00;
		ForwardB = 2'b00;
	end
end

endmodule: forward