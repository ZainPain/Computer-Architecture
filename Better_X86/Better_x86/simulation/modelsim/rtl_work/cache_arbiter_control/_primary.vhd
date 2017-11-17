library verilog;
use verilog.vl_types.all;
entity cache_arbiter_control is
    port(
        clk             : in     vl_logic;
        icache_read     : in     vl_logic;
        dcache_read     : in     vl_logic;
        dcache_write    : in     vl_logic;
        l2_resp         : in     vl_logic;
        cache_address_sel: out    vl_logic;
        cache_read_sel  : out    vl_logic_vector(1 downto 0);
        cache_write_sel : out    vl_logic;
        cache_resp_sel  : out    vl_logic;
        load_mar        : out    vl_logic;
        load_mdr_l1_to_l2: out    vl_logic;
        load_mdr_l2_to_l1: out    vl_logic;
        l2_read         : out    vl_logic;
        l2_write        : out    vl_logic
    );
end cache_arbiter_control;
