import lc3b_types::*;

module write_to_dataArray(
	input lc3b_data in,
	input lc3b_word mem_wdata,
	input logic [1:0] mem_byte_enable,
	input lc3b_offset offset,
	output lc3b_data out
	
);
logic [2:0] off;
always_comb
begin
	out = in;
	off = offset[3:1];
	if(mem_byte_enable[1])
	begin
		case(off)
			3'b000: out[15:8] = mem_wdata[15:8];
			3'b001: out[31:24] = mem_wdata[15:8];
			3'b010: out[47:40] = mem_wdata[15:8];
			3'b011: out[63:56] = mem_wdata[15:8];
			3'b100: out[79:72] = mem_wdata[15:8];
			3'b101: out[95:88] = mem_wdata[15:8];
			3'b110: out[111:104] = mem_wdata[15:8];
			3'b111: out[127:120] = mem_wdata[15:8];
			default: $display("get rekt");
		endcase
	end
	if(mem_byte_enable[0])
	begin
		case(off)
			3'b000: out[7:0] = mem_wdata[7:0];
			3'b001: out[23:16] = mem_wdata[7:0];
			3'b010: out[39:32] = mem_wdata[7:0];
			3'b011: out[55:48] = mem_wdata[7:0];
			3'b100: out[71:64] = mem_wdata[7:0];
			3'b101: out[87:80] = mem_wdata[7:0];
			3'b110: out[103:96] = mem_wdata[7:0];
			3'b111: out[119:112] = mem_wdata[7:0];
			default: $display("get rekt");
		endcase
	end
		
end
/*
	case(off)
		3'b000: out[15:0] = mem_wdata;
		3'b001: out[31:16] = mem_wdata;
		3'b010: out[47:32] = mem_wdata;
		3'b011: out[63:48] = mem_wdata;
		3'b100: out[79:64] = mem_wdata;
		3'b101: out[95:80] = mem_wdata;
		3'b110: out[111:96] = mem_wdata;
		3'b111: out[127:112] = mem_wdata;
		default: $display("get rekt");
	endcase
*/

endmodule : write_to_dataArray