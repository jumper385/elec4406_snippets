LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY n_bit_counter IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        enable : IN STD_LOGIC;
        count : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END n_bit_counter;

ARCHITECTURE Behavioral OF n_bit_counter IS
    SIGNAL tmp_count : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
BEGIN
    PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            tmp_count <= "0000";
        ELSIF rising_edge(clk) THEN
            IF enable = '1' THEN
                tmp_count <= tmp_count + 1;
            END IF;
        END IF;
    END PROCESS;

    count <= tmp_count;
END Behavioral;