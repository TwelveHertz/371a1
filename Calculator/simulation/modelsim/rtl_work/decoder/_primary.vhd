library verilog;
use verilog.vl_types.all;
entity decoder is
    port(
        newClock        : in     vl_logic;
        values          : in     vl_logic_vector(7 downto 0);
        numberKey       : out    vl_logic_vector(4 downto 0);
        operatorKey     : out    vl_logic_vector(4 downto 0);
        equalKey        : out    vl_logic_vector(4 downto 0);
        resetKey        : out    vl_logic_vector(4 downto 0);
        clearKey        : out    vl_logic_vector(4 downto 0)
    );
end decoder;
