import lc3b_types::*; /* Import types defined in lc3b_types.sv */

module control
(
    /* Input and output port declarations */
	 input clk,
	 
	 /* Datapath controls */
	 
	 input lc3b_opcode opcode,
	 input logic branch_enable, 
	 
	 /* Datapath Loads */
	 output logic load_pc,
	 output logic load_ir,
	 output logic load_regfile,
	 output logic load_mar,
	 output logic load_mdr,
	 output logic load_cc,
	 
	 /* Datapath mux select bits */
	 output logic pcmux_sel,
	 output logic storemux_sel,
	 output logic alumux_sel,
	 output logic regfilemux_sel,
	 output logic marmux_sel,
	 output logic mdrmux_sel,
	 
	 /*Datapth ALU */
	 output lc3b_aluop aluop,
	 
	 /* Memory signals */
	input mem_resp,
	output logic mem_read,
	output logic mem_write,
	output lc3b_mem_wmask mem_byte_enable
);

enum int unsigned {
	fetch1,
	fetch2,
	fetch3,
	decode,
	s_add,
	s_and,
	s_not,
	br,
	br_taken,
	calc_addr,
	ldr1,
	ldr2,
	str1,
	str2
	
    /* List of states */
} state, next_states;

always_comb
begin : state_actions
/* Default output assignments */
/* FIRST ALWAYS COMB */
	 /* Loads*/
	 load_pc = 1'b0;
	 load_ir = 1'b0;
	 load_regfile = 1'b0;
	 load_mar = 1'b0;
	 load_mdr = 1'b0;
	 load_cc = 1'b0;
	 
	 /* MUX Select bits */
	 pcmux_sel = 1'b0;
	 storemux_sel = 1'b0;
	 alumux_sel = 1'b0;
	 regfilemux_sel = 1'b0;
	 marmux_sel = 1'b0;
	 mdrmux_sel = 1'b0;
	 
	 aluop = alu_add;
	 
	 mem_read = 1'b0;
	 mem_write = 1'b0;
	 mem_byte_enable = 2'b11;
    /* Actions for each state */
	 case(state)
	 
		fetch1:begin
			
			/* MAR <= PC */
			marmux_sel = 1'b1;
			load_mar = 1'b1;
			
			/* PC <= PC + 2 */
			pcmux_sel = 1'b0;
			load_pc = 1'b1;
		end
		
		fetch2: begin
		
			/* Read memory */
			mem_read = 1'b1;
			mdrmux_sel = 1'b1;
			load_mdr = 1'b1;
		end
		
		fetch3:begin
			/* Load IR */
			load_ir = 1'b1;
		end
		
		decode: /* Do nothing  in terms of assignments */;
		
		s_add: begin
			/*DR <= SRA + SRB */
			aluop = alu_add;
			load_regfile = 1'b1;
			regfilemux_sel = 1'b0;
			load_cc = 1'b1;
		end
		
		s_and: begin
			/* DR <- A & B */
			aluop = alu_and;
			load_regfile = 1'b1;
			regfilemux_sel = 1'b0;
			load_cc = 1'b1;
		end
		
		s_not: begin 
			/* DR <- NOT(A) */
			aluop = alu_not;
			load_regfile = 1'b1;
			regfilemux_sel = 1'b0;
			load_cc = 1'b1;
		end
		
		br: /* Do Nothing */;
		
		br_taken: begin
			/* PC <- PC + SEXT(IR[8:0] << 1) */
			pcmux_sel = 1'b1;
			load_pc = 1'b1;
		end
		
		calc_addr: begin
			/* MAR <- A + SEXT(IR[5:0] << 1) */
			alumux_sel = 1'b1;
			aluop = alu_add;
			load_mar = 1'b1;
		end 
		
		ldr1: begin
			/* MDR <- M[MAR] */
			mdrmux_sel = 1'b1;
			load_mdr = 1'b1;
			mem_read = 1'b1;
		end
		
		ldr2: begin
			/* DR <- MDR */
			regfilemux_sel = 1'b1;
			load_regfile = 1'b1;
			load_cc = 1'b1;
		end
		
		str1: begin
			/* MDR <- SR */
			storemux_sel = 1'b1;
			aluop = alu_pass;
			load_mdr = 1'b1;
		end
		
		str2:begin
			/* M[MAR] <- MDR */
			mem_write = 1'b1;
		end
		
		default: /* Do Nothing */;
	endcase
	 
end

always_comb
begin : next_state_logic
    /* Next state information and conditions (if any)
     * for transitioning between states */
	 /* SECOND ALWAYS COMB */
	 next_states  = state;
	 case (state)
	 
		fetch1:
			next_states <= fetch2;
		
		fetch2:
			begin
				if(mem_resp == 0)
					next_states <= fetch2;
				else
					next_states <= fetch3;
			end
		fetch3:
			next_states <= decode;
		
		decode:
			begin 
				case(opcode)
				
					op_add:
						next_states <= s_add;
					
					op_and:
						next_states <= s_and;
						
					op_not:
						next_states <= s_not;
						
					op_br:
						next_states <= br;
						
					op_ldr:
						next_states <= calc_addr;
					
					op_str:
						next_states <= calc_addr;
					default: /* Do Nothing */;
					
				endcase
			end
		s_add:	
			next_states <= fetch1;
		
		s_and:
			next_states <= fetch1;
			
		s_not:
			next_states <= fetch1;
			
		br:
			begin
				if(branch_enable)
					next_states <= br_taken;
				else 
					next_states <= fetch1;
			end
		br_taken:
			next_states <= fetch1;
		
		calc_addr:
			begin
				if(opcode == op_ldr)
					next_states <= ldr1;
				else if(opcode == op_str)
					next_states <= str1;
			end
		
		ldr1:
			begin
				if(mem_resp)
					next_states <= ldr2;
				else
					next_states <= ldr1;
			end
		
		ldr2:
			next_states <= fetch1;
		
		str1:
			begin
					next_states <= str2;

			end
				
		str2:
		if(mem_resp)
			next_states <= fetch1;
		else
			next_states <= str2;
		
		endcase
	 
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
	 state <= next_states;
end

endmodule : control
