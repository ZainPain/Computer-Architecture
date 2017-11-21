library verilog;
use verilog.vl_types.all;
entity LRU_register is
    port(
        clk             : in     vl_logic;
        load            : in     vl_logic;
        index           : in     vl_logic_vector(2 downto 0);
        hit             : in     vl_logic_vector(1 downto 0);
        dataout         : out    vl_logic_vector(1 downto 0)
    );
end LRU_register;
