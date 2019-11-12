library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity shiftleft1 is
    port(input: in std_logic_vector(25 downto 0);
         output: out std_logic_vector(27 downto 0));
end shiftleft1;

architecture behavioral of shiftleft1 is
    signal temp : std_logic_vector(27 downto 0);
begin
    temp   <= std_logic_vector(resize(signed(input), output'length));
    output <= std_logic_vector(shift_left(unsigned(temp), 2));
end behavioral;
