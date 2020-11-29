-- controller_TB.vhd
-- Authour: Josh Boudreau B00819096
-- FSM testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity controller_TB is
end controller_TB;

architecture Behavioral of controller_TB is
    component controller is
        Port (
            clk, enter, reset : in STD_LOGIC;
            D7, D711, D2312, eq : in STD_LOGIC;
            roll, storePoint, win, lose : out STD_LOGIC
        );
    end component;
    signal clk, enter, reset : STD_LOGIC := '0';
    signal D7, D711, D2312, eq : STD_LOGIC := '0';
    signal roll, storePoint, win, lose : STD_LOGIC;
begin
    con : controller port map (
        clk => clk, enter => enter, reset => reset,
        D7 => D7, D711 => D711, D2312 => D2312, eq => eq,
        roll => roll, storePoint => storePoint, win => win, lose => lose
    );
    
    clock_process: process
    begin
        -- slower clock to better see transitions
        wait for 1 us;
        clk <= '1';
        wait for 1 us;
        clk <= '0';
    end process;
    
    test_FSM: process
    begin
        -- wait a bit
        wait for 10 us;
        
        -- test 7or11 win
        -- push enter/roll
        enter <= '1';
        wait for 20 us;
        D711 <= '1';
        enter <= '0';
        wait for 20 us; -- should say win
        D711 <= '0';
        reset <= '1';
        wait for 30 us;
        reset <= '0';
        wait for 10 us;
        
        -- test 2or3or12 lose
        -- push enter/roll
        enter <= '1';
        wait for 20 us;
        D2312 <= '1';
        enter <= '0';
        wait for 20 us; -- should say lose
        D2312 <= '0';
        reset <= '1';
        wait for 30 us;
        reset <= '0';
        wait for 10 us;
        
        -- test subsequent roll to lose
        -- push enter/roll
        enter <= '1';
        -- state: roll1
        wait for 20 us;
        -- all D's are '0'
        enter <= '0';
        -- state: test1
        wait for 20 us;
        -- roll again
        enter <= '1';
        -- state: roll2
        wait for 20 us;
        -- all D's are '0'
        enter <= '0';
        -- state: test2
        wait for 20 us;
        -- roll again
        enter <= '1';
        -- state: roll2
        wait for 20 us;
        -- test fail with D7
        D7 <= '1';
        enter <= '0';
        -- state: test2 to lost
        wait for 20 us;
        D7 <= '0';
        reset <= '1';
        wait for 30 us;
        reset <= '0';
        wait for 10 us;
        
        -- test subsequent roll to win
        -- push enter/roll
        enter <= '1';
        -- state: roll1
        wait for 20 us;
        -- all D's are '0'
        enter <= '0';
        -- state: test1
        wait for 20 us;
        -- roll again
        enter <= '1';
        -- state: roll2
        wait for 20 us;
        eq <= '1';
        enter <= '0';
        -- state: test2 to won
        wait for 20 us;
        eq <= '0';
        reset <= '1';
        wait for 30 us;
        reset <= '0';
        wait for 10 us;
        
        wait for 100 us;
    end process;
end Behavioral;
