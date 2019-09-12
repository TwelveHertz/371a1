library verilog;
use verilog.vl_types.all;
entity buttonPressDecoder is
    port(
        newClock        : in     vl_logic;
        SW              : in     vl_logic_vector(3 downto 0);
        buttonInformation: out    vl_logic_vector(4 downto 0)
    );
end buttonPressDecoder;
