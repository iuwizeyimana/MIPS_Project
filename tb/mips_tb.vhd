library ieee;
use ieee.std_logic_1164.all;

entity mips_tb is
end mips_tb;

architecture behavioral of mips_tb is 
    signal clk    : std_logic;
    signal ALUout : std_logic_vector(31 downto 0);

    -- The component we are testing is the 2-input multiplexer,
    -- so we declare that component here.
    component mips is
        port(clk:    in std_logic;
             ALUout: out std_logic_vector(31 downto 0));
    end component mips;

begin

    uut : mips

    port map (
        clk    => clk,
        ALUout => ALUout
    );

    gen_clk : process
    begin
        clk <= '0';
        wait for 1 ns;
        clk <= '1';
        wait for 1 ns;
    end process;

end behavioral;



