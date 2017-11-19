library verilog;
use verilog.vl_types.all;
library work;
entity forward is
    port(
        opcode          : in     work.lc3b_types.lc3b_opcode;
        bit5            : in     vl_logic;
        ID_EX_sr1       : in     vl_logic_vector(2 downto 0);
        ID_EX_sr2       : in     vl_logic_vector(2 downto 0);
        EX_MEM_write    : in     vl_logic;
        MEM_WB_write    : in     vl_logic;
        EX_MEM_dest     : in     vl_logic_vector(2 downto 0);
        MEM_WB_dest     : in     vl_logic_vector(2 downto 0);
        ForwardA        : out    vl_logic_vector(1 downto 0);
        ForwardB        : out    vl_logic_vector(1 downto 0)
    );
end forward;
