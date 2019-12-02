library ieee;
use ieee.std_logic_1164.all;

entity mdr_tb is
end mdr_tb;

architecture behavioral of mdr_tb is 
    signal clk             : std_logic;
    signal mem_in, mem_out : std_logic_vector(31 downto 0);

    component mdr is
        port(mem_in:  in std_logic_vector(31 downto 0);
             clk:     in std_logic;
             mem_out: out std_logic_vector(31 downto 0));
    end component mdr;

begin

    uut : mdr

    port map (
        mem_in  => mem_in,
        clk     => clk,
        mem_out => mem_out
    );

    gen_clk : process
    begin
        clk <= '0';
        wait for 1 ns;
        clk <= '1';
        wait for 1 ns;
    end process;

    process is
    begin
        wait for 1 ns;
        mem_in <= "11110101010101010101000000011010";
        wait for 2 ns;
        mem_in <= x"FEEDC0DE";
        wait for 2 ns;
        mem_in <= x"DEADBABE";
    end process;
end behavioral;



