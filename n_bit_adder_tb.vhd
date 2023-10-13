LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY n_bit_adder_tb IS
    GENERIC (bit_depth : INTEGER := 9); -- default is 10
END ENTITY n_bit_adder_tb;

ARCHITECTURE v1 OF n_bit_adder_tb IS

    -- Declare the component under test (DUT) here.
    COMPONENT n_bit_adder IS
        GENERIC (bit_depth : INTEGER := 9); -- default is 10
        PORT (
            x1, x2 : IN STD_LOGIC_VECTOR(bit_depth - 1 DOWNTO 0);
            cin : IN STD_LOGIC;
            q : OUT STD_LOGIC_VECTOR(bit_depth - 1 DOWNTO 0);
            cout : OUT STD_LOGIC
        );
    END COMPONENT;

    -- Declare the signals to be used in your test bench here.
    SIGNAL x1_signal, x2_signal : STD_LOGIC_VECTOR(bit_depth - 1 DOWNTO 0);
    SIGNAL cin_signal, cout_signal : STD_LOGIC;
    SIGNAL q_signal : STD_LOGIC_VECTOR(bit_depth - 1 DOWNTO 0);

    -- Set a time constant
    CONSTANT time_delay : TIME := 50 ns;

    -- Define the structure of your test vector here.
    TYPE test_vector IS RECORD
        x1_val, x2_val : STD_LOGIC_VECTOR(bit_depth - 1 DOWNTO 0);
        cin_val : STD_LOGIC;
        expected_q : STD_LOGIC_VECTOR(bit_depth - 1 DOWNTO 0);
        expected_cout : STD_LOGIC;
    END RECORD;

    TYPE test_vector_array IS ARRAY (NATURAL RANGE <>) OF test_vector;

    -- Define your test vectors here.
    CONSTANT test_vectors : test_vector_array := (

        ("000000000", "000000001", '0', "000000001", '0'),
        ("000000001", "000000001", '0', "000000010", '0'),
        ("000100001", "000000001", '0', "000100010", '0'),
        ("111111111", "000000001", '0', "000000000", '0')
    );

BEGIN

    dut : n_bit_adder PORT MAP(
        x1 => x1_signal,
        x2 => x2_signal,
        cin => cin_signal,
        q => q_signal,
        cout => cout_signal
    );

    tb : PROCESS
    BEGIN

        REPORT "Test Initializing...";

        -- Initialize signals before running the test.
        x1_signal <= "000000000";
        x2_signal <= "000000000";
        cin_signal <= '0';
        WAIT FOR time_delay;

        REPORT "Test Starting...";

        FOR i IN test_vectors'RANGE LOOP

            -- Apply the test vector inputs to the signals.
            x1_signal <= test_vectors(i).x1_val;
            x2_signal <= test_vectors(i).x2_val;
            cin_signal <= test_vectors(i).cin_val;
            WAIT FOR time_delay;

            -- Check the expected outputs.
            ASSERT (q_signal = test_vectors(i).expected_q)
            REPORT "Mismatch in sum @ STEP:" & INTEGER'image(i);
            ASSERT (cout_signal = test_vectors(i).expected_cout)
            REPORT "Mismatch in carry out @ STEP:" & INTEGER'image(i);

        END LOOP;

        REPORT "Test Complete...";
        WAIT;

    END PROCESS;

END v1;