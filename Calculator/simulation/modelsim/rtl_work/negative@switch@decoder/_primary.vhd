library verilog;
use verilog.vl_types.all;
entity negativeSwitchDecoder is
    port(
        SW17            : in     vl_logic;
        negativeKey     : out    vl_logic_vector(4 downto 0)
    );
end negativeSwitchDecoder;
