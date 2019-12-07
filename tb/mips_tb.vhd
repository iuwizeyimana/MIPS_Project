library ieee;
use ieee.std_logic_1164.all;

entity mips_tb is
end mips_tb;

architecture behavioral of mips_tb is 
    signal clk, stall, pc_sel, mux_sel, mem_read, mem_write  : std_logic;
    signal ALUout, pc_init : std_logic_vector(31 downto 0);

    -- The component we are testing is the 2-input multiplexer,
    -- so we declare that component here.
    component mips is
        port(clk, stall 	: in std_logic;
	     pc_init		: in std_logic_vector(31 downto 0);
	     pc_sel, mux_sel 	: in std_logic;
	     mem_read, mem_write: in std_logic; 
             ALUout		: out std_logic_vector(31 downto 0));
    end component mips;

begin

    uut : mips

    port map (
        clk    => clk,
	stall  => stall,
	pc_init => pc_init,
	pc_sel => pc_sel,
	mux_sel => mux_sel,
	mem_read => mem_read,
	mem_write => mem_write,
        ALUout => ALUout
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
        stall 	  <= '1';
	pc_init   <= x"00000004";
	pc_sel    <='1';
	mux_sel	  <= '0';
	mem_read  <= '1';
	mem_write <= '0';
	wait for 50 ns;
	stall 	  <= '0';
	wait for 150 ns;
    end process;

end behavioral;



