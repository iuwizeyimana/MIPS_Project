library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity shiftleft2 is
    port(input: in std_logic_vector(31 downto 0);
         output: out std_logic_vector(31 downto 0));
end shiftleft2;

architecture behavioral of shiftleft2 is
begin
    output <= std_logic_vector(shift_left(unsigned(input), 2));
end behavioral;
