-- comparator.vhd
-- Authour: Josh Boudreau B00819096
-- compare two values

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity comparator is
    generic(
        DEPTH : integer := 3 -- input width
    );
    Port (
        a : in STD_LOGIC_VECTOR (DEPTH-1 downto 0);
        b : in STD_LOGIC_VECTOR (DEPTH-1 downto 0);
        result : out STD_LOGIC
    );
end comparator;

architecture Behavioral of comparator is
begin
    result <= '1' when (a = b) else '0';
end Behavioral;
 
