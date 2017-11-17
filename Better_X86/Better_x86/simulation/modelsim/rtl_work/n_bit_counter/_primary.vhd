library verilog;
use verilog.vl_types.all;
entity n_bit_counter is
    generic(
        width           : integer := 1
    );
    port(
        \out\           : out    vl_logic_vector;
        load            : in     vl_logic;
        clk             : in     vl_logic;
        reset           : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end n_bit_counter;
