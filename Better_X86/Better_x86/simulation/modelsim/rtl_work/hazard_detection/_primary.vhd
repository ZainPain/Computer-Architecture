library verilog;
use verilog.vl_types.all;
entity hazard_detection is
    port(
        ID_EX_mem_read  : in     vl_logic;
        ID_EX_dest      : in     vl_logic_vector(2 downto 0);
        IF_ID_sr1       : in     vl_logic_vector(2 downto 0);
        IF_ID_sr2       : in     vl_logic_vector(2 downto 0);
        forward_load    : out    vl_logic;
        controlmux_sel  : out    vl_logic
    );
end hazard_detection;
