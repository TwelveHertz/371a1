library verilog;
use verilog.vl_types.all;
entity FSM is
    generic(
        S0              : integer := 0;
        S1              : integer := 1;
        S2              : integer := 2;
        S3              : integer := 3;
        S4              : integer := 4
    );
    port(
        clk             : in     vl_logic;
        op_in           : in     vl_logic;
        digit_in        : in     vl_logic;
        execute_in      : in     vl_logic;
        reset           : in     vl_logic;
        clear_in        : in     vl_logic;
        buttonPulse     : in     vl_logic_vector(4 downto 0);
        disp_sel        : out    vl_logic_vector(1 downto 0);
        ld_a            : out    vl_logic;
        ld_b            : out    vl_logic;
        ld_op           : out    vl_logic;
        ld_r            : out    vl_logic;
        clear           : out    vl_logic;
        resetAll        : out    vl_logic;
        LED             : out    vl_logic_vector(4 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of S0 : constant is 1;
    attribute mti_svvh_generic_type of S1 : constant is 1;
    attribute mti_svvh_generic_type of S2 : constant is 1;
    attribute mti_svvh_generic_type of S3 : constant is 1;
    attribute mti_svvh_generic_type of S4 : constant is 1;
end FSM;
