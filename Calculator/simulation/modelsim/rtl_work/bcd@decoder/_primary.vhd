library verilog;
use verilog.vl_types.all;
entity bcdDecoder is
    port(
        sign            : in     vl_logic;
        input1          : in     vl_logic_vector(3 downto 0);
        input2          : in     vl_logic_vector(3 downto 0);
        input3          : in     vl_logic_vector(3 downto 0);
        binaryOutput    : out    vl_logic_vector(10 downto 0)
    );
end bcdDecoder;
