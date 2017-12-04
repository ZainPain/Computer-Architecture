import lc3b_types::*;

module IF_ID_reg
(
	input clk,
	input load,
	input reset,

	input lc3b_word inst_in,
	input lc3b_word pc_in,
  
  input btb_speculatively_taken_in,
  input [1:0] pht_prediction_out_in,
	input [9:0]pht_index_out_in,
	output lc3b_word inst_out,	/* Maybe for debugging purpose only */
	output lc3b_word pc_out,

	output lc3b_offset6 offset6,
	output lc3b_imm5 imm5,
	output lc3b_imm4 imm4,
	output lc3b_trapvect8 trap_vect8,
	output lc3b_offset11 offset11,
	output lc3b_offset9 offset9,

	output lc3b_reg dest,
	output lc3b_reg sr1,
	output lc3b_reg sr2,
  
  output logic btb_speculatively_taken_out,
  output logic [1:0] pht_prediction_out_out,
	output logic [9:0]pht_index_out_out,
	/* Signals for control rom*/
	output lc3b_opcode opcode,
	output logic ir11,
	output logic ir5,
	output logic ir4
);

// internal registers
lc3b_word pc_value;
lc3b_word instruction;
logic btb_speculatively_taken;
logic [1:0] pht_prediction_out;
logic [9:0]pht_index_out;
initial
begin
	pc_value = 16'd0;
	instruction = 16'd0;
  btb_speculatively_taken = 0;
  pht_prediction_out = 0;
  pht_index_out = 0;
end

always_ff @(posedge clk)
begin
	if(load && ~reset)
	begin
		pc_value = pc_in;
		instruction = inst_in;
    btb_speculatively_taken = btb_speculatively_taken_in;
    pht_prediction_out = pht_prediction_out_in;
    pht_index_out = pht_index_out_in;
	end

	else if(reset)
	begin
		pc_value = 16'd0;
		instruction = 16'd0;
    btb_speculatively_taken = 0;
    pht_prediction_out = 0;
    pht_index_out = 0;
	end
end

always_comb
begin
	pc_out = pc_value;
	inst_out = instruction;
	offset6 = instruction[5:0];
	imm5 = instruction[4:0];
	imm4 = instruction[3:0];
	trap_vect8 = instruction[7:0];
	offset11 = instruction[10:0];
	if(instruction[15:12] == op_jsr || instruction[15:12] == op_trap)
	begin
		dest = 3'b111;
	end
	else
	begin
		dest = instruction[11:9];
	end
	
	sr1 = instruction[8:6];
	sr2 = instruction[2:0];
	opcode = lc3b_opcode'(instruction[15:12]);
	ir11 = instruction[11];
	ir5 = instruction[5];
	ir4 = instruction[4];
	offset9 = instruction[8:0];
  
  btb_speculatively_taken_out = btb_speculatively_taken;
  pht_prediction_out_out = pht_prediction_out;
  pht_index_out_out = pht_index_out;
end

endmodule : IF_ID_reg
