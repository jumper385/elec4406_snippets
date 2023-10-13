LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY tfff IS
    PORT (
        t, clk, clr : IN STD_LOGIC;
        q : OUT STD_LOGIC
    );
END ENTITY tfff;

ARCHITECTURE rtl OF tfff IS
    SIGNAL tmp : STD_LOGIC;
BEGIN

    PROCESS (clk, clr)
    BEGIN
        IF clr = '0' THEN
            tmp <= '0';
        ELSIF rising_edge(clk) THEN
            tmp <= (NOT tmp) AND (t);
        END IF;
    END PROCESS;

    q <= tmp;
END ARCHITECTURE rtl;