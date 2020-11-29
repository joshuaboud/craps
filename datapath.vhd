-- datapath.vhd
-- Authour: Josh Boudreau B00819096
-- architecture of datapath

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity datapath is
    Port (
        clk : in STD_LOGIC;
        display1, display2 : out STD_LOGIC_VECTOR (2 downto 0);
        roll, storePoint : in STD_LOGIC;
        D7, D711, D2312, eq : out STD_LOGIC
    );
end datapath;

architecture Structural of datapath is
    component die is
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
    end component;
    component adder is
        generic(
            DEPTH : integer := 3 -- input width
        );
        Port (
            a : in STD_LOGIC_VECTOR (DEPTH-1 downto 0);
            b : in STD_LOGIC_VECTOR (DEPTH-1 downto 0);
            result : out STD_LOGIC_VECTOR (DEPTH downto 0)
        );
    end component;
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
    component comparator is
        generic(
            DEPTH : integer := 4 -- input width
        );
        Port (
            a : in STD_LOGIC_VECTOR (DEPTH-1 downto 0);
            b : in STD_LOGIC_VECTOR (DEPTH-1 downto 0);
            result : out STD_LOGIC
        );
    end component;
    component testLogic is
        Port (
            input : in STD_LOGIC_VECTOR (3 downto 0);
            D7 : out STD_LOGIC;
            D711 : out STD_LOGIC;
            D2312 : out STD_LOGIC
        );
    end component;
    signal die1_bus, die2_bus : STD_LOGIC_VECTOR (2 downto 0);
    signal die2_clk : STD_LOGIC; -- slower clock to permute each die combination
    signal sum_bus : STD_LOGIC_VECTOR (3 downto 0);
    signal pointRegister_out : STD_LOGIC_VECTOR (3 downto 0);
begin
    die1 : die port map (clk => clk, clkDiv => die2_clk, roll => roll, result => die1_bus);
    die2 : die port map (clk => die2_clk, clkDiv => open, roll => roll, result => die2_bus);
    S : adder port map (a => die1_bus, b => die2_bus, result => sum_bus);
    pr : pointRegister port map (input => sum_bus, store => storePoint, output => pointRegister_out);
    comp : comparator port map (a => pointRegister_out, b => sum_bus, result => eq);
    tl : testLogic port map (input => sum_bus, D7 => D7, D711 => D711, D2312 => D2312);
    display1 <= die1_bus;
    display2 <= die2_bus;
end Structural;
