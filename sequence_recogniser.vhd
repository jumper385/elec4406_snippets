LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY sequence_recogniser IS
    PORT (
        d, clk, rst : IN STD_LOGIC;
        sig : OUT STD_LOGIC
    );
END ENTITY sequence_recogniser;

ARCHITECTURE rtl OF sequence_recogniser IS

    COMPONENT d_flip_flop IS
        PORT (
            d, clk, rst : IN STD_LOGIC;
            q : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL d0, d1, q0, q1, z : STD_LOGIC;

BEGIN

    d1 <= (q1 AND NOT q0 AND NOT d) OR (NOT q1 AND q0 AND NOT d);
    d0 <= d OR (q1 OR NOT q0);
	 
	 
    z <= q1 AND q0 AND d;

    dff0 : d_flip_flop PORT MAP(d => d1, clk => clk, rst => rst, q => q1);
    dff1 : d_flip_flop PORT MAP(d => d0, clk => clk, rst => rst, q => q0);

    sig <= z;

END ARCHITECTURE rtl;

-- ARCHITECTURE rtl OF sequence_recogniser IS
--     TYPE fsm_states IS (sa, sb, sc, sd);
--     SIGNAL ps, ns : fsm_states;
-- BEGIN

--     sync_proc : PROCESS (clk, rst)
--     BEGIN
--         IF rst = '0' THEN
--             ps <= sa;
--         ELSIF falling_edge(clk) THEN
--             ps <= ns;
--         END IF;
--     END PROCESS sync_proc;

--     comb_proc : PROCESS (ps, d)
--     BEGIN
--         CASE ps IS
--             WHEN sa =>
--                 IF (d = '1') THEN
--                     sig <= '0';
--                     ns <= sb;
--                 ELSE
--                     sig <= '0';
--                     ns <= sa;
--                 END IF;

--             WHEN sb =>
--                 IF (d = '0') THEN
--                     sig <= '0';
--                     ns <= sc;
--                 ELSE
--                     sig <= '0';
--                     ns <= sb;
--                 END IF;

--             WHEN sc =>
--                 IF (d = '0') THEN
--                     sig <= '0';
--                     ns <= sd;
--                 ELSE
--                     sig <= '0';
--                     ns <= sb;
--                 END IF;

--             WHEN sd =>
--                 IF (d = '1') THEN
--                     sig <= '1';
--                     ns <= sb;
--                 ELSE
--                     sig <= '0';
--                     ns <= sa;
--                 END IF;

--             WHEN OTHERS =>
--                 sig <= '0';
--                 ns <= sa;

--         END CASE;
--     END PROCESS comb_proc;

-- END ARCHITECTURE rtl;