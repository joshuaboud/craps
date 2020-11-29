-- comparator_TB.vhd
-- Authour: Josh Boudreau B00819096
-- comparator testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity comparator_TB is
end comparator_TB;

architecture Behavioral of comparator_TB is
    component comparator is
        generic(
            DEPTH : integer := 3 -- input width
        );
        Port (
            a : in STD_LOGIC_VECTOR (DEPTH-1 downto 0);
            b : in STD_LOGIC_VECTOR (DEPTH-1 downto 0);
            result : out STD_LOGIC
        );
    end component;
    signal a : STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
    signal b : STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
    signal result : STD_LOGIC;
begin
    comp : comparator port map (a => a, b => b, result => result);
    test_comparator: process
    begin
        for i in 0 to 7 loop
            for j in 0 to 7 loop
                wait for 20 ns;
                a <= a + '1';
            end loop;
            b <= b + '1';
        end loop;
    end process;
end Behavioral;
