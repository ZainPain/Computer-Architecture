library verilog;
use verilog.vl_types.all;
entity cache_datapath is
    port(
        clk             : in     vl_logic;
        load_tag1       : in     vl_logic;
        load_tag2       : in     vl_logic;
        load_valid1     : in     vl_logic;
        load_valid2     : in     vl_logic;
        load_data1      : in     vl_logic;
        load_data2      : in     vl_logic;
        load_lru        : in     vl_logic;
        load_dirty1     : in     vl_logic;
        load_dirty2     : in     vl_logic;
        hit             : out    vl_logic;
        way_select      : out    vl_logic;
        eviction        : in     vl_logic;
        valid1_in       : in     vl_logic;
        valid2_in       : in     vl_logic;
        dirty1_in       : in     vl_logic;
        dirty2_in       : in     vl_logic;
        lru_in          : in     vl_logic;
        lru_out         : out    vl_logic;
        dirty1_out      : out    vl_logic;
        dirty2_out      : out    vl_logic;
        mem_address     : in     vl_logic_vector(15 downto 0);
        pmem_rdata      : in     vl_logic_vector(127 downto 0);
        mem_wdata       : in     vl_logic_vector(15 downto 0);
        mem_rdata       : out    vl_logic_vector(15 downto 0);
        pmem_wdata      : out    vl_logic_vector(127 downto 0);
        pmem_address    : out    vl_logic_vector(15 downto 0)
    );
end cache_datapath;
