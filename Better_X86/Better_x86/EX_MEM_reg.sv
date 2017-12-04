import lc3b_types::*;

module EX_MEM_reg
(
	input clk,
	input load,
	input reset,

	input lc3b_word inst_in,	/* Maybe for debugging purpose only */
	input lc3b_word pc_in,

	input lc3b_control_word control_in,
	input lc3b_word alu_out_in,
	input lc3b_word sr2_in,	/* Instead of SR1 use SR2 for SR purpose in ISA */
	input lc3b_reg dest_in,
	input lc3b_word trap_vect8_in,

	input lc3b_word branch_address_in,
  input btb_speculatively_taken_in,
  input [9:0]pht_index_out_in,
  input [1:0] pht_prediction_out_in,

	output lc3b_word inst_out,	/* Maybe for debugging purpose only */
	output lc3b_word pc_out,

	output lc3b_control_word control_out,
	output lc3b_word alu_out_out,
	output lc3b_word sr2_out, /* Instead of SR1 use SR2 for SR purpose in ISA */
	output lc3b_reg dest_out,
	output lc3b_word trap_vect8_out,

	output lc3b_word branch_address_out,
  output logic btb_speculatively_taken_out,
  output logic [9:0]pht_index_out_out,
  output logic [1:0] pht_prediction_out_out
);

lc3b_control_word control;

lc3b_word instruction;
lc3b_word pc_value;
lc3b_word alu_value;
lc3b_word sr2;
lc3b_word branch_address;
lc3b_reg dest;
lc3b_word trap_vect8;

logic btb_speculatively_taken;
logic [9:0]pht_index_out;
logic [1:0] pht_prediction_out;
initial
begin
	control = 0;
	instruction = 16'd0;
	pc_value = 16'd0;
	alu_value = 16'd0;
	sr2 = 16'd0;
	branch_address = 16'd0;
	dest = 3'd0;
	trap_vect8 = 16'd0;
  btb_speculatively_taken = 0;
  pht_index_out = 0;
  pht_prediction_out = 0;
end

always_ff @(posedge clk)
begin
	if(load && ~reset)
	begin
		control = control_in;
		instruction = inst_in;
		pc_value = pc_in;
		alu_value = alu_out_in;
		sr2 = sr2_in;
		branch_address = branch_address_in;
		dest = dest_in;
		trap_vect8 = trap_vect8_in;
    btb_speculatively_taken = btb_speculatively_taken_in;
    pht_index_out = pht_index_out_in;
    pht_prediction_out = pht_prediction_out_in;
	end

	else if(reset)
	begin
		control = 0;
		instruction = 16'd0;
		pc_value = 16'd0;
		alu_value = 16'd0;
		sr2 = 16'd0;
		branch_address = 16'd0;
		dest = 3'd0;
		trap_vect8 = 16'd0;
    btb_speculatively_taken = 0;
    pht_index_out = 0;
    pht_prediction_out = 0;
	end
end

always_comb
begin
	inst_out = instruction;
	pc_out = pc_value;
	control_out = control;
	alu_out_out = alu_value;
	sr2_out = sr2;
	branch_address_out = branch_address;
	dest_out = dest;
	trap_vect8_out = trap_vect8;
  btb_speculatively_taken_out = btb_speculatively_taken;
  pht_index_out_out = pht_index_out;
  pht_prediction_out_out = pht_prediction_out;
end
endmodule : EX_MEM_reg
