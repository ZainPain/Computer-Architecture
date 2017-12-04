import lc3b_types::*;

module BHR
(
	input clk,
	input branch,
  input lc3b_opcode opcode,
  input lc3b_reg nzp,
	output logic [3:0] BHR_out
);

/* GLOBAL BRANCH HISTORY REGISTER */
logic [3:0] branch_history;

initial
begin
	branch_history = 4'h0;
end

always_ff @(negedge clk)
begin
  if(opcode == op_br && (nzp[2] || nzp[1] || nzp[0]))
  begin
    if(branch)
      branch_history = {branch_history[2:0], 1'b1}; //(branch_history << 1) || 4'h0001;	// shift bits left by 1 bit and add 1 if branch was taken
    else
      branch_history = {branch_history[2:0], 1'b0};	// shift left by one bit and add 0 to bhr if branch was NOT taken
  end
end

always_comb
begin
	BHR_out = branch_history;
end

endmodule : BHR
