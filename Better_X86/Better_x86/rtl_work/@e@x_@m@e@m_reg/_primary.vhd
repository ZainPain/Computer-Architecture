library verilog;
use verilog.vl_types.all;
library work;
entity EX_MEM_reg is
    port(
        clk             : in     vl_logic;
        load            : in     vl_logic;
        reset           : in     vl_logic;
        inst_in         : in     vl_logic_vector(15 downto 0);
        pc_in           : in     vl_logic_vector(15 downto 0);
        control_in      : in     work.lc3b_types.lc3b_control_word;
        alu_out_in      : in     vl_logic_vector(15 downto 0);
        sr2_in          : in     vl_logic_vector(15 downto 0);
        dest_in         : in     vl_logic_vector(2 downto 0);
        trap_vect8_in   : in     vl_logic_vector(15 downto 0);
        branch_address_in: in     vl_logic_vector(15 downto 0);
        inst_out        : out    vl_logic_vector(15 downto 0);
        pc_out          : out    vl_logic_vector(15 downto 0);
        control_out     : out    work.lc3b_types.lc3b_control_word;
        alu_out_out     : out    vl_logic_vector(15 downto 0);
        sr2_out         : out    vl_logic_vector(15 downto 0);
        dest_out        : out    vl_logic_vector(2 downto 0);
        trap_vect8_out  : out    vl_logic_vector(15 downto 0);
        branch_address_out: out    vl_logic_vector(15 downto 0)
    );
end EX_MEM_reg;
