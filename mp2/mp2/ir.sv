import lc3b_types::*;

module ir
(
    input clk,
    input load,
    input lc3b_word in,
    output lc3b_opcode opcode,
    output lc3b_reg dest, src1, src2,
    output lc3b_offset6 offset6,
    output lc3b_offset9 offset9,
	 output lc3b_offset11 offset11,
	 output logic imm,
	 output logic [4:0] imm5,
	 output lc3b_byte trap8,
	 output lc3b_word imm4,
	 output logic bit11,
	 output logic bit4
	 
);

lc3b_word data;

always_ff @(posedge clk)
begin
    if (load == 1)
    begin
        data = in;
    end
end

always_comb
begin
    opcode = lc3b_opcode'(data[15:12]);
	 if(opcode == op_trap || opcode == op_jsr) begin
		dest = 3'b111;
	 end
	 else begin
		dest = data[11:9];
	 end
    src1 = data[8:6];
    src2 = data[2:0];
	 imm  = data[5];
    offset6 = data[5:0];
    offset9 = data[8:0];
	 offset11 = data[10:0];
	 imm5 = data[4:0];
	 imm4 = $unsigned(data[3:0]);

	 bit11 = data[11];
	 bit4 = data[4];
	 trap8 = data[7:0];
end
endmodule : ir