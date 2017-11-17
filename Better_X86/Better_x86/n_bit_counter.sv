module n_bit_counter #(parameter width = 1)
(
	output logic [width-1:0] out,
	input logic	load,
	input logic clk,
	input logic reset
);

logic [width-1:0] data;

initial
begin
	data <= '0;
end

always_ff @(posedge clk) 
begin
if (reset)
	data <= '0;
else if (load)
	data <= data+1;
end

always_comb
begin
	out = data;
end

endmodule : n_bit_counter