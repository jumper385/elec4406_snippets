LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY full_adder_tb IS
END ENTITY full_adder_tb;

ARCHITECTURE v1 OF full_adder_tb IS

    -- Declare the component under test (DUT) here.
    COMPONENT full_adder IS
        PORT (
            -- Declare the ports of your DUT here.
            -- Example: clk : IN STD_LOGIC;
            a, b, cin : IN STD_LOGIC;
            s, cout : OUT STD_LOGIC
        );
    END COMPONENT;

    -- Declare the signals to be used in your test bench here.
    -- Example: SIGNAL clk : STD_LOGIC;
    SIGNAL a, b, cin, s, cout : STD_LOGIC;

    -- Set a time constant
    CONSTANT time_delay : TIME := 50 ns;

    -- Define the structure of your test vector here.
    TYPE test_vector IS RECORD
        -- Declare fields of the test vector here.
        -- Example: clk : STD_LOGIC;
        -- Example: expected_output : STD_LOGIC_VECTOR(4 DOWNTO 0);
        a, b, cin : STD_LOGIC;
    END RECORD;

    TYPE test_vector_array IS ARRAY (NATURAL RANGE <>) OF test_vector;

    -- Define your test vectors here.
    CONSTANT test_vectors : test_vector_array := (
        -- Example test vectors; populate based on your specific test case.
        -- Example: ('0', "00000"),
        ('0', '0', '0'),
        ('1', '0', '0'),
        ('1', '0', '1'),
        ('0', '1', '0'),
        ('0', '1', '1'),
        ('1', '1', '1'),
        ('0', '0', '1')
    );

BEGIN

    dut : full_adder PORT MAP(
        -- Map the test bench signals to the DUT ports here.
        -- Example: clk => clk,
        a => a,
        b => b,
        cin => cin,
        s => s,
        cout => cout
    );

    tb : PROCESS
    BEGIN

        REPORT "Test Initializing...";

        -- Initialize signals before running the test.
        -- Example: clk <= '0';
        a <= '0';
        b <= '0';
        cin <= '0';
        WAIT FOR time_delay;

        REPORT "Test Starting...";

        FOR i IN test_vectors'RANGE LOOP

            -- Apply the test vector inputs to the signals.
            -- Example: clk <= test_vectors(i).clk;
            a <= test_vectors(i).a;
            b <= test_vectors(i).b;
            cin <= test_vectors(i).cin;
            WAIT FOR time_delay;

            -- Check the expected outputs.
            -- Example: ASSERT (output = test_vectors(i).expected_output) REPORT "Mismatch @ STEP:" & INTEGER'image(i);

        END LOOP;

        REPORT "Test Complete...";
        WAIT;

    END PROCESS;

END v1;