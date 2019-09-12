library verilog;
use verilog.vl_types.all;
entity recall is
    port(
        buttonPulse     : in     vl_logic_vector(4 downto 0);
        ld_m            : out    vl_logic
    );
end recall;
