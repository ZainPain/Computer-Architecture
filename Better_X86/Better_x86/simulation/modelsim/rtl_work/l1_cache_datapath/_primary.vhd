library verilog;
use verilog.vl_types.all;
entity l1_cache_datapath is
    port(
        clk             : in     vl_logic;
        mem_rdata       : out    vl_logic_vector(15 downto 0);
        mem_address     : in     vl_logic_vector(15 downto 0);
        mem_wdata       : in     vl_logic_vector(15 downto 0);
        mem_byte_enable : in     vl_logic_vector(1 downto 0);
        pmem_rdata      : in     vl_logic_vector(127 downto 0);
        pmem_address    : out    vl_logic_vector(15 downto 0);
        pmem_wdata      : out    vl_logic_vector(127 downto 0);
        waymux_sel      : in     vl_logic;
        write_array_sel : in     vl_logic;
        data0_load      : in     vl_logic;
        data1_load      : in     vl_logic;
        tag0_load       : in     vl_logic;
        tag1_load       : in     vl_logic;
        valid0_load     : in     vl_logic;
        valid1_load     : in     vl_logic;
        dirty0_load     : in     vl_logic;
        dirty1_load     : in     vl_logic;
        lru_load        : in     vl_logic;
        valid0_in       : in     vl_logic;
        valid1_in       : in     vl_logic;
        dirty0_in       : in     vl_logic;
        dirty1_in       : in     vl_logic;
        lru_in          : in     vl_logic;
        pmem_address_sel: in     vl_logic_vector(1 downto 0);
        valid0_out      : out    vl_logic;
        valid1_out      : out    vl_logic;
        dirty0_out      : out    vl_logic;
        dirty1_out      : out    vl_logic;
        lru_out         : out    vl_logic;
        match0          : out    vl_logic;
        match1          : out    vl_logic
    );
end l1_cache_datapath;
