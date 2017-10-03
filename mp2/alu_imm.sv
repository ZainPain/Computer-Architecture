import lc3b_types::*;

module alu_imm
(
    input lc3b_aluop aluop_imm,
    input lc3b_word a,
	 input lc3b_word b,
    output lc3b_word f
);

always_comb
begin
    case (aluop_imm)
        alu_add:  f = a + b;
        alu_and:  f = a & b;
        
        default: $display("Unknown aluop");
    endcase
end

endmodule : alu_imm
