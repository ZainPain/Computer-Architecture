library verilog;
use verilog.vl_types.all;
library work;
entity NOPS is
    port(
        zero_signal     : out    work.lc3b_types.lc3b_control_word
    );
end NOPS;
