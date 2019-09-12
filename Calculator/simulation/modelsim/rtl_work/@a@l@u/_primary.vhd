library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        operandA        : in     vl_logic_vector(10 downto 0);
        operandB        : in     vl_logic_vector(10 downto 0);
        equalPulse      : in     vl_logic_vector(4 downto 0);
        operator        : in     vl_logic_vector(3 downto 0);
        answer          : out    vl_logic_vector(20 downto 0)
    );
end ALU;
