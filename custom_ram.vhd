LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY custom_ram IS
    PORT (
        address : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
        clock : IN STD_LOGIC := '1';
        data : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        wren : IN STD_LOGIC;
        q : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
    );
END ENTITY custom_ram;

ARCHITECTURE rtl OF custom_ram IS

    TYPE mem IS ARRAY (0 TO 31) OF STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL memory_array : mem;

    SIGNAL addrBuff : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL dinBuff : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL wrenBuff : STD_LOGIC;
    SIGNAL doutBuff : STD_LOGIC_VECTOR(3 DOWNTO 0);

    SIGNAL int_addr : INTEGER := 0;

BEGIN

    int_addr <= to_integer(unsigned(addrBuff));

    ram_module : PROCESS (clock)
    BEGIN
        IF rising_edge(clock) THEN
            addrBuff <= address;
            IF wren = '1' THEN
                memory_array(to_integer(unsigned(address))) <= data;
            END IF;
        END IF;
    END PROCESS; -- ram_module

    q <= memory_array(int_addr);
END ARCHITECTURE rtl;