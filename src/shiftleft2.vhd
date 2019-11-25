library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity shiftleft2 is
    port(input: in std_logic_vector(31 downto 0);
         clk: in std_logic;
         output: out std_logic_vector(31 downto 0));
end shiftleft2;

architecture behavioral of shiftleft2 is
begin
    shift: process(clk) is
    begin
        if rising_edge(clk) then
            output <= std_logic_vector(shift_left(unsigned(input), 2));
        end if;
    end process;
end behavioral;
