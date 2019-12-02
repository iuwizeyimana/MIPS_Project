library ieee;
use ieee.std_logic_1164.all;
-- The numeric_std package is used to convert std_logic_vector to integer
use ieee.numeric_std.all;

entity mdr is 
    port(mem_in:  in std_logic_vector(31 downto 0);
         clk:     in std_logic;
         mem_out: out std_logic_vector(31 downto 0));
end mdr;

architecture behavioral of mdr is
begin
flush_mdr: process(clk) is
begin
    if rising_edge(clk) then
        mem_out <= mem_in;
    end if;
end process;
end behavioral;
