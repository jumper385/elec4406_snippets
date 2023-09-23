LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY dff_tb IS
END dff_tb;

ARCHITECTURE v1 OF dff_tb IS

    COMPONENT dff IS
        PORT (
            d, clk, rst : IN STD_LOGIC;
            q : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL d, clk, rst, q : STD_LOGIC;
    CONSTANT t : TIME := 50 ns;

    TYPE test_vector IS RECORD
        d, clk, rst : STD_LOGIC;
        q : STD_LOGIC;
        t : TIME;
    END RECORD;

    TYPE test_vector_array IS ARRAY (NATURAL RANGE <>) OF test_vector;

    CONSTANT test_vectors : test_vector_array := (
        -- Initialize the system; expecting q to be 0
        ('0', '0', '1', '0', t),

        -- Releasing reset with D=0 and no clock edge; expect q to remain 0
        ('0', '0', '0', '0', t),

        -- Setting D=1 without a rising clock edge; expect q to remain 0
        ('1', '0', '0', '0', t),

        -- Rising edge with D=1; q should take the value of D and become 1
        ('1', '1', '0', '1', t),

        -- Setting D=0 without a rising clock edge; q should remain 1
        ('0', '0', '0', '1', t),

        -- Rising edge with D=0; q should take the value of D and become 0
        ('0', '1', '0', '0', t),

        -- Rising edge with D=1 but with reset active; q should be 0
        ('1', '1', '1', '0', t),

        -- Releasing reset with D=1 without a clock edge; q should remain 0
        ('1', '0', '0', '0', t),

        -- Rising edge with D=1 after releasing reset; q should become 1
        ('1', '1', '0', '1', t),

        -- Apply reset without clock edge; q should become 0
        ('1', '0', '1', '0', t),

        -- Releasing reset with D=0 without a clock edge; q should remain 0
        ('0', '0', '0', '0', t)
    );

BEGIN

    dut : dff PORT MAP(d => d, clk => clk, rst => rst, q => q);

    tb : PROCESS
    BEGIN

        REPORT "Test Initializing...";

        d <= '0';
        clk <= '0';
        rst <= '0';
        WAIT FOR t;

        REPORT "Test Starting...";

        FOR i IN test_vectors'RANGE LOOP

            clk <= test_vectors(i).clk;
            d <= test_vectors(i).d;
            rst <= test_vectors(i).rst;
            WAIT FOR test_vectors(i).t;

            ASSERT (q = test_vectors(i).q) REPORT "Q Failed @ STEP:" & INTEGER'image(i);

        END LOOP;
        REPORT "Test Complete...";
        WAIT;

    END PROCESS;
END v1;