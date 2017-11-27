library verilog;
use verilog.vl_types.all;
entity address_checker is
    port(
        address         : in     vl_logic_vector(15 downto 0);
        mem_read        : in     vl_logic;
        mem_write       : in     vl_logic;
        mem_read_update : out    vl_logic;
        mem_write_update: out    vl_logic;
        MMIO_read       : out    vl_logic;
        MMIO_write      : out    vl_logic;
        counter_address : out    vl_logic_vector(3 downto 0);
        memoryout_sel   : out    vl_logic
    );
end address_checker;
