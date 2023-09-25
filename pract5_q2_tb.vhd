LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY pract5_q2_tb IS
END ENTITY pract5_q2_tb;

ARCHITECTURE rtl OF pract5_q2_tb IS
    COMPONENT pract5_q2 IS
        PORT (
            x1, set, clr, clk : IN STD_LOGIC;
            z1, z2 : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL x1, set, clr, clk, z1, z2 : STD_LOGIC;
    CONSTANT t : TIME := 50 ns;

    TYPE test_vector IS RECORD
        x1, set, clr, clk : STD_LOGIC;
        z1, z2 : STD_LOGIC;
        t : TIME;
    END RECORD;

    TYPE test_vector_array IS ARRAY (NATURAL RANGE <>) OF test_vector;

    CONSTANT test_vectors : test_vector_array := (
        -- start SA sequence
        -- x1 set  clr  clk  z1   z2   t
        ('1', '1', '0', '0', '0', '0', t),
        ('1', '1', '0', '1', '0', '0', t), -- set ps=sa
        ('1', '0', '0', '0', '0', '0', t),
        ('0', '0', '0', '0', '0', '0', t),
        ('0', '0', '0', '1', '1', '0', t), -- move ps=b
        ('0', '0', '0', '0', '1', '0', t),
        ('1', '0', '0', '0', '1', '1', t),
        ('1', '0', '0', '1', '0', '0', t), -- move ps=c
        ('0', '0', '0', '1', '0', '1', t),
        -- clear to SD sequence
        ('0', '0', '1', '0', '1', '0', t), -- check ps=d
        ('0', '0', '0', '0', '1', '0', t),
        ('1', '0', '0', '0', '1', '1', t),
        ('1', '0', '0', '1', '1', '1', t),
        ('0', '0', '0', '0', '1', '0', t),
        ('0', '0', '0', '1', '0', '1', t),
        -- cycle back to SB
        ('1', '0', '0', '1', '0', '0', t), -- move to ps=c
        ('1', '0', '0', '0', '0', '0', t),
        ('1', '0', '0', '1', '1', '1', t) -- move to ps=b
    );
BEGIN

    dut : pract5_q2 PORT MAP(x1 => x1, set => set, clr => clr, clk => clk, z1 => z1, z2 => z2);

    tb_proc : PROCESS
    BEGIN

        REPORT "Test Initializing...";

        x1 <= '0';
        clk <= '0';
        set <= '0';
        clr <= '0';
        WAIT FOR t;

        REPORT "Test Starting...";

        FOR i IN test_vectors'RANGE LOOP

            clk <= test_vectors(i).clk;
            x1 <= test_vectors(i).x1;
            set <= test_vectors(i).set;
            clr <= test_vectors(i).clr;
            WAIT FOR test_vectors(i).t;

            ASSERT (z1 = test_vectors(i).z1) REPORT "z1 Failed @ STEP:" & INTEGER'image(i);
            ASSERT (z2 = test_vectors(i).z2) REPORT "z2 Failed @ STEP:" & INTEGER'image(i);

        END LOOP;
        REPORT "Test Complete...";
        WAIT;
    END PROCESS tb_proc;

END ARCHITECTURE rtl;