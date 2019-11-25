library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- opcode: Bits 31-26
-- reg1: Bits 25-21
-- reg2: Bits 20-16
-- mux_output: Bits 15-11
-- shift_output: Bits 25-0
-- immediate_output: Bits 15-0

entity ir is
    port(instruction: in std_logic_vector(31 downto 0);
         IRWrite: in std_logic;
         clk: in std_logic;
         opcode: out std_logic_vector(5 downto 0);
         reg1, reg2, mux_output: out std_logic_vector(4 downto 0);
         shift_output: out std_logic_vector(25 downto 0);
         immediate_output: out std_logic_vector(15 downto 0));
end ir;

architecture behavioral of ir is
begin
    output: process(clk) is
    begin
        if rising_edge(clk) then
            opcode           <= instruction(31 downto 26);
            reg1             <= instruction(25 downto 21);
            reg2             <= instruction(20 downto 16);
            mux_output       <= instruction(15 downto 11);
            shift_output     <= instruction(25 downto 0);
            immediate_output <= instruction(15 downto 0);
        end if;
    end process;
end behavioral;
