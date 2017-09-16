import lc3b_types::*; /* Import types defined in lc3b_types.sv */

module control
(
    /* Input and output port declarations */
	 input clk,
	 
	 /* Datapath controls */
	 
	 input lc3b_opcode opcode,
	 input logic branch_enable, 
	 input logic imm,	/* bit5 */
	 input logic bit11,
	 input logic bit4,
	 input lc3b_word alu_out,
				
	 /* Datapath Loads */
	 output logic load_pc,
	 output logic load_ir,
	 output logic load_regfile,
	 output logic load_mar,
	 output logic load_mdr,
	 output logic load_cc,
	 output logic mask_enable,
	 output logic truncate,
	 output logic shift,
	 /* Datapath mux select bits =*/
	 output logic [1:0] pcmux_sel,
	 output logic storemux_sel,
	 output logic [1:0] alumux_sel,
	 output logic [1:0] regfilemux_sel,
	 output logic [1:0]marmux_sel,
	 output logic mdrmux_sel,
	 output logic adjmux_sel,
	 
	 /*Datapth ALU */
	 output lc3b_aluop aluop,
			output lc3b_aluop aluop_imm,
			
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
	str2,
	jmp,
	lea,
	jsr1,
	jsr2,
	ldb1,
	ldb2,
	ldi1,
	ldi2,
	ldi3,
	ldi4,
	shf,
	lshf,
	rshfl,
	rshfa,
	stb1_odd,
	stb1_even,
	stb2_odd,
	stb2_even
	
	
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
	 shift = 1'b0;
	 /* MUX Select bits */
	 pcmux_sel = 1'b0;
	 storemux_sel = 1'b0;
	 alumux_sel = 1'b00;
	 regfilemux_sel = 2'b00;
	 marmux_sel = 1'b0;
	 mdrmux_sel = 1'b0;
	 adjmux_sel = 1'b0;
	 mask_enable = 1'b0;
	 truncate = 1'b0;
	 aluop = alu_add;
	 aluop_imm = alu_pass;
	 
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
			if(imm)
				begin
					aluop = alu_pass;
					aluop_imm = alu_add;
					load_regfile = 1'b1;
					regfilemux_sel = 2'b00;
					load_cc = 1'b1;
				end
			else 
				begin
					aluop = alu_add;
					load_regfile = 1'b1;
					regfilemux_sel = 2'b00;
					load_cc = 1'b1;
				end
			end
		
		s_and: begin
			/* DR <- A & B */
			if(imm)
				begin
					aluop = alu_pass;
					aluop_imm = alu_and;
					load_regfile = 1'b1;
					regfilemux_sel = 2'b00;
					load_cc = 1'b1;
					
				end
			else
				begin
					aluop = alu_and;
					load_regfile = 1'b1;
					regfilemux_sel = 2'b00;
					load_cc = 1'b1;
				end
		end
		
		s_not: begin 
			/* DR <- NOT(A) */
			aluop = alu_not;
			load_regfile = 1'b1;
			regfilemux_sel = 2'b00;
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
			if(opcode == op_ldb || opcode == op_stb)
				begin
					adjmux_sel = 1'b1;
				end
			alumux_sel = 2'b01;
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
			regfilemux_sel = 2'b01;
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
		
		jmp:
			begin
				load_pc = 1'b1;
				pcmux_sel = 2'b10;
			end
			
		lea:
			begin
				load_regfile = 1'b1;
				regfilemux_sel = 2'b10;
				load_cc = 1'b1;
			end
		jsr1:
			begin
				load_regfile = 1'b1;
				regfilemux_sel = 2'b11;
				pcmux_sel = 2'b11;
			end
			
		jsr2:
			begin
				load_pc = 1'b1;
				if(bit11 == 1'b0) /* PC = BaseR*/
					pcmux_sel = 2'b10;
				else				/* PC = PC + Offset11 << 1 */
					pcmux_sel = 2'b11;
			end
			
		ldb1:
			begin
					mdrmux_sel = 1'b1;
					load_mdr = 1'b1;
					mem_read = 1'b1;
					alumux_sel = 2'b01;
					adjmux_sel = 1'b1;
			end
			
		ldb2:
			begin
				alumux_sel = 2'b01;
				adjmux_sel = 1'b1;
				regfilemux_sel = 2'b01;
				load_regfile = 1'b1;
				load_cc = 1'b1;
				mask_enable = 1'b1;
			end
			
		ldi1: begin
			/* MDR <- M[MAR] */
			mdrmux_sel = 1'b1;
			load_mdr = 1'b1;
			mem_read = 1'b1;
		end
		
		ldi2: begin
			/* DR <- MDR */
			marmux_sel = 2'b10;
			load_mar = 1'b1;
		end
		
		ldi3: begin
			mdrmux_sel = 1'b1;
			load_mdr = 1'b1;
			mem_read = 1'b1;
		end
		
		ldi4: begin
			regfilemux_sel = 2'b01;
			load_regfile = 1'b1;
			load_cc = 1'b1;
			mask_enable = 1'b0;
			
		end
		
		shf: /* Do nothing */
		
		lshf: begin
			alumux_sel = 2'b10;
			aluop = alu_sll;
			load_cc = 1'b1;
			load_regfile = 1'b1;
		end
		
		rshfl: begin
			alumux_sel = 2'b10;
			aluop = alu_srl;
			load_cc = 1'b1;
			load_regfile = 1'b1;
		end
		
		rshfa: begin
			alumux_sel = 2'b10;
			aluop = alu_sra; 
			load_cc = 1'b1;
			load_regfile = 1'b1;
		end
		
		stb1_odd: begin
			shift = 1'b1;
			truncate = 1'b1;
			storemux_sel = 1'b1;
			aluop = alu_pass;
			load_mdr = 1'b1;
			
		end
		
		stb1_even: begin
			truncate = 1'b1;
			storemux_sel = 1'b1;
			aluop = alu_pass;
			load_mdr = 1'b1;
			
		end
		
		stb2_odd: begin
			mem_write = 1'b1;
			mem_byte_enable = 2'b10;
			//mem_byte_enable
		end
		
		stb2_even: begin
			mem_write = 1'b1;
			mem_byte_enable = 2'b01;
			//mem_byte_enable
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
						
					op_jmp:
						next_states <= jmp;
						
					op_lea:
						next_states <= lea;
						
					op_jsr:
						next_states <= jsr1;
						
					op_ldb:
						next_states <= calc_addr;
					
					op_ldi:
						next_states <= calc_addr;
						
					op_shf:
						next_states <= shf;
					
					op_stb:
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
					
				else if(opcode ==  op_ldi)
					next_states <= ldi1;
					
				else if(opcode == op_str)
					next_states <= str1;
					
				else if (opcode == op_ldb)
					next_states <= ldb1;
					
				else if(opcode == op_stb)
					begin
						if(alu_out[0] == 1'b0)
							next_states <= stb1_even;	
						else
							next_states <= stb1_odd;
					end
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
			begin
				if(mem_resp)
					next_states <= fetch1;
				else
					next_states <= str2;
			end
			
		jmp:
			next_states <= fetch1;
			
		lea:
			next_states <= fetch1;
			
		jsr1:
			next_states <= jsr2;
			
		jsr2:
			next_states <= fetch1;
			
		ldb1:
			begin
				if(mem_resp)
					next_states <= ldb2;
				else
					next_states <= ldb1;
			end
		ldb2:
			next_states <= fetch1;
		
		ldi1: begin
			if(mem_resp)
				next_states <= ldi2;
			else
				next_states <= ldi1;
		end
		
		ldi2:
			next_states <= ldi3;
		
		ldi3:
			if(mem_resp)
				next_states <= ldi4;
			else
				next_states <= ldi3;
		ldi4:
			next_states <= fetch1;
			
		shf: begin
			if(bit4 == 0) 
				begin
					next_states <= lshf;
				end
			
			else
				begin
					if(imm)	/* where imm = bit5 = A */
						next_states <= rshfa;
					else
						next_states <= rshfl;
				end
		end
		
		lshf: begin
			next_states <= fetch1;
		end
		
		rshfl: begin
			next_states <= fetch1;
		end
		
		rshfa: begin
			next_states <= fetch1;
		end
		
		stb1_even: begin
			next_states <= stb2_even;
		
		end
		
		stb1_odd: begin
			next_states <= stb2_odd;
		
		end
		
		stb2_odd: begin
				if(mem_resp)
					next_states <= fetch1;
				else
					next_states <= stb2_odd;
		end
		
		stb2_even: begin
				if(mem_resp)
					next_states <= fetch1;
				else
					next_states <= stb2_even;
		end
		endcase
	 
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
	 state <= next_states;
end

endmodule : control
