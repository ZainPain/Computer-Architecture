library verilog;
use verilog.vl_types.all;
library work;
entity forward is
    port(
        ID_EX_opcode    : in     work.lc3b_types.lc3b_opcode;
        EX_MEM_opcode   : in     work.lc3b_types.lc3b_opcode;
        bit5            : in     vl_logic;
        ID_EX_sr1       : in     vl_logic_vector(2 downto 0);
        ID_EX_sr2       : in     vl_logic_vector(2 downto 0);
        IF_ID_EX_dest   : in     vl_logic_vector(2 downto 0);
        ID_EX_mem_write : in     vl_logic;
        EX_MEM_reg_write: in     vl_logic;
        MEM_WB_reg_write: in     vl_logic;
        EX_MEM_mem_write: in     vl_logic;
        EX_MEM_dest     : in     vl_logic_vector(2 downto 0);
        MEM_WB_dest     : in     vl_logic_vector(2 downto 0);
        writemux_sel    : in     vl_logic;
        ForwardA        : out    vl_logic_vector(1 downto 0);
        ForwardB        : out    vl_logic_vector(1 downto 0);
        writemux_sel_updated: out    vl_logic;
        EX_MEM_mux_sel  : out    vl_logic;
        sr2mux_sel      : out    vl_logic
    );
end forward;
