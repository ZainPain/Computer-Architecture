library verilog;
use verilog.vl_types.all;
entity l2_cache_control is
    port(
        clk             : in     vl_logic;
        mem_resp        : out    vl_logic;
        pmem_read       : out    vl_logic;
        pmem_write      : out    vl_logic;
        waymux_sel      : out    vl_logic_vector(1 downto 0);
        write_array_sel : out    vl_logic;
        data0_load      : out    vl_logic;
        data1_load      : out    vl_logic;
        data2_load      : out    vl_logic;
        data3_load      : out    vl_logic;
        tag0_load       : out    vl_logic;
        tag1_load       : out    vl_logic;
        tag2_load       : out    vl_logic;
        tag3_load       : out    vl_logic;
        valid0_load     : out    vl_logic;
        valid1_load     : out    vl_logic;
        valid2_load     : out    vl_logic;
        valid3_load     : out    vl_logic;
        dirty0_load     : out    vl_logic;
        dirty1_load     : out    vl_logic;
        dirty2_load     : out    vl_logic;
        dirty3_load     : out    vl_logic;
        lru_load        : out    vl_logic;
        valid0_in       : out    vl_logic;
        valid1_in       : out    vl_logic;
        valid2_in       : out    vl_logic;
        valid3_in       : out    vl_logic;
        dirty0_in       : out    vl_logic;
        dirty1_in       : out    vl_logic;
        dirty2_in       : out    vl_logic;
        dirty3_in       : out    vl_logic;
        lru_in          : out    vl_logic_vector(1 downto 0);
        pmem_address_sel: out    vl_logic_vector(2 downto 0);
        mem_read        : in     vl_logic;
        mem_write       : in     vl_logic;
        pmem_resp       : in     vl_logic;
        valid0_out      : in     vl_logic;
        valid1_out      : in     vl_logic;
        valid2_out      : in     vl_logic;
        valid3_out      : in     vl_logic;
        dirty0_out      : in     vl_logic;
        dirty1_out      : in     vl_logic;
        dirty2_out      : in     vl_logic;
        dirty3_out      : in     vl_logic;
        lru_out         : in     vl_logic_vector(1 downto 0);
        match0          : in     vl_logic;
        match1          : in     vl_logic;
        match2          : in     vl_logic;
        match3          : in     vl_logic
    );
end l2_cache_control;
