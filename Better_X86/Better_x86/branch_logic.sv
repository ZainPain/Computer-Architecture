import lc3b_types::*;

module branch_logic
(
	input lc3b_opcode opcode,
	input logic branch_enable,
	input logic [2:0] pcmux_sel,
	output logic [2:0] pcmux_sel_updated,
	output logic branch_enable_true
);

always_comb
begin
	if(opcode == op_br && ~branch_enable) begin
		pcmux_sel_updated = 3'b011;	/* Don't take branch if no branch_enable is false */
												/* This will also NOT branch on NOPs */
		branch_enable_true = 0;
	end
	else if (opcode == op_br && branch_enable) begin
		pcmux_sel_updated = pcmux_sel;
		branch_enable_true = 1;
	end
	else begin
		pcmux_sel_updated = pcmux_sel; /* Let signal thru */
		branch_enable_true = 0;
	end
end

endmodule : branch_logic