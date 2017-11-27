library verilog;
use verilog.vl_types.all;
entity Memory_Mapped_IO is
    port(
        clk             : in     vl_logic;
        counter         : in     vl_logic_vector(3 downto 0);
        mem_read        : in     vl_logic;
        mem_write       : in     vl_logic;
        MMIO_read       : in     vl_logic;
        MMIO_write      : in     vl_logic;
        Icache_resp     : in     vl_logic;
        Dcache_resp     : in     vl_logic;
        L2cache_resp    : in     vl_logic;
        branch          : in     vl_logic;
        branch_not      : in     vl_logic;
        stall_IF_ID     : in     vl_logic;
        stall_ID_EX     : in     vl_logic;
        stall_EX_MEM    : in     vl_logic;
        stall_MEM_WB    : in     vl_logic;
        counter_out     : out    vl_logic_vector(15 downto 0)
    );
end Memory_Mapped_IO;
