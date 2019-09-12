library verilog;
use verilog.vl_types.all;
entity registerTransfer is
    port(
        ld_a            : in     vl_logic;
        ld_b            : in     vl_logic;
        ld_op           : in     vl_logic;
        ld_r            : in     vl_logic;
        ld_m            : in     vl_logic;
        currentOperand  : in     vl_logic_vector(12 downto 0);
        memory          : in     vl_logic_vector(12 downto 0);
        result          : in     vl_logic_vector(24 downto 0);
        operator        : in     vl_logic_vector(3 downto 0);
        storeA          : out    vl_logic_vector(12 downto 0);
        storeB          : out    vl_logic_vector(12 downto 0);
        storeResult     : out    vl_logic_vector(24 downto 0);
        storeOp         : out    vl_logic_vector(3 downto 0)
    );
end registerTransfer;
