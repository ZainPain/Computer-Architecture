library verilog;
use verilog.vl_types.all;
entity cccomp is
    generic(
        width           : integer := 3
    );
    port(
        dest            : in     vl_logic_vector(2 downto 0);
        nzp             : in     vl_logic_vector(2 downto 0);
        \out\           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end cccomp;
