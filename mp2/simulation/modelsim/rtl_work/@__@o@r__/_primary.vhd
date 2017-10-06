library verilog;
use verilog.vl_types.all;
entity \__OR__\ is
    generic(
        width           : integer := 1
    );
    port(
        in1             : in     vl_logic_vector;
        in2             : in     vl_logic_vector;
        \out\           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end \__OR__\;
