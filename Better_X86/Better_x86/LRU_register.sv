import lc3b_types::*;

module LRU_register
(
    input clk,
    input load,
    input lc3b_l1_index index,
    input [1:0] hit,
    output logic [1:0] dataout
);

logic [1:0] lru0 [7:0];
logic [1:0] lru1 [7:0];
logic [1:0] lru2 [7:0];
logic [1:0] lru3 [7:0];

logic [1:0] datain;
logic [1:0] in_sel;

logic load0;
logic load1;
logic load2;
logic load3;

initial
begin
    for (int i = 0; i < $size(lru0); i++)
    begin
        lru0[i] = 2'b00;
        lru1[i] = 2'b01;
        lru2[i] = 2'b10;
        lru3[i] = 2'b11;
    end
end

always_ff @(posedge clk)
begin
    if (load)
    begin
        if (load0 == 1)
            lru0[index] = lru1[index];
        if (load1 == 1)
            lru1[index] = lru2[index];
        if (load2 == 1)
            lru2[index] = lru3[index];
        if (load3 == 1)
            lru3[index] = datain;
    end

end

always_comb
begin
	load0 = 0;
	load1 = 0;
	load2 = 0;
	load3 = 0;
	in_sel = 0;
	if (lru0[index] == hit)
	begin
		in_sel = 2'b00;
		load0 = 1;
		load1 = 1;
		load2 = 1;
		load3 = 1;
	end
	else if (lru1[index] == hit)
	begin
		in_sel = 2'b01;
		load1 = 1;
		load2 = 1;
		load3 = 1;
	end
	else if (lru2[index] == hit)
	begin
		in_sel = 2'b10;
		load2 = 1;
		load3 = 1;
	end
	else if (lru3[index] == hit)
	begin
		in_sel = 2'b11;
	end
end

mux4 #(.width(2)) datain_mux
(
	.sel(in_sel),
	.a(lru0[index]),
	.b(lru1[index]),
	.c(lru2[index]),
	.d(lru3[index]),
	.f(datain)
);

assign dataout = lru0[index];

endmodule : LRU_register
