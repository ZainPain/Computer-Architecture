library verilog;
use verilog.vl_types.all;
library work;
entity staller is
    generic(
        width           : integer := 3
    );
    port(
        op_code         : in     work.lc3b_types.lc3b_opcode;
        resp            : in     vl_logic;
        mem_read        : in     vl_logic;
        mem_write       : in     vl_logic;
        counter         : in     vl_logic_vector(1 downto 0);
        datamux_sel     : in     vl_logic_vector(1 downto 0);
        datamux_sel_updated: out    vl_logic_vector(1 downto 0);
        mem_read_updated: out    vl_logic;
        mem_write_updated: out    vl_logic;
        load            : out    vl_logic;
        reset_counter   : out    vl_logic;
        load_LDI_STI_ADDRESS: out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end staller;
