library ieee;
use ieee.std_logic_1164.all;

entity mips_wo_mem_tb is
end mips_wo_mem_tb;

architecture behavioral of mips_wo_mem_tb is 
    signal clk  : std_logic;
    signal ALUout, instruction : std_logic_vector(31 downto 0);

    -- The component we are testing is the 2-input multiplexer,
    -- so we declare that component here.
    component mips_wo_mem is
        port(clk		: in std_logic;
	     instruction	: in std_logic_vector(31 downto 0);
             ALUout		: out std_logic_vector(31 downto 0));
    end component mips_wo_mem;

begin

    uut : mips_wo_mem

    port map (
        clk         => clk,
	instruction => instruction,
        ALUout 	     => ALUout
    );

    gen_clk : process
    begin
        clk <= '0';
        wait for 1 ns;
        clk <= '1';
        wait for 1 ns;
    end process;
    process
    begin
	wait for 1 ns;
	instruction   <= x"014B4824";
	wait for 50 ns;
	instruction   <= x"8d6A0001";
        wait for 50 ns;
        instruction   <= x"022A4822";
	wait for 50 ns;
    end process;

end behavioral;



