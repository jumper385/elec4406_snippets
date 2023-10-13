LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY generic_tb IS
END ENTITY generic_tb;

ARCHITECTURE v1 OF generic_tb IS

    -- Declare the component under test (DUT) here.
    COMPONENT DUT_NAME IS
        PORT (
            -- Declare the ports of your DUT here.
            -- Example: clk : IN STD_LOGIC;
        );
    END COMPONENT;

    -- Declare the signals to be used in your test bench here.
    -- Example: SIGNAL clk : STD_LOGIC;

    -- Set a time constant
    CONSTANT time_delay : TIME := 50 ns;

    -- Define the structure of your test vector here.
    TYPE test_vector IS RECORD
        -- Declare fields of the test vector here.
        -- Example: clk : STD_LOGIC;
        -- Example: expected_output : STD_LOGIC_VECTOR(4 DOWNTO 0);
    END RECORD;

    TYPE test_vector_array IS ARRAY (NATURAL RANGE <>) OF test_vector;

    -- Define your test vectors here.
    CONSTANT test_vectors : test_vector_array := (
        -- Example test vectors; populate based on your specific test case.
        -- Example: ('0', "00000"),
    );

BEGIN

    dut : DUT_NAME PORT MAP(
        -- Map the test bench signals to the DUT ports here.
        -- Example: clk => clk,
    );

    tb : PROCESS
    BEGIN

        REPORT "Test Initializing...";

        -- Initialize signals before running the test.
        -- Example: clk <= '0';
        WAIT FOR time_delay;

        REPORT "Test Starting...";

        FOR i IN test_vectors'RANGE LOOP

            -- Apply the test vector inputs to the signals.
            -- Example: clk <= test_vectors(i).clk;
            WAIT FOR time_delay;

            -- Check the expected outputs.
            -- Example: ASSERT (output = test_vectors(i).expected_output) REPORT "Mismatch @ STEP:" & INTEGER'image(i);

        END LOOP;

        REPORT "Test Complete...";
        WAIT;

    END PROCESS;

END v1;