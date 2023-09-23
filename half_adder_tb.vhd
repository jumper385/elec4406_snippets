LIBRARY ieee;

USE ieee.std_logic_1164.ALL;

ENTITY half_adder_tb IS
END ENTITY;

ARCHITECTURE Behavioural OF half_adder_tb IS

    CONSTANT c_WAIT : TIME := 20 ns;

    SIGNAL r_input_a : STD_LOGIC := '0';
    SIGNAL r_input_b : STD_LOGIC := '0';

    SIGNAL r_output_s : STD_LOGIC := '0';
    SIGNAL r_output_c : STD_LOGIC := '0';

    COMPONENT half_adder IS
        PORT (
            A : IN STD_LOGIC;
            B : IN STD_LOGIC;
            S : OUT STD_LOGIC;
            C : OUT STD_LOGIC
        );

    END COMPONENT half_adder;

BEGIN
    UUT : half_adder
    PORT MAP(
        A => r_input_a,
        B => r_input_b,
        S => r_output_s,
        C => r_output_c
    );

    p_comb : PROCESS IS
    BEGIN
        WAIT FOR c_WAIT;
        r_input_a <= '0';
        r_input_b <= '0';

        WAIT FOR c_WAIT;
        r_input_a <= '0';
        r_input_b <= '1';

        WAIT FOR c_WAIT;
        r_input_a <= '1';
        r_input_b <= '0';

        WAIT FOR c_WAIT;
        r_input_a <= '1';
        r_input_b <= '1';

    END PROCESS;

END Behavioural;