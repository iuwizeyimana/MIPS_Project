library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- This 3-input mux serves as the PC mux
-- The two-bit selector is the signal PCSource
-- 00: Selects PC + 4 (input1)
-- 01: Selects ALUout PC from beq (input2)
-- 10: Selects jump address

entity mux3 is
    port(selector: in std_logic_vector(1 downto 0);
         input1, input2, input3: in std_logic_vector(31 downto 0);
         clk: in std_logic;
         output: out std_logic_vector(31 downto 0));
end mux3;

architecture behavioral of mux3 is
begin
    selecting: process(clk, selector)
    begin
        if rising_edge(clk) then
            case selector is
                when "00" =>
                    output <= input1;
                when "01" =>
                    output <= input2;
                when "10" =>
                    output <= input3;
                when others =>
            end case;
        end if;
        end process;
end behavioral;
