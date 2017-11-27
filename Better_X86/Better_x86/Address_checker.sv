import lc3b_types::*;

module address_checker
(
	input lc3b_word address,
	input mem_read,
	input mem_write,
	output logic mem_read_update,
	output logic mem_write_update,
	output logic MMIO_read,
	output logic MMIO_write,
	output logic [3:0] counter_address,
	output logic memoryout_sel
);

always_comb
begin
	mem_read_update = mem_read;
	mem_write_update = mem_write;
	MMIO_read = 1'b0;
	MMIO_write = 1'b0;
	memoryout_sel = 1'b0;
	
	if(address >= 16'hFFF0)
	begin
		MMIO_read = mem_read;
		MMIO_write = mem_write;
		mem_read_update = 1'b0;
		mem_write_update = 1'b0;
		memoryout_sel = 1'b1;
	end
	
	counter_address = address[3:0];
end

endmodule : address_checker