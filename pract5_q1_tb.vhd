LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY pract5_q1_tb IS
END pract5_q1_tb;

ARCHITECTURE v1 OF pract5_q1_tb IS

    COMPONENT pract5_q1 IS
        PORT (
            x, rst, clk : IN STD_LOGIC;
            z1, z2 : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL x, rst, clk, z1, z2 : STD_LOGIC;
    CONSTANT t : TIME := 50 ns;

    TYPE test_vector IS RECORD
        x, clk, rst : STD_LOGIC;
        z1, z2 : STD_LOGIC;
        t : TIME;
    END RECORD;

    TYPE test_vector_array IS ARRAY (NATURAL RANGE <>) OF test_vector;

    CONSTANT test_vectors : test_vector_array := (
        -- initialize vectors
        -- x  clk  rst  z1   z2   t
        ('-', '1', '0', '1', '1', t),
        ('-', '0', '0', '1', '1', t),
        -- goto  a -> b -> c loop
        ('1', '1', '1', '1', '0', t),
        ('1', '0', '1', '0', '0', t), -- ps=a, z1 = 0, z2 = 0
        ('1', '1', '1', '0', '0', t),
        ('1', '0', '1', '1', '1', t), -- ps=b, z1 = 1, z2 = 0
        ('1', '1', '1', '1', '1', t),
        ('1', '0', '1', '1', '0', t), -- ps=c, z1 = 1, z2 = 1
        ('0', '1', '1', '1', '1', t),
        -- goto  b -> a -> a -> b -> c loop
        ('0', '0', '1', '1', '0', t), -- ps=b, z1 = 1, z2 = 0
        ('0', '1', '1', '1', '0', t),
        ('0', '0', '1', '0', '1', t), -- ps=a, z1 = 0, z2 = 1
        ('0', '1', '1', '0', '1', t),
        ('1', '0', '1', '0', '0', t), -- ps=a, z1 = 0, z2 = 1
        ('1', '1', '1', '0', '0', t),
        ('1', '0', '1', '1', '1', t), -- ps=b, z1 = 1, z2 = 0
        ('1', '1', '1', '1', '1', t),
        ('1', '0', '1', '1', '0', t), -- ps=c, z1 = 1, z2 = 1
        ('1', '1', '1', '1', '0', t),
        -- goto  a -> b then RST loop
        ('1', '0', '1', '0', '0', t), -- ps=a, z1 = 0, z2 = 0
        ('1', '1', '1', '0', '0', t),
        ('1', '0', '1', '1', '1', t), -- ps=b, z1 = 1, z2 = 0
        ('1', '1', '0', '1', '0', t)
    );

BEGIN

    dut : pract5_q1 PORT MAP(x => x, rst => rst, clk => clk, z1 => z1, z2 => z2);

    tb : PROCESS
    BEGIN

        REPORT "Test Initializing...";
        x <= '0';
        clk <= '1';
        rst <= '0';
        WAIT FOR t;

        REPORT "TEST STARTING...";

        FOR i IN test_vectors'RANGE LOOP
            x <= test_vectors(i).x;
            clk <= test_vectors(i).clk;
            rst <= test_vectors(i).rst;
            WAIT FOR test_vectors(i).t;

            ASSERT (z1 = test_vectors(i).z1) REPORT "Z1 FAILS @ STEP" & INTEGER'image(i);
            ASSERT (z2 = test_vectors(i).z2) REPORT "Z2 FAILS @ STEP" & INTEGER'image(i);

        END LOOP;

        REPORT "TEST COMPLETE...";
        WAIT;

    END PROCESS tb;

END ARCHITECTURE v1;