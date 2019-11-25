library ieee;
use ieee.std_logic_1164.all;
-- The numeric_std package is used to convert std_logic_vector to integer
use ieee.numeric_std.all;

entity pc is 
    port(input:  in std_logic_vector(31 downto 0);
         clk:    in std_logic;
         output: out std_logic_vector(31 downto 0));
end pc;

architecture behavioral of pc is
begin

-- A good trigger to set the new Program Counter would be the
-- rising edge of the clock.
newPC: process(clk) is
begin
    if rising_edge(clk) then
        output <= input;
    end if;
end process;
end behavioral;
