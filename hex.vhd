LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY hex IS
    PORT (
        din : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        dout : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END ENTITY hex;

ARCHITECTURE rtl OF hex IS

BEGIN

    proc_name : PROCESS (din)
    BEGIN
        CASE din IS
            WHEN "0000" =>
                dout <= "1000000";
            WHEN "0001" =>
                dout <= "1111001";
            WHEN "0010" =>
                dout <= "0100100";
            WHEN "0011" =>
                dout <= "0110000";
            WHEN "0100" =>
                dout <= "0011001";
            WHEN "0101" =>
                dout <= "0010010";
            WHEN "0110" =>
                dout <= "0000010";
            WHEN "0111" =>
                dout <= "1111000";
            WHEN "1000" =>
                dout <= "0000000";
            WHEN "1001" =>
                dout <= "0011000";
            WHEN "1010" =>
                dout <= "0001000";
            WHEN "1011" =>
                dout <= "0000011";
            WHEN "1100" =>
                dout <= "0100111";
            WHEN "1101" =>
                dout <= "0100001";
            WHEN "1110" =>
                dout <= "0000110";
            WHEN "1111" =>
                dout <= "0001110";
            WHEN OTHERS =>
                dout <= "1111111";
        END CASE;
    END PROCESS proc_name;

END ARCHITECTURE rtl;