library verilog;
use verilog.vl_types.all;
entity decoder is
    generic(
        width           : integer := 3
    );
    port(
        \in\            : in     vl_logic_vector;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end decoder;
