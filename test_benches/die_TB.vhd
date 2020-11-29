-- die_TB.vhd
-- Authour: Josh Boudreau B00819096
-- die testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity die_TB is
end die_TB;

architecture Behavioral of die_TB is
    component die is
        -- define generic number of sides
        generic(
            SIDES : integer := 6;
            DEPTH : integer := 3 -- ceil(log2(sides))
        );
        Port (
            clk : in STD_LOGIC;
            clkDiv : out STD_LOGIC; -- clock speed divded by SIDES
            roll : in STD_LOGIC;
            result : out STD_LOGIC_VECTOR (DEPTH-1 downto 0)
        );
    end component;
    signal clk1 : STD_LOGIC := '0'; -- main clock
    signal clk2 : STD_LOGIC := '0'; -- slower clock for die2
    signal roll : STD_LOGIC := '0'; -- input to roll
    signal result1 : STD_LOGIC_VECTOR (2 downto 0);
    signal result2 : STD_LOGIC_VECTOR (2 downto 0);
begin
    die1 : die port map (clk => clk1, clkDiv => clk2, roll => roll, result => result1);
    die2 : die port map (clk => clk2, clkDiv => open, roll => roll, result => result2);
    
    clock_process: process
    begin
        clk1 <= '1';
        wait for 10 ns;
        clk1 <= '0';
        wait for 10 ns;
    end process;
    
    test_dice: process
    begin
        wait for 10 us;
        roll <= '1'; -- hold roll button
        wait for 424 us;
        roll <= '0';
        wait for 1 ms;
        roll <= '1'; -- hold roll button
        wait for 690 us; -- avg button press delay_length
        roll <= '1';
        wait for 1 ms;
    end process;
end Behavioral;
