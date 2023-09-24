LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY shift_register_tb IS
END shift_register_tb;

ARCHITECTURE v1 OF shift_register_tb IS

    COMPONENT shift_register IS
        GENERIC (N : INTEGER := 8); -- bus width
        PORT (
            sd, clk, rst, pload : IN STD_LOGIC;
            pd : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            q : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL sd, clk, rst, pload : STD_LOGIC;
    SIGNAL pd, q : STD_LOGIC_VECTOR(7 DOWNTO 0);
    CONSTANT t : TIME := 50 ns;

    TYPE test_vector IS RECORD
        sd, clk, rst, pload : STD_LOGIC;
        pd : STD_LOGIC_VECTOR(7 DOWNTO 0);
        q : STD_LOGIC_VECTOR(7 DOWNTO 0);
        t : TIME;
    END RECORD;

    TYPE test_vector_array IS ARRAY (NATURAL RANGE <>) OF test_vector;

    CONSTANT test_vectors : test_vector_array := (
    -- Initialize and Reset
    --sd  clk  rst  pload,  pd,       q,         t
    ('-', '0', '1', '-', "00000000", "00000000", t),
    ('-', '1', '1', '-', "00000000", "00000000", t),

    -- Parallel Load 10101010
    ('-', '0', '0', '1', "10101010", "00000000", t),
    ('-', '1', '0', '1', "10101010", "10101010", t),

    -- Right shift and check the outputs
    ('1', '0', '0', '0', "--------", "10101010", t),
    ('1', '1', '0', '0', "--------", "11010101", t),
    ('0', '0', '0', '0', "--------", "11010101", t),
    ('0', '1', '0', '0', "--------", "01101010", t),

    -- Parallel Load 01010101
    ('-', '0', '0', '1', "01010101", "01101010", t),
    ('-', '1', '0', '1', "01010101", "01010101", t),

    -- Right shift
    ('1', '0', '0', '0', "--------", "01010101", t),
    ('1', '1', '0', '0', "--------", "10101010", t),
    ('0', '0', '0', '0', "--------", "10101010", t),
    ('0', '1', '0', '0', "--------", "01010101", t),

    -- Parallel Load 11110000
    ('-', '0', '0', '1', "11110000", "01010101", t),
    ('-', '1', '0', '1', "11110000", "11110000", t),

    -- Right shift
    ('1', '0', '0', '0', "--------", "11110000", t),
    ('1', '1', '0', '0', "--------", "11111000", t),
    ('0', '0', '0', '0', "--------", "11111000", t),
    ('0', '1', '0', '0', "--------", "01111100", t),
    -- Parallel Load 00001111
    ('-', '0', '0', '1', "00001111", "01111100", t),
    ('-', '1', '0', '1', "00001111", "00001111", t),

    -- Right shift with sd=1
    ('1', '0', '0', '0', "--------", "00001111", t),
    ('1', '1', '0', '0', "--------", "10000111", t),
    ('1', '0', '0', '0', "--------", "10000111", t),
    ('1', '1', '0', '0', "--------", "11000011", t),

    -- Parallel Load 10000001
    ('-', '0', '0', '1', "10000001", "11000011", t),
    ('-', '1', '0', '1', "10000001", "10000001", t),

    -- Right shift with sd=0
    ('0', '0', '0', '0', "--------", "10000001", t),
    ('0', '1', '0', '0', "--------", "01000000", t),
    ('0', '0', '0', '0', "--------", "01000000", t),
    ('0', '1', '0', '0', "--------", "00100000", t),

    -- Parallel Load 11111111
    ('-', '0', '0', '1', "11111111", "00100000", t),
    ('-', '1', '0', '1', "11111111", "11111111", t),

    -- Right shift with sd alternating between 1 and 0
    ('1', '0', '0', '0', "--------", "11111111", t),
    ('1', '1', '0', '0', "--------", "11111111", t),
    ('0', '0', '0', '0', "--------", "11111111", t),
    ('0', '1', '0', '0', "--------", "01111111", t),
    ('1', '0', '0', '0', "--------", "01111111", t),
    ('1', '1', '0', '0', "--------", "10111111", t)
    );
BEGIN

    dut : shift_register PORT MAP(sd => sd, clk => clk, rst => rst, pload => pload, pd => pd, q => q);

    tb : PROCESS
    BEGIN

        REPORT "Test Initializing...";

        sd <= '0';
        clk <= '0';
        rst <= '0';
        pload <= '0';
        pd <= "00000000";
        WAIT FOR t;

        REPORT "Test Starting...";

        FOR i IN test_vectors'RANGE LOOP

            clk <= test_vectors(i).clk;
            sd <= test_vectors(i).sd;
            rst <= test_vectors(i).rst;
            pload <= test_vectors(i).pload;
            IF test_vectors(i).pd /= "-" THEN
                pd <= test_vectors(i).pd;
            END IF;
            WAIT FOR test_vectors(i).t;

            ASSERT (q = test_vectors(i).q) REPORT "Q Failed @ STEP:" & INTEGER'image(i);

        END LOOP;
        REPORT "Test Complete...";
        WAIT;

    END PROCESS;
END v1;