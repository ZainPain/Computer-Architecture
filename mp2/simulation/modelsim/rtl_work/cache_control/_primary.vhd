library verilog;
use verilog.vl_types.all;
entity cache_control is
    port(
        clk             : in     vl_logic;
        hit             : in     vl_logic;
        way_select      : in     vl_logic;
        load_tag1       : out    vl_logic;
        load_tag2       : out    vl_logic;
        load_lru        : out    vl_logic;
        load_data1      : out    vl_logic;
        load_data2      : out    vl_logic;
        load_valid1     : out    vl_logic;
        load_valid2     : out    vl_logic;
        eviction        : out    vl_logic;
        valid1_in       : out    vl_logic;
        valid2_in       : out    vl_logic;
        valid1_out      : in     vl_logic;
        valid2_out      : in     vl_logic;
        lru_in          : out    vl_logic;
        lru_out         : in     vl_logic;
        mem_read        : in     vl_logic;
        mem_write       : in     vl_logic;
        pmem_resp       : in     vl_logic;
        mem_byte_enable : in     vl_logic_vector(1 downto 0);
        mem_resp        : out    vl_logic;
        pmem_read       : out    vl_logic;
        pmem_write      : out    vl_logic
    );
end cache_control;
