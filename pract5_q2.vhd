LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY pract5_q2 IS
    PORT (
        x1, set, clr, clk : IN STD_LOGIC;
        z1, z2 : OUT STD_LOGIC
    );
END ENTITY pract5_q2;

ARCHITECTURE rtl OF pract5_q2 IS
    TYPE fsm_states IS (sa, sb, sc, sd);
    SIGNAL ps, ns : fsm_states;
BEGIN

    sync_proc : PROCESS (set, clr, clk)
    BEGIN
        IF (set = '0') THEN
            ps <= sa;
        ELSIF (clr = '0') THEN
            ps <= sd;
        ELSIF rising_edge(clk) THEN
            ps <= ns;
        END IF;
    END PROCESS;

    comb_proc : PROCESS (ps, x1)
    BEGIN
        CASE ps IS
            WHEN sa =>
                IF (x1 = '0') THEN
                    ns <= sb;
                    z1 <= '0';
                    z2 <= '0';
                ELSE
                    ns <= sa;
                    z1 <= '0';
                    z2 <= '0';
                END IF;
            WHEN sb =>
                IF (x1 = '0') THEN
                    ns <= sb;
                    z1 <= '1';
                    z2 <= '0';
                ELSE
                    ns <= sc;
                    z1 <= '1';
                    z2 <= '1';
                END IF;

            WHEN sc =>
                IF (x1 = '1') THEN
                    ns <= sb;
                    z1 <= '0';
                    z2 <= '0';
                ELSE
                    ns <= sc;
                    z1 <= '0';
                    z2 <= '1';
                END IF;

            WHEN sd =>
                IF (x1 = '1') THEN
                    ns <= sd;
                    z1 <= '1';
                    z2 <= '1';
                ELSE
                    ns <= sc;
                    z1 <= '1';
                    z2 <= '0';
                END IF;

            WHEN OTHERS =>
                ns <= sa;
                z1 <= '0';
                z2 <= '0';
        END CASE;
    END PROCESS;

END ARCHITECTURE rtl;