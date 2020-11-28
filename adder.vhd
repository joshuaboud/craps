 -- adder.vhd
-- Authour: Josh Boudreau B00819096
-- simple adder with no carry in
-- output is one bit wider than inputs
-- adds two values together

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity adder is
    generic(
        DEPTH : integer := 3 -- input width
    );
    Port (
        a : in STD_LOGIC_VECTOR (DEPTH-1 downto 0);
        b : in STD_LOGIC_VECTOR (DEPTH-1 downto 0);
        result : out STD_LOGIC_VECTOR (DEPTH downto 0)
    );
end adder;
    
architecture Behavioral of adder is
begin
    result <= ('0' & a) + ('0' & b);
end Behavioral;
 
