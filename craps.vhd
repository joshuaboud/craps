-- craps.vhd
-- Authour: Josh Boudreau B00819096
-- top level architecture of the game

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity craps is
    Port (
        clk : in STD_LOGIC;
        display1, display2 : out STD_LOGIC_VECTOR (2 downto 0);
        enter, reset : in STD_LOGIC;
        win, lose : out STD_LOGIC
    );
end craps;

architecture Structural of craps is
    component datapath is
        Port (
            clk : in STD_LOGIC;
            display1, display2 : out STD_LOGIC_VECTOR (2 downto 0);
            roll, storePoint : in STD_LOGIC;
            D7, D711, D2312, eq : out STD_LOGIC
        );
    end component;
    component controller is
        Port (
            clk, enter, reset : in STD_LOGIC;
            D7, D711, D2312, eq : in STD_LOGIC;
            roll, storePoint, win, lose : out STD_LOGIC
        );
    end component;
    signal roll, D7, D711, D2312, eq, storePoint : STD_LOGIC;
begin
    dp : datapath port map (
        clk => clk, display1 => display1, display2 => display2,
        roll => roll, storePoint => storePoint, D7 => D7, D711 => D711,
        D2312 => D2312, eq => eq
    );
    con : controller port map (
        clk => clk, enter => enter, reset => reset,
        D7 => D7, D711 => D711, D2312 => D2312, eq => eq,
        roll => roll, storePoint => storePoint, win => win, lose => lose
    );
end Structural;
