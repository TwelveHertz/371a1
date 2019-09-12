library verilog;
use verilog.vl_types.all;
entity toggle is
    port(
        pulse           : in     vl_logic_vector(4 downto 0);
        toggledOutput   : out    vl_logic
    );
end toggle;
