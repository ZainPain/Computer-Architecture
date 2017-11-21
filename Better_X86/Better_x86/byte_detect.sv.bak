module byteDetect #(parameter width = 16)
(
    input [width-1:0] in,
	 input logic signal,
	 output logic [1:0] wmask
	 
);


always_comb
begin

	wmask = 2'b11;
	if( signal)
	begin
		if(in[0])
			wmask = 2'b10;
	
		else
			wmask = 2'b01;
	end

end

endmodule : byteDetect