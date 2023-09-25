LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY pract5_q3_tb IS
END ENTITY pract5_q3_tb;

ARCHITECTURE rtl OF pract5_q3_tb IS
    COMPONENT pract5_q3 IS
        PORT (
            x, clk, rst : IN STD_LOGIC;
            z1, z2 : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL x, clk, rst, z1, z2 : STD_LOGIC;
    CONSTANT t : TIME := 50 ns;

    TYPE test_vector IS RECORD
        x, clk, rst : STD_LOGIC;
        z1, z2 : STD_LOGIC;
        t : TIME;
    END RECORD;

    TYPE test_vector_array IS ARRAY (NATURAL RANGE <>) OF test_vector;

    CONSTANT test_vectors : test_vector_array := (
        -- start SA sequence
        -- x  clk  rst   z1   z2  t
        ('1', '0', '1', '0', '0', t),
        ('1', '1', '1', '0', '0', t), -- st000
        ('1', '0', '1', '0', '0', t),
        ('1', '1', '1', '0', '0', t), -- st001
        ('1', '0', '1', '0', '0', t),
        ('1', '1', '1', '0', '0', t), -- st010
        ('1', '0', '1', '0', '0', t),
        ('1', '1', '1', '0', '1', t), -- st011
        ('1', '0', '1', '0', '1', t),
        ('1', '1', '1', '1', '0', t), -- st100
        ('1', '0', '1', '1', '0', t),
        ('1', '1', '1', '1', '1', t), -- st101
        ('1', '0', '1', '1', '1', t),
        ('1', '1', '1', '1', '1', t), -- st110
        ('1', '0', '1', '1', '1', t),
        ('1', '1', '1', '1', '1', t), -- st111
        ('1', '0', '1', '0', '0', t),
        ('1', '1', '1', '0', '0', t) -- st000
    );
BEGIN

    dut : pract5_q3 PORT MAP(x => x, clk => clk, rst => rst, z1 => z1, z2 => z2);

    tb_proc : PROCESS
    BEGIN

        REPORT "Test Initializing...";

        x <= '0';
        clk <= '0';
        rst <= '1';
        WAIT FOR t;

        REPORT "Test Starting...";

        FOR i IN test_vectors'RANGE LOOP

            clk <= test_vectors(i).clk;
            x <= test_vectors(i).x;
            rst <= test_vectors(i).rst;
            WAIT FOR test_vectors(i).t;

            ASSERT (z1 = test_vectors(i).z1) REPORT "z1 Failed @ STEP:" & INTEGER'image(i);
            ASSERT (z2 = test_vectors(i).z2) REPORT "z2 Failed @ STEP:" & INTEGER'image(i);

        END LOOP;
        REPORT "Test Complete...";
        WAIT;
    END PROCESS tb_proc;

END ARCHITECTURE rtl;