library ieee;
use ieee.std_logic_1164.all;

entity alu_out_tb is
end alu_out_tb;

architecture behavioral of alu_out_tb is 
    signal clk             : std_logic;
    signal in_alu, out_alu : std_logic_vector(31 downto 0);

    component alu_out is
        port(in_alu:  in std_logic_vector(31 downto 0);
             clk:     in std_logic;
             out_alu: out std_logic_vector(31 downto 0));
    end component alu_out;

begin

    uut : alu_out

    port map (
        in_alu  => in_alu,
        clk     => clk,
        out_alu => out_alu
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
        in_alu <= "11110101010101010101000000011010";
        wait for 2 ns;
        in_alu <= x"FEEDC0DE";
        wait for 2 ns;
        in_alu <= x"DEADBABE";
    end process;
end behavioral;



