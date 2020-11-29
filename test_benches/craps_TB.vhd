-- craps_TB.vhd
-- Authour: Josh Boudreau B00819096
-- game testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity craps_TB is
end craps_TB;

architecture Behavioral of craps_TB is
    component craps is
        Port (
            clk : in STD_LOGIC;
            display1, display2 : out STD_LOGIC_VECTOR (2 downto 0);
            enter, reset : in STD_LOGIC;
            win, lose : out STD_LOGIC
        );
    end component;
    signal clk, enter, reset : STD_LOGIC := '0';
    signal display1, display2 : STD_LOGIC_VECTOR (2 downto 0);
    signal win, lose : STD_LOGIC;
begin
    game : craps port map (
        clk => clk, display1 => display1, display2 => display2,
        enter => enter, reset => reset, win => win, lose => lose
    );
    
    clock_process: process
    begin
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
        clk <= '0';
    end process;
    
    test_game: process
    begin
        -- keep playing until win or lose
        while(win = '0' and lose = '0') loop
            -- roll
            enter <= '1';
            wait for 10 us;
            wait for 542.69 ns; -- forward a bit
            enter <= '0';
            wait for 10 us;
        end loop;
        wait for 30 us;
        reset <= '1';
        wait for 1 us;
        reset <= '0';
    end process;
end Behavioral;
