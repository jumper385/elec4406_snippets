LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY counter IS
    GENERIC (threshold : INTEGER := 10);
    PORT (
        clk : IN STD_LOGIC;
        q : OUT STD_LOGIC := '0';
        rst : IN STD_LOGIC;
        bypass_thresh : IN STD_LOGIC
    );
END ENTITY counter;

ARCHITECTURE rtl OF counter IS

    SIGNAL qBuff : STD_LOGIC;
    SIGNAL counter : INTEGER := 0;

BEGIN

    count_process : PROCESS (clk, rst)
    BEGIN

        IF (rst = '0') THEN
            counter <= 0;
            q <= '0';
        ELSIF rising_edge(clk) THEN
            IF (bypass_thresh = '0') THEN
                IF (counter >= threshold) THEN
                    q <= '1';
                    counter <= 0;
                ELSE
                    counter <= counter + 1;
                    q <= '0';
                END IF;
            ELSE
                counter <= counter + 1;
                q <= '0';
            END IF;
        END IF;

    END PROCESS; -- count_process

END ARCHITECTURE rtl;