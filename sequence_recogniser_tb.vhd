LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY sequence_recogniser_tb IS
END sequence_recogniser_tb;

ARCHITECTURE v1 OF sequence_recogniser_tb IS

    COMPONENT sequence_recogniser IS
        PORT (
            d, clk, rst : IN STD_LOGIC;
            sig : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL d, clk, rst, sig : STD_LOGIC;
    CONSTANT t : TIME := 50 ns;

    TYPE test_vector IS RECORD
        d, clk, rst : STD_LOGIC;
        sig : STD_LOGIC;
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

        ('1', '0', '0', '1', t),
        ('1', '1', '0', '1', t), -- Recognize the sequence.

        -- Reset
        ('-', '0', '1', '0', t),
        ('-', '1', '1', '0', t),

        -- Test sequence 1010 (not recognized)
        ('1', '0', '0', '0', t),
        ('1', '1', '0', '0', t),

        ('0', '0', '0', '0', t),
        ('0', '1', '0', '0', t),

        ('1', '0', '0', '0', t),
        ('1', '1', '0', '0', t),

        ('0', '0', '0', '0', t),
        ('0', '1', '0', '0', t),

        -- Test sequence 1010 (not recognized)
        ('1', '0', '0', '0', t),
        ('1', '1', '0', '0', t),

        ('0', '0', '0', '0', t),
        ('0', '1', '0', '0', t),

        ('1', '0', '0', '0', t),
        ('1', '1', '0', '0', t),

        ('1', '0', '0', '0', t),
        ('1', '1', '0', '1', t),

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

    dut : sequence_recogniser PORT MAP(d => d, clk => clk, rst => rst, sig => sig);

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

            ASSERT (sig = test_vectors(i).sig) REPORT "SIG Failed @ STEP:" & INTEGER'image(i);

        END LOOP;
        REPORT "Test Complete...";
        WAIT;

    END PROCESS;
END v1;