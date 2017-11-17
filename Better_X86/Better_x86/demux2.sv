module demux2 #(parameter width = 16)
(
	input sel,
	input [width-1:0] in,
	output logic [width-1:0] a,b

);

always_comb 
begin
	a = '0;
	b = '0;
	if(sel == 0)
		a = in;
	else b = in;
end

endmodule : demux2