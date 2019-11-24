library ieee;
use ieee.std_logic_1164.all;

entity shiftleft1_tb is
end shiftleft1_tb;

architecture behavioral of shiftleft1_tb is
    signal x  : std_logic_vector(25 downto 0);
    signal y  : std_logic_vector(27 downto 0);

    component shiftleft1 is
        port(input: in std_logic_vector(25 downto 0);
             output: out std_logic_vector(27 downto 0));
    end component shiftleft1;

begin

    uut : shiftleft1

    port map (
        input  => x,
        output => y
    );

    process is
    begin
        x <= "10000000000000000000000000";
        wait for 1 ns;
        x <= "00000000000000000000000000";
        wait for 1 ns;
        x <= "11111111111111111111111111";
        wait for 1 ns;
        x <= "01010101010101010101010101";
        wait for 1 ns;
        x <= "10101010101010101010101010";
        wait for 1 ns;
    end process;
end behavioral;
