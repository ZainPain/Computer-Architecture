import lc3b_types::*;

module forward
(
	input lc3b_opcode ID_EX_opcode,
	input lc3b_opcode EX_MEM_opcode,
	input logic bit5,
	input lc3b_reg ID_EX_sr1,
	input lc3b_reg ID_EX_sr2,
	input lc3b_reg IF_ID_EX_dest,
	input logic ID_EX_mem_write,
	input logic EX_MEM_reg_write,
	input logic MEM_WB_reg_write,
	input logic EX_MEM_mem_write,
	
	input lc3b_reg EX_MEM_dest,
	input lc3b_reg MEM_WB_dest,
	
	input writemux_sel,
	
	output logic [1:0] ForwardA,
	output logic [1:0] ForwardB,
	output logic writemux_sel_updated,
	output logic EX_MEM_mux_sel,
	output logic sr2mux_sel
		
);

/* Before forwarding, we must first verify that the operands are indeed correct for forwarding ( this means that there is a valid sr1 and sr2 in the instruction and it isnt using offset values).
	there are only two instructions that use both SR1 and SR2 in calculation of their destination addresses. (ADD and AND).
	This should take opcode and bit 6 to verify AND and ADD*/
	

always_comb
begin
	/* Default to let sr1 and alumux_out to pass to ALU */
	ForwardA = 2'b00;
	ForwardB = 2'b00;
	writemux_sel_updated = 1'b0;
	sr2mux_sel = 1'b0;
	EX_MEM_mux_sel = 1'b0;
	
	if(EX_MEM_opcode == op_lea)
		EX_MEM_mux_sel = 1'b1;
	/* MEM HAZARD */
	if( MEM_WB_reg_write && ( !EX_MEM_reg_write || (EX_MEM_dest != ID_EX_sr1)) && ( MEM_WB_dest == ID_EX_sr1))
	begin
		ForwardA = 2'b01;
	end
	if( MEM_WB_reg_write && ( !EX_MEM_reg_write || (EX_MEM_dest != ID_EX_sr2)) && ( MEM_WB_dest == ID_EX_sr2) && (ID_EX_opcode == op_add || ID_EX_opcode == op_and) && !bit5 )
	begin
		ForwardB = 2'b01;
	end
	
	/* EX HAZARD */
	if( EX_MEM_reg_write && ( EX_MEM_dest == ID_EX_sr1) )
	begin
		ForwardA = 2'b10;
	end
	if( EX_MEM_reg_write && ( EX_MEM_dest == ID_EX_sr2) && (ID_EX_opcode == op_add || ID_EX_opcode == op_and) && !bit5  )
	begin
		ForwardB = 2'b10;
		
	end
	
	/* WB -> MEM (STORE) */
	if(EX_MEM_mem_write && (MEM_WB_dest == EX_MEM_dest) && MEM_WB_reg_write)
	begin

			writemux_sel_updated = 1'b1;	
	end
	
	if((MEM_WB_dest == IF_ID_EX_dest) && ID_EX_mem_write && MEM_WB_reg_write)
	begin
		sr2mux_sel = 1'b1;
	end
	
end

endmodule: forward