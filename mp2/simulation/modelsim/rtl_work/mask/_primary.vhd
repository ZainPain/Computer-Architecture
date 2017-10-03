library verilog;
use verilog.vl_types.all;
entity mask is
    generic(
        width           : integer := 16
    );
    port(
        \in\            : in     vl_logic_vector;
        address         : in     vl_logic_vector(15 downto 0);
        mask_enable     : in     vl_logic;
        mask_out        : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end mask;
