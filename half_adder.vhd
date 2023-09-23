LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY half_adder IS
    PORT (
        A : IN STD_LOGIC;
        B : IN STD_LOGIC;
        S : OUT STD_LOGIC;
        C : OUT STD_LOGIC
    );

END half_adder;

ARCHITECTURE RTL OF half_adder IS
BEGIN

    S <= A XOR B;
    C <= A AND B;

END RTL;