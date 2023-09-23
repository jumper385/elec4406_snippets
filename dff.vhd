LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY dff IS
    PORT (
        d, clk, rst : IN STD_LOGIC;
        q : OUT STD_LOGIC
    );
END dff;

ARCHITECTURE rtl OF dff IS

BEGIN

    dff_proc : PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            q <= '0';
        ELSIF rising_edge(clk) THEN
            q <= d;
        END IF;
    END PROCESS dff_proc;

END ARCHITECTURE rtl;