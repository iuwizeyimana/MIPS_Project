library ieee;
use ieee.std_logic_1164.all;
-- The numeric_std package is used to convert std_logic_vector to integer
use ieee.numeric_std.all;

entity alu_out is 
    port(in_alu:  in std_logic_vector(31 downto 0);
         clk:     in std_logic;
         out_alu: out std_logic_vector(31 downto 0));
end alu_out;

architecture behavioral of alu_out is
begin
flush_alu_out: process(clk) is
begin
    if rising_edge(clk) then
        out_alu <= in_alu;
    end if;
end process;
end behavioral;
