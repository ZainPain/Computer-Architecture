import lc3b_types::*;
module control_rom
(
	input lc3b_opcode opcode,
	input logic bit11,
	input logic bit5,
	input logic bit4,
	output lc3b_control_word ctrl
	
);
always_comb
begin
	// alumux_sel should be 2'b00 which allows sr2_out to be passed to alu
	// store_mux_sel should be 1'b0 which allows sr1 to be passed into regfile
	ctrl.opcode = opcode;
    ctrl.aluop = alu_add;
    ctrl.load_cc = 1'b0;
    ctrl.load_regfile = 1'b0;
    ctrl.addermux_sel = 1'b0;
    ctrl.regfilemux_sel = 3'b100;
    ctrl.ldbmux_sel = 1'b0;
    ctrl.pcmux_sel = 2'b11;
    ctrl.mem_read = 1'b0;
    ctrl.mem_write = 1'b0;
    ctrl.alumux_sel = 3'b00;
    ctrl.storemux_sel = 1'b0;
    ctrl.datamux_sel = 2'b10; /* ALU_OUT */
	 ctrl.writemux_sel = 1'b0;
	/* These signals should be high unless if we want to stall pipeline */
    ctrl.load_IF_ID = 1'b1;
    ctrl.load_ID_EX = 1'b1;
	ctrl.load_EX_MEM = 1'b1;
    ctrl.load_MEM_WB = 1'b1;
	ctrl.load_pc = 1'b1;
	 
	case(opcode)
		
		op_add:begin
		/* NOTE: all these signals must propagate to MEM/WB */				/* LOOKS GOOD */
			/* storemux default to allow sr2 */
			/* alumux default to allow sr2_out */
			/* aluop default to ADD */
			/* regfile_mux defaults to alu_out */
			ctrl.load_regfile = 1'b1;
			ctrl.load_cc = 1'b1;
			
			// ADD IMMEDIATE
			if(bit5)
			begin
				// alu_mux_sel is set to allow SEXT5 to pass to ALU
				ctrl.alumux_sel = 3'b011;
			end

		end
		
		op_and:begin
		/* NOTE: all these signals must propagate to MEM/WB */				/* LOOKS GOOD */
			/* storemux default to allow sr2 */
			/* alumux default to allow sr2_out */
			/* regfile_mux defaults to alu_out */
			ctrl.aluop = alu_and;
			ctrl.load_regfile = 1'b1;
			ctrl.load_cc = 1'b1;
			
			//AND IMMEDIATE
			if(bit5)
			begin	
				//passing SEXT5 to ALU
				ctrl.alumux_sel = 3'b011;
			end

		end
		
		op_not:begin
		/* NOTE: all these signals must propagate to MEM/WB */				/* LOOKS GOOD */
			/* storemux default to allow sr2 */
			/* regfile_mux defaults to alu_out */
			ctrl.aluop = alu_not;
			ctrl.load_regfile = 1'b1;
			ctrl.load_cc = 1'b1;
		end
		
		op_ldr:begin  /* memword[BaseR + (SEXT(6)<<1)]*/
		/* NOTE: all these signals must propagate to MEM/WB */				/* LOOKS GOOD */
			/* storemux default to allow sr2 */
			/* datamux_sel defaults to allow alu_out to access D-mem */
			
			ctrl.load_regfile = 1'b1; 
			ctrl.load_cc = 1'b1;
			
			/* regfilemux must allow mem_rdata to be loaded to register */
			ctrl.regfilemux_sel = 3'b001;
			
			// allowing ADJ6 to pass to ALU
			ctrl.alumux_sel = 3'b010;
			ctrl.mem_read = 1'b1;
			
	
		end
		
		op_str:begin  /* memWord[BaseR + Sext(6)<<1)] = SR */
		/* NOTE: all these signals must propagate to MEM/WB */				/* LOOKS GOOD */
			/* storemux default to allow sr2 */
			/* datamux_sel defaults to allow alu_out to access D-mem */
			
			ctrl.storemux_sel = 1'b1;
			// allowing ADJ6 to pass to ALU
			ctrl.alumux_sel = 3'b010;
			ctrl.mem_write = 1'b1;
			
		end
		
		op_br:begin
		/* NOTE: LOAD_PC should generally always be high unless we are stalling the pipeline */
																								/* LOOKS OKAY FOR NOW, MIGHT NEED TO FIX SOMETHING */
			ctrl.addermux_sel = 1'b0; // adj9 + pc
			ctrl.pcmux_sel = 2'b01;	// pcmux_out = addermux_out

			
		end


		
		// NOTE: required for cp 3.2+

		op_jmp:begin			/* WORKS ON TESTCODE I WROTE */
		/* NOTE: PC = BaseR */
			/* BaseR = IR[8:6] which requires SR1 portion of instruction. */
			/* SR1 -> ALU_OUT -> PCMUX -> PC */
			ctrl.aluop = alu_pass;
			ctrl.pcmux_sel = 3'b100; 

		end
		
		op_jsr:begin	/* JSR AND JSRR WORKS */
			/* R7 = PC */						
			ctrl.regfilemux_sel = 3'b011;
			ctrl.load_regfile = 1'b1;

			/* JSR */
			if(bit11) /*  PC = PC + ( SEXT(PCoffset11) << 1) */
			begin
				ctrl.addermux_sel = 1'b1;
				ctrl.pcmux_sel = 3'b001;
			end
			
			/* JSRR */
			else	
			begin	/* PC = BaseR*/

				ctrl.aluop = alu_pass;
				ctrl.pcmux_sel = 3'b100;
			end
		end
		

		
		op_ldb:begin	/* LDB WORKS IN THE TESTCASE I WROTE */

			ctrl.load_cc = 1'b1;
			ctrl.load_regfile = 1'b1;
			ctrl.mem_read = 1'b1;
			ctrl.alumux_sel = 3'b001; /* SEXT6 */
			ctrl.regfilemux_sel = 3'b000; /*  LDB_mux_out */


		end
		
		op_ldi:begin	/* TO DO */
			ctrl.load_regfile = 1'b1; 
			ctrl.load_cc = 1'b1;
			
			/* regfilemux must allow mem_rdata to be loaded to register */
			ctrl.regfilemux_sel = 3'b001;
			
			// allowing ADJ6 to pass to ALU
			ctrl.alumux_sel = 3'b010;
			ctrl.mem_read = 1'b1;		
		end
		
		op_lea:begin
			/* DR = PC + (SEXT(offset9) << 1) */			/* WORKS ON TESTCODE I WROTE */

			/*addermud_sel set to default to (SEXT(offset9) << 1) */
			ctrl.load_cc = 1'b1;
			ctrl.load_regfile = 1'b1;
			ctrl.regfilemux_sel = 3'b010; /* pc+adder_out */

		end
		
		op_shf:begin	/* WORKS ON TESTCODE THAT I WROTE */

			ctrl.regfilemux_sel = 3'b100; /* DR = ALU_OUT */
			ctrl.alumux_sel = 3'b100;  /*SEXT4 */
			ctrl.load_cc = 1'b1;
			ctrl.load_regfile = 1'b1;

			if(bit4)
			begin

				if(bit5) /* RSHFL right shift logical*/
					ctrl.aluop = alu_sra;
				else
					ctrl.aluop = alu_srl;
			end

			else
				ctrl.aluop = alu_sll;
			
		end
		
		
		op_stb:begin
			ctrl.writemux_sel = 1'b1;
			ctrl.storemux_sel = 1'b1;
			ctrl.alumux_sel = 3'b001;
			ctrl.mem_write  = 1'b1;
			/* Datamux should be outputinng alu_out by default */
			

		end
		
		op_sti:begin	/* TO DO */
			ctrl.alumux_sel = 3'b010;
			ctrl.mem_read = 1'b1;
			ctrl.storemux_sel = 1'b1;
		end
		
		op_trap:begin				/* WORKS ON TESTCODE I WROTE */
			/* R7 = PC */
			ctrl.regfilemux_sel = 3'b011;
			ctrl.load_regfile = 1'b1;
			/* PC = memWord[zext(trapvect8) << 1] */
			ctrl.datamux_sel = 2'b01;
			ctrl.mem_read = 1'b1;
			ctrl.pcmux_sel = 3'b010;
			
		end

		default: /* Nothing */;
		endcase

end

endmodule : control_rom
