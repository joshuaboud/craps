-- pointRegister.vhd
-- Authour: Josh Boudreau B00819096
-- store a value

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity pointRegister is
    generic(
        DEPTH : integer := 3 -- input width
    );
    Port (
        input : in STD_LOGIC_VECTOR (DEPTH-1 downto 0);
        store : in STD_LOGIC;
        output : out STD_LOGIC_VECTOR (DEPTH-1 downto 0)
    );
end pointRegister;

architecture Behavioral of pointRegister is
    signal reg : STD_LOGIC_VECTOR (DEPTH-1 downto 0) := (others => '0');
begin
    process(store)
    begin
        if(rising_edge(store)) then
            reg <= input;
        end if;
    end process;
    output <= reg;
end Behavioral;
