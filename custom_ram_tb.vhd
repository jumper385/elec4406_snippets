LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL; -- For arithmetic operations on std_logic_vector

ENTITY custom_ram_tb IS
END custom_ram_tb;

ARCHITECTURE v1 OF custom_ram_tb IS

    COMPONENT custom_ram
        PORT (
            address : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
            clock : IN STD_LOGIC := '1';
            data : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            wren : IN STD_LOGIC;
            q : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL address : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL data, q : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL wren, clock : STD_LOGIC;
    CONSTANT t : TIME := 50 ns;

    TYPE test_vector IS RECORD
        address : STD_LOGIC_VECTOR(4 DOWNTO 0);
        clock : STD_LOGIC;
        data : STD_LOGIC_VECTOR(3 DOWNTO 0);
        wren : STD_LOGIC;
        expected_q : STD_LOGIC_VECTOR(3 DOWNTO 0);
        t : TIME;
    END RECORD;

    TYPE test_vector_array IS ARRAY (NATURAL RANGE <>) OF test_vector;

    CONSTANT test_vectors : test_vector_array := (
    -- addr,  clock   data    wren   eout    t
    ("00000", '0', "0000", '0', "----", t),
    ("00000", '1', "0000", '0', "----", t),
    ("00000", '0', "0000", '0', "----", t),
    ("00000", '1', "0000", '0', "----", t),
    ("00000", '0', "1010", '1', "----", t),
    ("00000", '1', "1010", '1', "----", t),
    ("00000", '0', "0000", '0', "----", t),
    ("00000", '1', "0000", '0', "----", t),
    ("11111", '0', "0101", '1', "----", t),
    ("11111", '1', "0101", '1', "----", t),
    ("00000", '0', "0000", '0', "----", t),
    ("00000", '1', "0000", '0', "----", t),
    ("11111", '0', "0000", '0', "----", t),
    ("11111", '1', "0000", '0', "----", t)
    );

BEGIN

    dut : custom_ram PORT MAP(address => address, data => data, wren => wren, clock => clock, q => q);

    tb : PROCESS
    BEGIN

        REPORT "Test Initializing...";

        address <= "00000";
        data <= "0000";
        wren <= '0';
        clock <= '0';
        WAIT FOR t;

        REPORT "Test Starting...";

        FOR i IN test_vectors'RANGE LOOP

            address <= test_vectors(i).address;
            data <= test_vectors(i).data;
            wren <= test_vectors(i).wren;
            clock <= test_vectors(i).clock;
            WAIT FOR test_vectors(i).t;

        END LOOP;
        REPORT "Test Complete...";
        WAIT;

    END PROCESS;
END v1;