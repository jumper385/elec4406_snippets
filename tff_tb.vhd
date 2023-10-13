LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY tff_tb IS
END ENTITY tff_tb;

ARCHITECTURE behavior OF tff_tb IS
    SIGNAL t, clk, clr : STD_LOGIC := '0';
    SIGNAL q : STD_LOGIC;
BEGIN

    -- instantiate the unit under test
    uut : ENTITY work.tff PORT MAP (
        t => t,
        clk => clk,
        clr => clr,
        q => q
        );

    -- stimulus process
    stim_proc : PROCESS
    BEGIN
        -- hold reset state for 2 ns
        WAIT FOR 2 ns;
        clr <= '1';
        WAIT FOR 2 ns;

        -- test with t=0
        t <= '0';
        clk <= '1';
        WAIT FOR 2 ns;
        clk <= '0';
        WAIT FOR 2 ns;
        ASSERT (q = '0') REPORT "Fail: t=0, q should be 0" SEVERITY error;

        -- test with t=1
        t <= '1';
        clk <= '1';
        WAIT FOR 2 ns;
        clk <= '0';
        WAIT FOR 2 ns;
        ASSERT (q = '1') REPORT "Fail: t=1, q should be 1" SEVERITY error;

        -- toggling t
        clk <= '1';
        WAIT FOR 2 ns;
        clk <= '0';
        WAIT FOR 2 ns;
        ASSERT (q = '0') REPORT "Fail: t toggled, q should be 0" SEVERITY error;

        -- test clear
        clr <= '0';
        WAIT FOR 2 ns;
        ASSERT (q = '0') REPORT "Fail: clr=0, q should be 0" SEVERITY error;

        -- finishing the test
        WAIT;
    END PROCESS stim_proc;

END ARCHITECTURE behavior;