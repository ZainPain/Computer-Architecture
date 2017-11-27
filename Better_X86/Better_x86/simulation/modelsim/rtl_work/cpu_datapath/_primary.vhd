library verilog;
use verilog.vl_types.all;
entity cpu_datapath is
    port(
        clk             : in     vl_logic;
        icache_read     : out    vl_logic;
        icache_write    : out    vl_logic;
        icache_wmask    : out    vl_logic_vector(1 downto 0);
        icache_address  : out    vl_logic_vector(15 downto 0);
        icache_wdata    : out    vl_logic_vector(15 downto 0);
        icache_resp     : in     vl_logic;
        icache_rdata    : in     vl_logic_vector(15 downto 0);
        dcache_read     : out    vl_logic;
        dcache_write    : out    vl_logic;
        dcache_wmask    : out    vl_logic_vector(1 downto 0);
        dcache_address  : out    vl_logic_vector(15 downto 0);
        dcache_wdata    : out    vl_logic_vector(15 downto 0);
        dcache_resp     : in     vl_logic;
        dcache_rdata    : in     vl_logic_vector(15 downto 0);
        l2cache_resp    : in     vl_logic
    );
end cpu_datapath;
