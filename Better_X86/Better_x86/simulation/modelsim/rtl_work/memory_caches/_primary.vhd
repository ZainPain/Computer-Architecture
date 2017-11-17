library verilog;
use verilog.vl_types.all;
entity memory_caches is
    port(
        clk             : in     vl_logic;
        icache_read_cpu : in     vl_logic;
        icache_write_cpu: in     vl_logic;
        icache_wmask_cpu: in     vl_logic_vector(1 downto 0);
        icache_address_cpu: in     vl_logic_vector(15 downto 0);
        icache_wdata_cpu: in     vl_logic_vector(15 downto 0);
        icache_resp_cpu : out    vl_logic;
        icache_rdata_cpu: out    vl_logic_vector(15 downto 0);
        dcache_read_cpu : in     vl_logic;
        dcache_write_cpu: in     vl_logic;
        dcache_wmask_cpu: in     vl_logic_vector(1 downto 0);
        dcache_address_cpu: in     vl_logic_vector(15 downto 0);
        dcache_wdata_cpu: in     vl_logic_vector(15 downto 0);
        dcache_resp_cpu : out    vl_logic;
        dcache_rdata_cpu: out    vl_logic_vector(15 downto 0);
        pmem_resp       : in     vl_logic;
        pmem_rdata      : in     vl_logic_vector(127 downto 0);
        pmem_read       : out    vl_logic;
        pmem_write      : out    vl_logic;
        pmem_address    : out    vl_logic_vector(15 downto 0);
        pmem_wdata      : out    vl_logic_vector(127 downto 0)
    );
end memory_caches;
