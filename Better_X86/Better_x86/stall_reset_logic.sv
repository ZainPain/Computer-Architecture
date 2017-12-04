import lc3b_types::*;

module stall_reset_logic #(parameter width = 3)
(
	input lc3b_opcode EX_MEM_opcode,
    input lc3b_opcode MEM_WB_opcode,
    input logic icache_resp,
	input logic dcache_resp,
	input logic mem_read,
	input logic mem_write,
  //input logic branch_enable_true,
  //input logic unconditional_branch,
    input logic require_reset,
    input logic hazard,
    input logic forward_load,
	input logic [1:0] counter,
	input logic [1:0] datamux_sel,
	
	output logic [1:0] datamux_sel_updated,
	output logic mem_read_updated,
	output logic mem_write_updated,
	output logic load_pc,
	output logic load_IF_ID,
	output logic load_ID_EX,
	output logic load_EX_MEM,
	output logic load_MEM_WB,
    output logic load_LDI_STI_ADDRESS,
	output logic reset_IF_ID,
	output logic reset_ID_EX,
	output logic reset_EX_MEM,
	output logic reset_MEM_WB,
	output logic reset_LDI_STI_counter
);

logic load_pipeline_reg;

always_comb
begin
	load_pc = 1;
	load_pipeline_reg = 1;
	load_LDI_STI_ADDRESS = 0;
	reset_IF_ID = 0;
	reset_ID_EX = 0;
	reset_EX_MEM = 0;
	reset_MEM_WB = 0;
	reset_LDI_STI_counter = 0;
	mem_read_updated = mem_read;
	mem_write_updated = mem_write;
	datamux_sel_updated=datamux_sel;

	/**************STALL LOGIC*************/

	/******LDI or STI SPECIFIC STALLS******/

	/* STI first iteration, stall entire pipeline and perform read */
	if ((counter == 2'b00) && EX_MEM_opcode==op_sti) begin
		load_pc = 0;
		load_pipeline_reg = 0;
		mem_write_updated=0;
		mem_read_updated=1;
        load_LDI_STI_ADDRESS = 1;
	end
	
	/* LDI first iteration, stall entire pipeline and perform read */
	else if((counter == 2'b00) && EX_MEM_opcode==op_ldi) begin
		load_pc = 0;
		load_pipeline_reg = 0;
		mem_read_updated=1;
		mem_write_updated=0;
        load_LDI_STI_ADDRESS = 1;
	end
	
	/* STI second iteration, stall entire pipeline and switch address mux
	   to perform write to address that was read in last iteration */
	else if ((counter == 2'b01) && EX_MEM_opcode==op_sti) begin
		load_pc = 0;
		load_pipeline_reg = 0;
		mem_write_updated=1;
		mem_read_updated=0;
		datamux_sel_updated=2'b00;
	end
	
	/* LDI second iteration, stall entire pipeline and switch address mux
	   to perform read from address that was read in last iteration */
	else if((counter == 2'b01) &&EX_MEM_opcode==op_ldi) begin
		load_pc = 0;
		load_pipeline_reg = 0;
		mem_read_updated=1;
		mem_write_updated=0;
		datamux_sel_updated=2'b00;
	end
	
	/* STI completed, let pipeline continue, reset LDI & STI counter */
	else if ((counter == 2'b10) && EX_MEM_opcode==op_sti) begin
		load_pc = 1;
		load_pipeline_reg =1;
		mem_write_updated=1;
		mem_read_updated=0;
		datamux_sel_updated=2'b00;
		reset_LDI_STI_counter = 1;
	end
	
	/* LDI completed, let pipeline continue, reset LDI & STI counter */
	else if((counter == 2'b10) && EX_MEM_opcode==op_ldi) begin
		load_pc = 1;
		load_pipeline_reg =1;
		mem_read_updated=1;
		mem_write_updated=0;
		datamux_sel_updated=2'b00;
		reset_LDI_STI_counter = 1;
	end

	/********ENTIRE PIPELINE STALLS*********/
	
	/* Stall all pipeline registers if D-Cache misses */
	else if (!dcache_resp && (mem_read || mem_write)) begin
		load_pc = 0;
		load_pipeline_reg = 0;
	end

	/************ONLY PC STALLS************/

	/* Stall PC if 
	   1) I-Cache misses or 
	   2) hazard detected and there is no branch or unconditional_branch or 
	   3) if pipeline is stalled and there is no branch or unconditional branch
	      being taken */
	if (!icache_resp || !((forward_load && load_pipeline_reg) || require_reset))//branch_enable_true || unconditional_branch))
		load_pc = 0;

	/*********ASSIGN LOAD SIGNALS**********/

	/* Load IF_ID if all pipeline registers are loading and there are no
	   hazards detected */
	load_IF_ID = load_pipeline_reg && forward_load;
	
	/* Load ID_EX and EX_MEM if all pipeline registers are loading */
	load_ID_EX = load_pipeline_reg;
	load_EX_MEM = (load_pipeline_reg && (~require_reset	|| (require_reset && icache_resp)));

	/* Load MEM_WB if all pipeline registers are loading and
	   1) OPCODE is not branch and there is no unconditional branch or
	   2) There is no branch taken
	   3) There is a branch taken or an unconditoinal branch and I-Cache is not
	      stalled */

	//Probably dont need to check opcode since not branch enable true takes care of it
	/*load_MEM_WB = (load_pipeline_reg 
		&& ((MEM_WB_opcode != op_br && ~unconditional_branch) 
			|| (~branch_enable_true && ~unconditional_branch) 
			|| ((branch_enable_true || unconditional_branch) && icache_resp))); */
	load_MEM_WB = load_pipeline_reg;

	/**************RESET LOGIC*************/

	/* Reset IF_ID 
	   1) immediately when a branch is taken or 
	   2) when PC is not loading and other pipeline registers are loading
	      (to insert NOPS essentially) and there is no hazard detected */
	if (require_reset || (!load_pc && load_pipeline_reg && !hazard))
		reset_IF_ID = 1;

	/* Reset ID_EX and EX_MEM immediately when a branch is taken */
	if (require_reset) begin
		reset_ID_EX = 1;
		//reset_EX_MEM = 1;
	end

	if (icache_resp && load_pipeline_reg && require_reset)
		reset_EX_MEM = 1;

	/* Reset MEM_WB when I-Cache is responding and a branch is taken */
	//if (icache_resp && (branch_enable_true || unconditional_branch))
	//	reset_MEM_WB = 1;

end

endmodule : stall_reset_logic