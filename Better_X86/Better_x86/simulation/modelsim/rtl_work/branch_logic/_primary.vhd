library verilog;
use verilog.vl_types.all;
library work;
entity branch_logic is
    port(
        opcode          : in     work.lc3b_types.lc3b_opcode;
        branch_enable   : in     vl_logic;
        pcmux_sel       : in     vl_logic_vector(2 downto 0);
        pcmux_sel_updated: out    vl_logic_vector(2 downto 0);
        branch_enable_true: out    vl_logic
    );
end branch_logic;
