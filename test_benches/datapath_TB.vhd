-- datapath_TB.vhd
-- Authour: Josh Boudreau B00819096
-- datapath testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity datapath_TB is
end datapath_TB;

architecture Behavioral of datapath_TB is
    component datapath is
        Port (
            clk : in STD_LOGIC;
            display1, display2 : out STD_LOGIC_VECTOR (2 downto 0);
            roll, storePoint : in STD_LOGIC;
            D7, D711, D2312, eq : out STD_LOGIC
        );
    end component;
    signal clk : STD_LOGIC := '0'; -- main clock
    signal display1, display2 : STD_LOGIC_VECTOR (2 downto 0);
    signal roll : STD_LOGIC := '0'; -- input to roll
    signal sp : STD_LOGIC := '0'; -- input to store point
    signal D7, D711, D2312, eq : STD_LOGIC;
begin
    dp : datapath port map (
        clk => clk, display1 => display1, display2 => display2, roll => roll,
        storePoint => sp, D7 => D7, D711 => D711, D2312 => D2312, eq => eq
    );
    
    clock_process: process
    begin
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
        clk <= '0';
    end process;
    
    roll <= '1'; -- constantly roll
    
    test_dice: process
    begin
        wait for 80 ns; -- 4 clock cycles, sum should be 6
        sp <= '1'; -- try to store 6
        wait for 10 ns;
        sp <= '0';
        wait for 100 us;
    end process;
end Behavioral;
