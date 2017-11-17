import lc3b_types::*;

module staller #(parameter width = 3)
(
	input lc3b_opcode op_code,
	input logic resp,
	input logic mem_read,
	input logic mem_write,
	input logic [1:0] counter,
	input logic [1:0] datamux_sel,
	
	output logic [1:0] datamux_sel_updated,
	output logic mem_read_updated,
	output logic mem_write_updated,
	output logic load,
	output logic reset_counter

);

always_comb
begin
	if ((counter == 2'b00) && op_code==op_sti) begin
		load=0;
		mem_write_updated=0;
		mem_read_updated=1;
		datamux_sel_updated=datamux_sel;
		reset_counter = 0;
	end
	
	else if((counter == 2'b00) && op_code==op_ldi) begin
		load=0;
		mem_read_updated=1;
		mem_write_updated=0;
		datamux_sel_updated=datamux_sel;
		reset_counter = 0;
	end
	
	else if ((counter == 2'b01) && op_code==op_sti) begin
		load=1;
		mem_write_updated=1;
		mem_read_updated=0;
		datamux_sel_updated=2'b00;
		reset_counter = 1;
	end
	
	else if((counter == 2'b01) &&op_code==op_ldi) begin
		load=1;
		mem_read_updated=1;
		mem_write_updated=mem_write;
		datamux_sel_updated=2'b00;
		reset_counter = 1;
	end
	
	else if ((counter == 2'b10) && op_code==op_sti) begin
		load=1;
		mem_write_updated=0;
		mem_read_updated=0;
		datamux_sel_updated=2'b00;
		reset_counter = 1;
	end
	
	else if((counter == 2'b10) && op_code==op_ldi) begin
		load=1;
		mem_read_updated=0;
		mem_write_updated=0;
		datamux_sel_updated=2'b00;
		reset_counter = 1;
	end
	
	else if (!resp && (mem_read || mem_write)) begin
		mem_read_updated=mem_read;
		mem_write_updated=mem_write;
		datamux_sel_updated=datamux_sel;
		load = 0;
		reset_counter = 0;
	end
	
	else begin
		mem_read_updated=mem_read;
		mem_write_updated=mem_write;
		datamux_sel_updated=datamux_sel;
		load = 1;
		reset_counter = 0;
	end
end

endmodule : staller