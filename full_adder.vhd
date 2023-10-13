LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY full_adder IS
    PORT (
        a, b, cin : IN STD_LOGIC;
        s, cout : OUT STD_LOGIC
    );
END ENTITY full_adder;

ARCHITECTURE rtl OF full_adder IS

BEGIN

    s <= ((a XOR b) XOR cin);
    cout <= ((a XOR b) AND cin) OR (a AND b);

END ARCHITECTURE rtl;