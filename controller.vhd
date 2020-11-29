-- controller.vhd
-- Authour: Josh Boudreau B00819096
-- FSM controlling game

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity controller is
    Port (
        clk, enter, reset : in STD_LOGIC;
        D7, D711, D2312, eq : in STD_LOGIC;
        roll, storePoint, win, lose : out STD_LOGIC
    );
end controller;

architecture Behavioural of controller is
    type states is (
        start, firstRoll, firstTest, secondRoll,
        secondTest, lost, won
    );
    signal s : states;
begin
    process(clk, reset)
    begin
        if(reset = '1') then
            s <= start;
        elsif(rising_edge(clk)) then
            -- state transitions
            case s is
                when start =>
                    if(enter = '1') then
                        s <= firstRoll;
                    end if; -- else no change (wait for roll input)
                when firstRoll =>
                    if(enter = '0') then
                        s <= firstTest;
                    end if; -- else no change (wait for end of rolling)
                when firstTest =>
                    if(D711 = '1') then
                        s <= won;
                    elsif(D2312 = '1') then
                        s <= lost;
                    elsif(D711 = '0' and D2312 = '0' and enter = '1') then
                        s <= secondRoll;
                    end if; -- else no change (wait for next roll)
                when secondRoll =>
                    if(enter = '0') then
                        s <= secondTest;
                    end if; -- else no change
                when secondTest =>
                    if(D7 = '1') then
                        s <= lost;
                    elsif(eq = '1') then
                        s <= won;
                    elsif(D7 = '0' and eq = '0' and enter = '1') then
                        s <= secondRoll;
                    end if; -- else no change (wait for next roll)
                when others =>
                    null; -- won and lost have no transition
            end case;
        end if;
    end process;
    -- output definitions
    roll <= '1' when (s = firstRoll or s = secondRoll) else '0';
    storePoint <= '1' when (s = firstTest) else '0';
    win <= '1' when (s = won) else '0';
    lose <= '1' when (s = lost) else '0';
end Behavioural;
