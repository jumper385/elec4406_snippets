LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY moore_detector_tb IS
END moore_detector_tb;

ARCHITECTURE v1 OF moore_detector_tb IS

    COMPONENT moore_detector IS
        PORT (
            x, clk, rst : IN STD_LOGIC;
            z : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL x, clk, rst, z : STD_LOGIC;
    CONSTANT t : TIME := 50 ns;

    TYPE test_vector IS RECORD
        x, clk, rst : STD_LOGIC;
        z : STD_LOGIC;
        t : TIME;
    END RECORD;

    TYPE test_vector_array IS ARRAY (NATURAL RANGE <>) OF test_vector;

    CONSTANT test_vectors : test_vector_array := (
        -- Initialize
        ('-', '0', '1', '0', t),
        ('-', '1', '1', '0', t),

        -- Test sequence 1001
        ('1', '0', '0', '0', t),
        ('1', '1', '0', '0', t),

        ('0', '0', '0', '0', t),
        ('0', '1', '0', '0', t),

        ('0', '0', '0', '0', t),
        ('0', '1', '0', '0', t),

        ('1', '0', '0', '0', t),
        ('1', '1', '0', '1', t), -- Recognize the sequence.

        -- Reset
        ('-', '0', '1', '0', t),
        ('-', '1', '1', '0', t),

        -- And so on for other sequences...

        -- Test sequence 1001 again
        ('1', '0', '0', '0', t),
        ('1', '1', '0', '0', t),

        ('0', '0', '0', '0', t),
        ('0', '1', '0', '0', t),

        ('0', '0', '0', '0', t),
        ('0', '1', '0', '0', t),

        ('1', '0', '0', '0', t),
        ('1', '1', '0', '1', t) -- Recognize the sequence.
    );

BEGIN

    dut : moore_detector PORT MAP(x => x, clk => clk, rst => rst, z => z);

    tb : PROCESS
    BEGIN

        REPORT "Test Initializing...";

        x <= '0';
        clk <= '0';
        rst <= '0';
        WAIT FOR t;

        REPORT "Test Starting...";

        FOR i IN test_vectors'RANGE LOOP

            clk <= test_vectors(i).clk;
            x <= test_vectors(i).x;
            rst <= test_vectors(i).rst;
            WAIT FOR test_vectors(i).t;

            ASSERT (z = test_vectors(i).z) REPORT "Z Failed @ STEP:" & INTEGER'image(i);

        END LOOP;
        REPORT "Test Complete...";
        WAIT;

    END PROCESS;
END v1;