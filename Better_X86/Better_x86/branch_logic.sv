import lc3b_types::*;

module branch_logic
(
	input lc3b_opcode opcode,
	input logic branch_enable,
	input logic [2:0] pcmux_sel,
	output logic [2:0] pcmux_sel_updated,
	output logic branch_enable_true,
  output logic unconditional_branch,
  input logic speculatively_taken,
  input logic incorrect_target,
  output logic require_reset,
  
  input logic branch_predictor_taken_and_btb_valid,
  output logic [1:0] btb_target_mux_sel,
  output logic incorrectly_taken,
  output logic incorrectly_not_taken
);

logic correctly_taken;
//logic incorrectly_taken;
logic correctly_not_taken;
//logic incorrectly_not_taken;


always_comb
begin
  require_reset = 0;
  unconditional_branch = opcode == op_jsr || opcode == op_trap || opcode == op_jmp;
  btb_target_mux_sel = 2'b0;
  
  pcmux_sel_updated = pcmux_sel; /* Let signal thru */
  branch_enable_true = 0;
  
	if(opcode == op_br && ~branch_enable) begin
		//pcmux_sel_updated = 3'b011;	// Don't take branch if no branch_enable is false 
                                //This will also NOT branch on NOPs 
		branch_enable_true = 0;
	end
	else if (opcode == op_br && branch_enable) begin
		branch_enable_true = 1;
	end
  
  correctly_taken = speculatively_taken && branch_enable && (opcode == op_br);
  incorrectly_taken = speculatively_taken && !branch_enable && (opcode == op_br);
  correctly_not_taken = !speculatively_taken && !branch_enable && (opcode == op_br);
  incorrectly_not_taken = !speculatively_taken && branch_enable && (opcode == op_br);
  
  if (incorrectly_not_taken && !(unconditional_branch && incorrect_target)) begin
    require_reset = 1;
    pcmux_sel_updated = 3'b001;
    btb_target_mux_sel = 2'b00;
  end
  
  else if (incorrectly_taken && !(unconditional_branch && incorrect_target)) begin
    require_reset = 1;
    pcmux_sel_updated = 3'b110;
  end
  
  else if (unconditional_branch && (incorrect_target || !speculatively_taken)) begin
    require_reset = 1;
    pcmux_sel_updated = pcmux_sel;
    
    unique case(opcode)
      op_jmp: btb_target_mux_sel = 2'b10;
      op_jsr: begin
        if (pcmux_sel == 3'b001)
          btb_target_mux_sel = 2'b0;
        else
          btb_target_mux_sel = 2'b10;
      end
      op_trap: btb_target_mux_sel = 2'b01;
      default: ;
     endcase
  end
  
  else if (correctly_taken) begin
    pcmux_sel_updated = 3'b011;
    btb_target_mux_sel = 2'b0;
  end
  
  else if (correctly_not_taken)
    pcmux_sel_updated = 3'b011;
  
  if (!require_reset && branch_predictor_taken_and_btb_valid)
    pcmux_sel_updated = 3'b101;
  
end

endmodule : branch_logic