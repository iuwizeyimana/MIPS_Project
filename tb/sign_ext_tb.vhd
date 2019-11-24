library ieee;
use ieee.std_logic_1164.all;

entity sign_ext_tb is
end sign_ext_tb;

architecture behavioral of sign_ext_tb is
    signal x  : std_logic_vector(15 downto 0);
    signal ck : std_logic;
    signal y  : std_logic_vector(31 downto 0);

    component sign_ext is
        port(input: in std_logic_vector(15 downto 0);
             clk: std_logic;
             output: out std_logic_vector(31 downto 0));
    end component sign_ext;

begin

    uut : sign_ext

    port map (
        input  => x,
        clk    => ck,
        output => y
    );

    gen_clk : process
    begin
        ck <= '0';
        wait for 1 ns;
        ck <= '1';
        wait for 1 ns;
    end process;

    process is
    begin
        x <= x"FFFF";
        wait for 1 ns;
        x <= x"7000";
        wait for 1 ns;
        x <= x"0000";
        wait for 1 ns;
        x <= x"8000";
        wait for 1 ns;
        x <= x"7000";
        wait for 1 ns;
        x <= x"0000";
        wait for 1 ns;
        x <= x"8000";
        wait for 1 ns;
        x <= x"FFFF";
        wait for 1 ns;
    end process;
end behavioral;
