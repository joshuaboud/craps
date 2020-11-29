-- die.vhd
-- Authour: Josh Boudreau B00819096
-- die of configurable number of sides
-- rolls when roll is '0', clkDiv output to
-- use as clk input for next die to permute
-- all values

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity die is
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
end die;

architecture Behavioral of die is
    signal current : std_logic_vector (DEPTH-1 downto 0) := (DEPTH-2 downto 0 => '0') & '1';
    signal slow_clock : std_logic := '0';
begin
    process(clk, roll) begin
        if(rising_edge(clk) and roll = '0') then
            if(current = SIDES) then
                current <= (DEPTH-2 downto 0 => '0') & '1';
                slow_clock <= '1';
            else
                current <= current + '1';
                slow_clock <= '0';
            end if;
        end if;
    end process;
    result <= current;
    clkDiv <= slow_clock;
end Behavioral;
