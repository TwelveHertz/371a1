library verilog;
use verilog.vl_types.all;
entity storeOperator is
    port(
        operatorPulse   : in     vl_logic_vector(4 downto 0);
        storeOp         : out    vl_logic_vector(3 downto 0)
    );
end storeOperator;
