LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY moore_detector IS
    PORT (
        x, clk, rst : IN STD_LOGIC;
        z : OUT STD_LOGIC
    );
END ENTITY moore_detector;

ARCHITECTURE rtl OF moore_detector IS
    TYPE fsm_states IS (sa, sb, sc, sd, se);
    SIGNAL ps, ns : fsm_states;
BEGIN

    sync_proc : PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            ps <= sa;
        ELSIF rising_edge(clk) THEN
            ps <= ns;
        END IF;
    END PROCESS sync_proc;

    comb_proc : PROCESS (ps, clk)
    BEGIN
        CASE ps IS
            WHEN sa =>
                z <= '0';
                IF (x = '1') THEN
                    ns <= sb;
                ELSE
                    ns <= sa;
                END IF;

            WHEN sb =>
                z <= '0';
                IF (x = '0') THEN
                    ns <= sc;
                ELSE
                    ns <= sb;
                END IF;

            WHEN sc =>
                z <= '0';
                IF (x = '0') THEN
                    ns <= sd;
                ELSE
                    ns <= sb;
                END IF;

            WHEN sd =>
                z <= '0';
                IF (x = '1') THEN
                    ns <= se;
                ELSE
                    ns <= sa;
                END IF;

            WHEN se =>
                z <= '1';
                IF (x = '1') THEN
                    ns <= sb;
                ELSE
                    ns <= sc;
                END IF;

            WHEN OTHERS =>
                z <= '0';
                ns <= sa;

        END CASE;
    END PROCESS comb_proc;

END ARCHITECTURE rtl;