library verilog;
use verilog.vl_types.all;
entity pulseSignal is
    port(
        keyPulse        : out    vl_logic_vector(4 downto 0);
        key             : in     vl_logic_vector(4 downto 0);
        newClock        : in     vl_logic
    );
end pulseSignal;
