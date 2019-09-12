library verilog;
use verilog.vl_types.all;
entity TOP is
    port(
        CLOCK_50        : in     vl_logic;
        ROW             : in     vl_logic_vector(3 downto 0);
        SW              : in     vl_logic_vector(17 downto 0);
        KEY             : in     vl_logic_vector(3 downto 0);
        HEX0            : out    vl_logic_vector(6 downto 0);
        HEX1            : out    vl_logic_vector(6 downto 0);
        HEX2            : out    vl_logic_vector(6 downto 0);
        HEX3            : out    vl_logic_vector(6 downto 0);
        HEX4            : out    vl_logic_vector(6 downto 0);
        HEX5            : out    vl_logic_vector(6 downto 0);
        HEX6            : out    vl_logic_vector(6 downto 0);
        HEX7            : out    vl_logic_vector(6 downto 0);
        LEDG            : out    vl_logic_vector(4 downto 0);
        LEDR            : out    vl_logic_vector(17 downto 0);
        COL             : out    vl_logic_vector(3 downto 0);
        buttonPulse     : out    vl_logic_vector(4 downto 0);
        numberPulse     : out    vl_logic_vector(4 downto 0);
        operatorPulse   : out    vl_logic_vector(4 downto 0);
        equalPulse      : out    vl_logic_vector(4 downto 0);
        resetPulse      : out    vl_logic_vector(4 downto 0);
        clearPulse      : out    vl_logic_vector(4 downto 0);
        doubleButton    : out    vl_logic_vector(4 downto 0)
    );
end TOP;
