library verilog;
use verilog.vl_types.all;
entity stb_shifter is
    generic(
        width           : integer := 16
    );
    port(
        \in\            : in     vl_logic_vector;
        shift           : in     vl_logic;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end stb_shifter;
