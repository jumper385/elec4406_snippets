LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY n_bit_adder IS
    GENERIC (bit_depth : INTEGER := 10);
    PORT (
        x1, x2 : IN STD_LOGIC_VECTOR(bit_depth - 1 DOWNTO 0);
        cin : IN STD_LOGIC;
        q : OUT STD_LOGIC_VECTOR(bit_depth - 1 DOWNTO 0);
        cout : OUT STD_LOGIC
    );
END ENTITY n_bit_adder;

ARCHITECTURE rtl OF n_bit_adder IS

    COMPONENT full_adder
        PORT (
            a, b, cin : IN STD_LOGIC;
            s, cout : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL carry_buff : STD_LOGIC_VECTOR(bit_depth DOWNTO 0); -- Extend by one bit for cin and the final cout

BEGIN

    carry_buff(0) <= cin; -- Initialize the carry for the least significant bit

    generate_adders : FOR i IN 0 TO bit_depth - 1 GENERATE

        fa_n : full_adder PORT MAP(
            a => x1(i),
            b => x2(i),
            cin => carry_buff(i),
            s => q(i),
            cout => carry_buff(i + 1)
        );

    END GENERATE generate_adders;

    cout <= carry_buff(bit_depth); -- The last carry is the carry out for the n-bit adder

END ARCHITECTURE rtl;