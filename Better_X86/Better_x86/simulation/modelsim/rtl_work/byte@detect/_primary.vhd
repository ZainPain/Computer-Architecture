library verilog;
use verilog.vl_types.all;
entity byteDetect is
    generic(
        width           : integer := 16
    );
    port(
        \in\            : in     vl_logic_vector;
        \signal\        : in     vl_logic;
        wmask           : out    vl_logic_vector(1 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end byteDetect;
