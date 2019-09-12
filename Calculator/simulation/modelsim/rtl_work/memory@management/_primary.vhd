library verilog;
use verilog.vl_types.all;
entity memoryManagement is
    generic(
        Store           : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        Retrieve        : vl_logic_vector(0 to 1) := (Hi1, Hi0);
        Clear           : vl_logic_vector(0 to 1) := (Hi1, Hi1)
    );
    port(
        clk             : in     vl_logic;
        memoryFlag      : in     vl_logic_vector(4 downto 0);
        bcdInput        : in     vl_logic_vector(31 downto 0);
        bcdOutput       : out    vl_logic_vector(31 downto 0);
        bcdInputMemory  : in     vl_logic_vector(12 downto 0);
        bcdOutputMemory : out    vl_logic_vector(12 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of Store : constant is 1;
    attribute mti_svvh_generic_type of Retrieve : constant is 1;
    attribute mti_svvh_generic_type of Clear : constant is 1;
end memoryManagement;
