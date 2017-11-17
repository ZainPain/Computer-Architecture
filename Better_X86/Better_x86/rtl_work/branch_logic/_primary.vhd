library verilog;
use verilog.vl_types.all;
library work;
entity branch_logic is
    port(
        opcode          : in     work.lc3b_types.lc3b_opcode;
        branch_enable   : in     vl_logic;
        pcmux_sel       : in     vl_logic_vector(1 downto 0);
        pcmux_sel_updated: out    vl_logic_vector(1 downto 0)
    );
end branch_logic;
