library verilog;
use verilog.vl_types.all;
entity displayOperand is
    port(
        \register\      : in     vl_logic_vector(3 downto 0);
        Hex             : out    vl_logic_vector(6 downto 0)
    );
end displayOperand;
