library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- This 4-input mux serves as the second ALU operand mux
-- The two-bit selector is the signal ALUSrcB
-- 00: RegFile(IR[20-16])
-- 01: The value 4, for PC = PC + 4
-- 10: sign_extend(IR[15-0])
-- 11: shift_left2(sign_extend(IR[15-0]))

entity mux4 is
    port(selector: in std_logic_vector(1 downto 0);
         input1, input2, input3: in std_logic_vector(31 downto 0);
         clk: in std_logic;
         output: out std_logic_vector(31 downto 0));
end mux4;

architecture behavioral of mux4 is
begin
    selecting: process(clk, selector)
    begin
        if rising_edge(clk) then
            case selector is
                when "00" =>
                    output <= input1;
                when "01" =>
                    output <= x"00000004";
                when "10" =>
                    output <= input2;
                when "11" =>
                    output <= input3;
                when others =>
            end case;
        end if;
    end process;
end behavioral;
