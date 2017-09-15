library verilog;
use verilog.vl_types.all;
library work;
entity datapath is
    port(
        clk             : in     vl_logic;
        load_pc         : in     vl_logic;
        load_ir         : in     vl_logic;
        load_regfile    : in     vl_logic;
        load_mar        : in     vl_logic;
        load_mdr        : in     vl_logic;
        load_cc         : in     vl_logic;
        mask_enable     : in     vl_logic;
        truncate        : in     vl_logic;
        pcmux_sel       : in     vl_logic_vector(1 downto 0);
        storemux_sel    : in     vl_logic;
        alumux_sel      : in     vl_logic_vector(1 downto 0);
        regfilemux_sel  : in     vl_logic_vector(1 downto 0);
        marmux_sel      : in     vl_logic_vector(1 downto 0);
        mdrmux_sel      : in     vl_logic;
        adjmux_sel      : in     vl_logic;
        aluop           : in     work.lc3b_types.lc3b_aluop;
        aluop_imm       : in     work.lc3b_types.lc3b_aluop;
        mem_rdata       : in     vl_logic_vector(15 downto 0);
        branch_enable   : out    vl_logic;
        opcode          : out    work.lc3b_types.lc3b_opcode;
        mem_address     : out    vl_logic_vector(15 downto 0);
        mem_wdata       : out    vl_logic_vector(15 downto 0);
        imm             : out    vl_logic;
        bit11           : out    vl_logic;
        bit4            : out    vl_logic;
        alu_out         : out    vl_logic_vector(15 downto 0)
    );
end datapath;
