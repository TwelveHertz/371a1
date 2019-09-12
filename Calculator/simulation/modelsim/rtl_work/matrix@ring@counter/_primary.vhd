library verilog;
use verilog.vl_types.all;
entity matrixRingCounter is
    port(
        newClock        : in     vl_logic;
        ROW             : in     vl_logic_vector(3 downto 0);
        COL             : out    vl_logic_vector(3 downto 0);
        values          : out    vl_logic_vector(7 downto 0)
    );
end matrixRingCounter;
