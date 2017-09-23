library verilog;
use verilog.vl_types.all;
library work;
entity control is
    port(
        clk             : in     vl_logic;
        opcode          : in     work.lc3b_types.lc3b_opcode;
        branch_enable   : in     vl_logic;
        imm             : in     vl_logic;
        bit11           : in     vl_logic;
        bit4            : in     vl_logic;
        alu_out         : in     vl_logic_vector(15 downto 0);
        load_pc         : out    vl_logic;
        load_ir         : out    vl_logic;
        load_regfile    : out    vl_logic;
        load_mar        : out    vl_logic;
        load_mdr        : out    vl_logic;
        load_cc         : out    vl_logic;
        mask_enable     : out    vl_logic;
        truncate        : out    vl_logic;
        shift           : out    vl_logic;
        pcmux_sel       : out    vl_logic_vector(2 downto 0);
        storemux_sel    : out    vl_logic;
        alumux_sel      : out    vl_logic_vector(1 downto 0);
        regfilemux_sel  : out    vl_logic_vector(1 downto 0);
        marmux_sel      : out    vl_logic_vector(2 downto 0);
        mdrmux_sel      : out    vl_logic;
        adjmux_sel      : out    vl_logic;
        aluop           : out    work.lc3b_types.lc3b_aluop;
        aluop_imm       : out    work.lc3b_types.lc3b_aluop;
        mem_resp        : in     vl_logic;
        mem_read        : out    vl_logic;
        mem_write       : out    vl_logic;
        mem_byte_enable : out    vl_logic_vector(1 downto 0)
    );
end control;