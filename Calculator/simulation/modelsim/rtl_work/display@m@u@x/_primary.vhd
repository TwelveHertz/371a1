library verilog;
use verilog.vl_types.all;
entity displayMUX is
    port(
        disp_sel        : in     vl_logic_vector(1 downto 0);
        storeA          : in     vl_logic_vector(12 downto 0);
        storeB          : in     vl_logic_vector(12 downto 0);
        BCDanswer       : in     vl_logic_vector(24 downto 0);
        \register\      : out    vl_logic_vector(31 downto 0)
    );
end displayMUX;
