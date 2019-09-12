library verilog;
use verilog.vl_types.all;
entity storeBCD is
    port(
        clk             : in     vl_logic;
        memoryFlag      : in     vl_logic_vector(4 downto 0);
        numberPulse     : in     vl_logic_vector(4 downto 0);
        clear           : in     vl_logic;
        reset           : in     vl_logic;
        bcdOutput       : in     vl_logic_vector(12 downto 0);
        negativeSign    : in     vl_logic;
        \register\      : out    vl_logic_vector(12 downto 0)
    );
end storeBCD;
