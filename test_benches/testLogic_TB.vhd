-- testLogic_TB.vhd
-- Authour: Josh Boudreau B00819096
-- testLogic testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity testLogic_TB is
end testLogic_TB;

architecture Behavioral of testLogic_TB is
    component testLogic is
        Port (
            input : in STD_LOGIC_VECTOR (3 downto 0);
            D7 : out STD_LOGIC;
            D711 : out STD_LOGIC;
            D2312 : out STD_LOGIC
        );
    end component;
    signal input : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal D7 : STD_LOGIC;
    signal D711 : STD_LOGIC;
    signal D2312 : STD_LOGIC;
begin
    reg : testLogic port map (input => input, D7 => D7, D711 => D711, D2312 => D2312);
    test_testLogic: process
    begin
        wait for 10 us;
        input <= input + '1';
    end process;
end Behavioral;
 
