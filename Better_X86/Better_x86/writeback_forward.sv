import lc3b_types::*;

module writeback_forward
(
	input lc3b_control_word MEM_WB_ctrl,
	output logic [1:0] writeback_mux_sel
);

always_comb
begin
	if(MEM_WB_ctrl.mem_read && MEM_WB_ctrl.load_regfile)
		writeback_mux_sel = 2'b01;
	else if(MEM_WB_ctrl.opcode == op_lea && MEM_WB_ctrl.load_regfile)
		writeback_mux_sel = 2'b10;
	else
		writeback_mux_sel = 2'b00;
	
end

endmodule : writeback_forward