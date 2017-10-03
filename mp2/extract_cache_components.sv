import lc3b_types::*; /* Import types defined in lc3b_types.sv */

module components
(
	input lc3b_word mem_address,
	output lc3b_tag tag,
	output lc3b_index index,
	output lc3b_offset offset
);

always_comb
begin
	tag = mem_address[15:7];
	index = mem_address[6:4];
	offset = mem_address[3:0];
end

endmodule : components
