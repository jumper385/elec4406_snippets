LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY d_flip_flop IS
    PORT (
        d, clk, rst : IN STD_LOGIC;
        q : OUT STD_LOGIC
    );
END d_flip_flop;

ARCHITECTURE rtl OF d_flip_flop IS

BEGIN

    dff_proc : PROCESS (clk, rst)
    BEGIN
        IF rst = '0' THEN
            q <= '0';
        ELSIF falling_edge(clk) THEN
            q <= d;
        END IF;
    END PROCESS dff_proc;

END ARCHITECTURE rtl;