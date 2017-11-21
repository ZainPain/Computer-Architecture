library verilog;
use verilog.vl_types.all;
library work;
entity writeback_forward is
    port(
        MEM_WB_ctrl     : in     work.lc3b_types.lc3b_control_word;
        writeback_mux_sel: out    vl_logic_vector(1 downto 0)
    );
end writeback_forward;
