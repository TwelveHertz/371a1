library verilog;
use verilog.vl_types.all;
entity clockDivider is
    port(
        CLOCK_50        : in     vl_logic;
        newClock        : out    vl_logic;
        preScaler       : in     vl_logic_vector(19 downto 0)
    );
end clockDivider;
