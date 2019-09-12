library verilog;
use verilog.vl_types.all;
entity twoClockPulse is
    port(
        pulse           : in     vl_logic_vector(4 downto 0);
        doublePulse     : out    vl_logic_vector(4 downto 0);
        clock           : in     vl_logic
    );
end twoClockPulse;
