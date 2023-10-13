LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY counter_tb IS
END ENTITY counter_tb;

ARCHITECTURE v1 OF counter_tb IS

    -- Declare the component under test (DUT) here.
    COMPONENT counter IS
        GENERIC (
            threshold : INTEGER := 5
        );
        PORT (
            clk : IN STD_LOGIC;
            q : OUT STD_LOGIC;
            rst : IN STD_LOGIC;
            bypass_thresh : IN STD_LOGIC
        );
    END COMPONENT;

    -- Declare the signals to be used in your test bench here.
    SIGNAL clk, q, rst, bypass_thresh : STD_LOGIC;

    -- Set time constant
    CONSTANT time_delay : TIME := 50 ns;

    -- Define the structure of your test vector here.
    TYPE test_vector IS RECORD
        -- Declare fields of the test vector here.
        clk : STD_LOGIC;
        rst : STD_LOGIC;
        bypass_thresh : STD_LOGIC;
    END RECORD;

    TYPE test_vector_array IS ARRAY (NATURAL RANGE <>) OF test_vector;

    -- Define your test vectors here.
    CONSTANT test_vectors : test_vector_array := (
        -- Example test vectors; populate based on your specific test case.
        -- clk  rst thres_rst
        ('0', '1', '1'),
        ('1', '1', '1'),
        ('0', '1', '1'),
        ('1', '1', '1'),
        ('0', '1', '1'),
        ('1', '1', '1'),
        ('0', '1', '1'),
        ('1', '1', '1'),
        ('0', '1', '1'),
        ('1', '1', '1'),
        ('0', '1', '1'),
        ('1', '1', '1'),
        ('0', '1', '1'),
        ('1', '1', '1'),
        ('0', '1', '1'),
        ('1', '1', '1'),
        ('0', '1', '1'),
        ('1', '1', '0'),
        ('0', '1', '0'),
        ('1', '1', '0'),
        ('0', '1', '0'),
        ('1', '1', '0'),
        ('0', '1', '0'),
        ('1', '1', '0'),
        ('0', '1', '0'),
        ('1', '1', '0'),
        ('0', '1', '0'),
        ('1', '1', '0'),
        ('0', '1', '0'),
        ('1', '1', '0'),
        ('0', '1', '0'),
        ('1', '1', '0'),
        ('0', '1', '0')
    );

BEGIN

    dut : counter PORT MAP(
        -- Map the test bench signals to the DUT ports here.
        clk => clk,
        q => q,
        rst => rst,
        bypass_thresh => bypass_thresh
    );

    tb : PROCESS
    BEGIN

        REPORT "Test Initializing...";

        -- Initialize signals before running the test.
        rst <= '0';
        WAIT FOR time_delay;

        REPORT "Test Starting...";

        FOR i IN test_vectors'RANGE LOOP

            -- Apply the test vector inputs to the signals.
            -- Example: clk <= test_vectors(i).clk;
            clk <= test_vectors(i).clk;
            rst <= test_vectors(i).rst;
            bypass_thresh <= test_vectors(i).bypass_thresh;

            WAIT FOR time_delay;

            -- Check the expected outputs.
            -- Example: ASSERT (output = test_vectors(i).expected_output) REPORT "Mismatch @ STEP:" & INTEGER'image(i);

        END LOOP;

        REPORT "Test Complete...";
        WAIT;

    END PROCESS;

END v1;