import lc3b_types::*;

module forward
(
	input lc3b_opcode opcode,
	input logic bit5,
	input lc3b_reg ID_EX_sr1,
	input lc3b_reg ID_EX_sr2,
	input logic EX_MEM_write,
	input logic MEM_WB_write,
	input lc3b_reg EX_MEM_dest,
	input lc3b_reg MEM_WB_dest,
	output logic [1:0] ForwardA,
	output logic [1:0] ForwardB
		
);

/* Before forwarding, we must first verify that the operands are indeed correct for forwarding ( this means that there is a valid sr1 and sr2 in the instruction and it isnt using offset values).
	there are only two instructions that use both SR1 and SR2 in calculation of their destination addresses. (ADD and AND).
	This should take opcode and bit 6 to verify AND and ADD*/
	

always_comb
begin
	/* Default to let sr1 and alumux_out to pass to ALU */
	ForwardA = 2'b00;
	ForwardB = 2'b00;
	
	
	
	/* MEM HAZARD */
	if( MEM_WB_write && ( !EX_MEM_write || (EX_MEM_dest != ID_EX_sr1)) && ( MEM_WB_dest == ID_EX_sr1))
	begin
		ForwardA = 2'b01;
	end
	if( MEM_WB_write && ( !EX_MEM_write || (EX_MEM_dest != ID_EX_sr2)) && ( MEM_WB_dest == ID_EX_sr2) && (opcode == op_add || opcode == op_and) && !bit5 )
	begin
		ForwardB = 2'b01;
	end
	
	/* EX HAZARD */
	if( EX_MEM_write && ( EX_MEM_dest == ID_EX_sr1))
	begin
		ForwardA = 2'b10;
	end
	if( EX_MEM_write && ( EX_MEM_dest == ID_EX_sr2) && (opcode == op_add || opcode == op_and) && !bit5 )
	begin
		ForwardB = 2'b10;
	end


end

endmodule: forward