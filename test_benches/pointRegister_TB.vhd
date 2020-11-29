-- pointRegister_TB.vhd
-- Authour: Josh Boudreau B00819096
-- pointRegister testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity pointRegister_TB is
end pointRegister_TB;

architecture Behavioral of pointRegister_TB is
    component pointRegister is
        generic(
            DEPTH : integer := 4 -- input width
        );
        Port (
            input : in STD_LOGIC_VECTOR (DEPTH-1 downto 0);
            store : in STD_LOGIC;
            output : out STD_LOGIC_VECTOR (DEPTH-1 downto 0)
        );
    end component;
    signal input : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal store : STD_LOGIC := '0';
    signal output : STD_LOGIC_VECTOR (3 downto 0);
begin
    reg : pointRegister port map (input => input, store => store, output => output);
    test_comparator: process
    begin
        wait for 10 us;
        for i in 0 to 7 loop
            store <= '1';
            wait for 10 us;
            store <= '0';
            wait for 10 us;
            input <= input + '1';
            wait for 30 us;
        end loop;
    end process;
end Behavioral;
