library ieee;
use ieee.std_logic_1164.all;

entity shiftleft2_tb is
end shiftleft2_tb;

architecture behavioral of shiftleft2_tb is
    signal x  : std_logic_vector(31 downto 0);
    signal y  : std_logic_vector(31 downto 0);

    component shiftleft2 is
        port(input: in std_logic_vector(31 downto 0);
             output: out std_logic_vector(31 downto 0));
    end component shiftleft2;

begin

    uut : shiftleft2

    port map (
        input  => x,
        output => y
    );

    process is
    begin
        x <= x"10000001";
        wait for 1 ns;
        x <= x"DEADBEEF";
        wait for 1 ns;
        x <= x"ABADBABE";
        wait for 1 ns;
        x <= x"A5A5A5A5";
        wait for 1 ns;
        x <= x"29696969";
        wait for 1 ns;
    end process;
end behavioral;
