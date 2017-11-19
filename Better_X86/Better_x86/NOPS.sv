import lc3b_types::*;

module NOPS
(
	output lc3b_control_word zero_signal
);
lc3b_control_word signal;
always_comb
begin
	signal.opcode = op_br;
   signal.aluop = alu_add;
	 
   signal.load_cc = 1'b0;
   signal.load_regfile = 1'b0;
	 
   signal.addermux_sel = 1'b0;
   signal.regfilemux_sel = 3'b000;
   signal.ldbmux_sel = 1'b0;
	signal.datamux_sel = 2'b00;
	signal.pcmux_sel = 3'b000;
	signal.alumux_sel = 3'b000;
	signal.writemux_sel = 1'b0;
   signal.storemux_sel = 1'b0;
   signal.mem_read = 1'b0;
   signal.mem_write = 1'b0;
	zero_signal = signal;
end
endmodule : NOPS
