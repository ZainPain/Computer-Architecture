library verilog;
use verilog.vl_types.all;
library work;
entity ID_EX_reg is
    port(
        clk             : in     vl_logic;
        load            : in     vl_logic;
        reset           : in     vl_logic;
        inst_in         : in     vl_logic_vector(15 downto 0);
        pc_in           : in     vl_logic_vector(15 downto 0);
        control_in      : in     work.lc3b_types.lc3b_control_word;
        src1_in         : in     vl_logic_vector(2 downto 0);
        src2_in         : in     vl_logic_vector(2 downto 0);
        reg_a           : in     vl_logic_vector(15 downto 0);
        reg_b           : in     vl_logic_vector(15 downto 0);
        dest_in         : in     vl_logic_vector(2 downto 0);
        src1_out        : out    vl_logic_vector(2 downto 0);
        src2_out        : out    vl_logic_vector(2 downto 0);
        sext6_in        : in     vl_logic_vector(15 downto 0);
        sext5_in        : in     vl_logic_vector(15 downto 0);
        sext4_in        : in     vl_logic_vector(15 downto 0);
        adj6_in         : in     vl_logic_vector(15 downto 0);
        adj9_in         : in     vl_logic_vector(15 downto 0);
        adj11_in        : in     vl_logic_vector(15 downto 0);
        trap_vect8_in   : in     vl_logic_vector(15 downto 0);
        ir5_in          : in     vl_logic;
        inst_out        : out    vl_logic_vector(15 downto 0);
        pc_out          : out    vl_logic_vector(15 downto 0);
        control_out     : out    work.lc3b_types.lc3b_control_word;
        sr1             : out    vl_logic_vector(15 downto 0);
        sr2             : out    vl_logic_vector(15 downto 0);
        dest_out        : out    vl_logic_vector(2 downto 0);
        ir5_out         : out    vl_logic;
        sext6_out       : out    vl_logic_vector(15 downto 0);
        sext5_out       : out    vl_logic_vector(15 downto 0);
        sext4_out       : out    vl_logic_vector(15 downto 0);
        adj6_out        : out    vl_logic_vector(15 downto 0);
        adj9_out        : out    vl_logic_vector(15 downto 0);
        adj11_out       : out    vl_logic_vector(15 downto 0);
        trap_vect8_out  : out    vl_logic_vector(15 downto 0)
    );
end ID_EX_reg;
