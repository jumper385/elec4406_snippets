LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY pract5_q1 IS
    PORT (
        x, rst, clk : IN STD_LOGIC;
        z1, z2 : OUT STD_LOGIC
    );
END ENTITY pract5_q1;

ARCHITECTURE rtl OF pract5_q1 IS
    TYPE fsm_states IS (c, a, b);
    SIGNAL ps, ns : fsm_states;
BEGIN

    sync_proc : PROCESS (clk, rst)
    BEGIN
        IF (rst = '0') THEN
            ps <= c;
        ELSIF rising_edge(clk) THEN
            ps <= ns;
        END IF;
    END PROCESS; -- sync_proc

    comb_proc : PROCESS (ps, x)
    BEGIN

        CASE ps IS
            WHEN a =>
                z1 <= '0';
                IF (x = '0') THEN
                    ns <= a;
                    z2 <= '1';
                ELSE
                    ns <= b;
                    z2 <= '0';
                END IF;

            WHEN b =>
                z1 <= '1';
                IF (x = '0') THEN
                    z2 <= '0';
                    ns <= a;
                ELSE
                    z2 <= '1';
                    ns <= c;
                END IF;

            WHEN c =>
                z1 <= '1';
                IF (x = '0') THEN
                    z2 <= '1';
                    ns <= b;
                ELSE
                    z2 <= '0';
                    ns <= a;
                END IF;

        END CASE;

    END PROCESS; -- comb_proc

END ARCHITECTURE rtl;