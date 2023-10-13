LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY shift_register IS
    GENERIC (N : INTEGER := 5); -- bus width
    PORT (
        sd, clk, rst, pload : IN STD_LOGIC;
        pd : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        q : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0)
    );
END ENTITY shift_register;

ARCHITECTURE rtl OF shift_register IS
    SIGNAL pout : STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
BEGIN

    register_setup : PROCESS (clk, rst)
    BEGIN
        IF rst = '0' THEN
            pout <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            IF pload = '1' THEN
                pout <= pd;
            ELSE
                pout(N - 2 DOWNTO 0) <= pout(N - 1 DOWNTO 1);
                pout(N - 1) <= sd;
            END IF;
        END IF;
    END PROCESS register_setup;
    q <= pout;
END ARCHITECTURE rtl;