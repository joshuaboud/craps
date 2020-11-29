-- testLogic.vhd
-- Authour: Josh Boudreau B00819096
-- detect different sums

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity testLogic is
    Port (
        input : in STD_LOGIC_VECTOR (3 downto 0);
        D7 : out STD_LOGIC;
        D711 : out STD_LOGIC;
        D2312 : out STD_LOGIC
    );
end testLogic;

architecture Behavioral of testLogic is
begin
    D7 <=   '1' when (input = "0111") else '0';
    D711 <= '1' when (input = "0111" or input = "1011") else '0';
    D2312 <= '1' when (input = "0010" or input = "0011" or input = "1100") else '0';
end Behavioral;
 
