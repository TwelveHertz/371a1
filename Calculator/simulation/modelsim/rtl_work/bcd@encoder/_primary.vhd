library verilog;
use verilog.vl_types.all;
entity bcdEncoder is
    port(
        signedInput     : in     vl_logic_vector(20 downto 0);
        sign            : out    vl_logic;
        binary1         : out    vl_logic_vector(3 downto 0);
        binary2         : out    vl_logic_vector(3 downto 0);
        binary3         : out    vl_logic_vector(3 downto 0);
        binary4         : out    vl_logic_vector(3 downto 0);
        binary5         : out    vl_logic_vector(3 downto 0);
        binary6         : out    vl_logic_vector(3 downto 0)
    );
end bcdEncoder;
