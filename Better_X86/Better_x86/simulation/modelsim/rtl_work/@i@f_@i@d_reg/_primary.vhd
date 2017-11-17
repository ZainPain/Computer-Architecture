library verilog;
use verilog.vl_types.all;
library work;
entity IF_ID_reg is
    port(
        clk             : in     vl_logic;
        load            : in     vl_logic;
        reset           : in     vl_logic;
        inst_in         : in     vl_logic_vector(15 downto 0);
        pc_in           : in     vl_logic_vector(15 downto 0);
        inst_out        : out    vl_logic_vector(15 downto 0);
        pc_out          : out    vl_logic_vector(15 downto 0);
        offset6         : out    vl_logic_vector(5 downto 0);
        imm5            : out    vl_logic_vector(4 downto 0);
        imm4            : out    vl_logic_vector(3 downto 0);
        trap_vect8      : out    vl_logic_vector(7 downto 0);
        offset11        : out    vl_logic_vector(10 downto 0);
        offset9         : out    vl_logic_vector(8 downto 0);
        dest            : out    vl_logic_vector(2 downto 0);
        sr1             : out    vl_logic_vector(2 downto 0);
        sr2             : out    vl_logic_vector(2 downto 0);
        opcode          : out    work.lc3b_types.lc3b_opcode;
        ir11            : out    vl_logic;
        ir5             : out    vl_logic;
        ir4             : out    vl_logic
    );
end IF_ID_reg;
