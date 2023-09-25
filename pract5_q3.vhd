LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY pract5_q3 IS
    PORT (
        x, clk, rst : IN STD_LOGIC;
        z1, z2 : OUT STD_LOGIC
    );
END ENTITY pract5_q3;

ARCHITECTURE rtl OF pract5_q3 IS
    TYPE fsm_states IS (st000, st001, st010, st011, st100, st101, st110, st111);
    SIGNAL ps, ns : fsm_states;
BEGIN

    sync_process : PROCESS (clk, rst)
    BEGIN
        IF (rst = '0') THEN
            ps <= st000;
        ELSIF rising_edge(clk) THEN
            ps <= ns;
        END IF;
    END PROCESS;

    comb_process : PROCESS (ps, x)
    BEGIN

        CASE ps IS
            WHEN st000 =>
                z1 <= '0';
                z2 <= '0';
                IF (x = '0') THEN
                    ns <= st000;
                ELSE
                    ns <= st001;
                END IF;
            WHEN st001 =>
                z1 <= '0';
                z2 <= '0';
                IF (x = '0') THEN
                    ns <= st001;
                ELSE
                    ns <= st010;
                END IF;

            WHEN st010 =>
                z1 <= '0';
                z2 <= '0';
                IF (x = '0') THEN
                    ns <= st010;
                ELSE
                    ns <= st011;
                END IF;

            WHEN st011 =>
                z1 <= '0';
                z2 <= '1';
                IF (x = '0') THEN
                    ns <= st011;
                ELSE
                    ns <= st100;
                END IF;

            WHEN st100 =>
                z1 <= '1';
                z2 <= '0';
                IF (x = '0') THEN
                    ns <= st000;
                ELSE
                    ns <= st101;
                END IF;

            WHEN st101 =>
                z1 <= '1';
                z2 <= '1';
                IF (x = '0') THEN
                    ns <= st101;
                ELSE
                    ns <= st110;
                END IF;

            WHEN st110 =>
                z1 <= '1';
                z2 <= '1';
                IF (x = '0') THEN
                    ns <= st110;
                ELSE
                    ns <= st111;
                END IF;

            WHEN st111 =>
                z1 <= '1';
                z2 <= '1';
                IF (x = '0') THEN
                    ns <= st111;
                ELSE
                    ns <= st000;
                END IF;

            WHEN OTHERS =>
                z1 <= '0';
                z2 <= '0';
                ns <= st000;

        END CASE;

    END PROCESS;

END ARCHITECTURE rtl;