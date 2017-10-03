module mux21 #(parameter width = 1)
(
	input sel,
	input [width-1:0] a, b,
	output logic [width-1:0] f
);

always_comb 
begin
	if(sel == 0)
		f = a;
	else f = b;
end
endmodule : mux21