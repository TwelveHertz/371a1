library verilog;
use verilog.vl_types.all;
entity inputManager is
    port(
        CLOCK_50        : in     vl_logic;
        ROW             : in     vl_logic_vector(3 downto 0);
        COL             : out    vl_logic_vector(3 downto 0);
        SW              : in     vl_logic_vector(17 downto 0);
        KEY             : in     vl_logic_vector(3 downto 0);
        numberPulse     : out    vl_logic_vector(4 downto 0);
        buttonPulse     : out    vl_logic_vector(4 downto 0);
        operatorPulse   : out    vl_logic_vector(4 downto 0);
        equalPulse      : out    vl_logic_vector(4 downto 0);
        resetPulse      : out    vl_logic_vector(4 downto 0);
        clearPulse      : out    vl_logic_vector(4 downto 0);
        negativePulse   : out    vl_logic_vector(4 downto 0);
        newClock        : out    vl_logic
    );
end inputManager;
