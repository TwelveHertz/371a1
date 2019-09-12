library verilog;
use verilog.vl_types.all;
entity debouncer is
    port(
        newClock        : in     vl_logic;
        information     : in     vl_logic_vector(4 downto 0);
        key             : out    vl_logic_vector(4 downto 0)
    );
end debouncer;
