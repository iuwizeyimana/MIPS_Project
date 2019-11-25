library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity shiftleft1 is
    port(input: in std_logic_vector(25 downto 0);
         clk: in std_logic;
         output: out std_logic_vector(27 downto 0));
end shiftleft1;

architecture behavioral of shiftleft1 is
begin
    shift: process(clk) is
    begin
        if rising_edge(clk) then
            output <= std_logic_vector(shift_left(unsigned(resize(signed(input), output'length)), 2));
        end if;
    end process;
end behavioral;
