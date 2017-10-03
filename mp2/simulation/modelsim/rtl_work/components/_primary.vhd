library verilog;
use verilog.vl_types.all;
entity components is
    port(
        mem_address     : in     vl_logic_vector(15 downto 0);
        tag             : out    vl_logic_vector(8 downto 0);
        index           : out    vl_logic_vector(2 downto 0);
        offset          : out    vl_logic_vector(3 downto 0)
    );
end components;
