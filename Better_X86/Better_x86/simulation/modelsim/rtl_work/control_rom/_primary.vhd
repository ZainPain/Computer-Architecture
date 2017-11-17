library verilog;
use verilog.vl_types.all;
library work;
entity control_rom is
    port(
        opcode          : in     work.lc3b_types.lc3b_opcode;
        bit11           : in     vl_logic;
        bit5            : in     vl_logic;
        bit4            : in     vl_logic;
        ctrl            : out    work.lc3b_types.lc3b_control_word
    );
end control_rom;
