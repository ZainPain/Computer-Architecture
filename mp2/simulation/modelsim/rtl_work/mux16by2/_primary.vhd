library verilog;
use verilog.vl_types.all;
entity mux16by2 is
    port(
        in1             : in     vl_logic_vector(127 downto 0);
        in2             : in     vl_logic_vector(127 downto 0);
        way_select      : in     vl_logic;
        offset          : in     vl_logic_vector(3 downto 0);
        \out\           : out    vl_logic_vector(15 downto 0)
    );
end mux16by2;
