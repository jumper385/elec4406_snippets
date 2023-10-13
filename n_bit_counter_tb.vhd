LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY n_bit_counter_tb IS
END ENTITY n_bit_counter_tb;

ARCHITECTURE v1 OF n_bit_counter_tb IS

    COMPONENT n_bit_counter IS
        PORT (
            clk, reset, enable : IN STD_LOGIC;
            count : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk, reset, enable : STD_LOGIC;
    SIGNAL count : STD_LOGIC_VECTOR(3 DOWNTO 0);
    CONSTANT t : TIME := 50 ns;

    TYPE test_vector IS RECORD
        clk, reset, enable : STD_LOGIC;
        count : STD_LOGIC_VECTOR(3 DOWNTO 0);
        t : TIME;
    END RECORD;

    TYPE test_vector_array IS ARRAY (NATURAL RANGE <>) OF test_vector;

    CONSTANT test_vectors : test_vector_array := (
    -- Initialize
    ('0', '0', '0', "----", t),
    ('1', '0', '0', "----", t),

    -- Count sequence from 0 to 15
    ('1', '0', '1', "0000", t),
    ('0', '0', '1', "0000", t),
    ('1', '0', '1', "0001", t),
    ('0', '0', '1', "0001", t),
    ('1', '0', '1', "0010", t),
    ('0', '0', '1', "0010", t),
    ('1', '0', '1', "0011", t),
    ('0', '0', '1', "0011", t),
    ('1', '0', '1', "0100", t),
    ('1', '0', '1', "0101", t),
    ('1', '0', '1', "0110", t),
    ('1', '0', '1', "0111", t),
    ('1', '0', '0', "1000", t),
    ('1', '0', '0', "1001", t),
    ('1', '0', '0', "1010", t),
    ('1', '0', '0', "1011", t),
    ('1', '0', '0', "1100", t),
    ('1', '0', '0', "1101", t),
    ('1', '0', '0', "1110", t),
    ('1', '0', '0', "1111", t),

    -- Reset
    ('1', '1', '1', "----", t),
    ('1', '1', '0', "0000", t) -- After reset, count should be zero.
    );
BEGIN

    dut : n_bit_counter PORT MAP(clk => clk, reset => reset, enable => enable, count => count);

    tb : PROCESS
    BEGIN

        REPORT "Test Initializing...";

        clk <= '0';
        reset <= '1';
        enable <= '0';
        WAIT FOR t;

        REPORT "Test Starting...";

        FOR i IN test_vectors'RANGE LOOP

            clk <= test_vectors(i).clk;
            reset <= test_vectors(i).reset;
            enable <= test_vectors(i).enable;
            WAIT FOR test_vectors(i).t;

            ASSERT (count = test_vectors(i).count) REPORT "Count Failed @ STEP:" & INTEGER'image(i);

        END LOOP;
        REPORT "Test Complete...";
        WAIT;

    END PROCESS;
END v1;