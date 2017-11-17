library verilog;
use verilog.vl_types.all;
entity cache_arbiter is
    port(
        clk             : in     vl_logic;
        icache_address  : in     vl_logic_vector(15 downto 0);
        icache_rdata    : out    vl_logic_vector(127 downto 0);
        icache_resp     : out    vl_logic;
        icache_read     : in     vl_logic;
        dcache_address  : in     vl_logic_vector(15 downto 0);
        dcache_wdata    : in     vl_logic_vector(127 downto 0);
        dcache_rdata    : out    vl_logic_vector(127 downto 0);
        dcache_resp     : out    vl_logic;
        dcache_read     : in     vl_logic;
        dcache_write    : in     vl_logic;
        l2cache_address : out    vl_logic_vector(15 downto 0);
        l2cache_wdata   : out    vl_logic_vector(127 downto 0);
        l2cache_rdata   : in     vl_logic_vector(127 downto 0);
        l2_resp         : in     vl_logic;
        l2_read         : out    vl_logic;
        l2_write        : out    vl_logic
    );
end cache_arbiter;
