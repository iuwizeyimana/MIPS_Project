-- 32 bit ALU TB 

library ieee;
use ieee.std_logic_1164.all;

entity alu_tb is
end alu_tb;

architecture thirtyTwo_bit_ALU_behav of alu_tb is 
	component thirtyTwo_bit_ALU
		port(ALU_control : in std_logic_vector(3 downto 0);
		     a, b: in std_logic_vector(31 downto 0);
			clk: in std_logic;
			CarryOut: out std_logic;
			Result: out std_logic_vector(31 downto 0) );
	end component;

	signal ALU_control: std_logic_vector(3 downto 0);
	signal a, b, Result: std_logic_vector(31 downto 0);
	signal clk, CarryOut : std_logic;
begin
		-- unit under test
	UUT: thirtyTwo_bit_ALU port map( ALU_control => ALU_control, a=>a, b=>b, clk => clk, CarryOut=>CarryOut, Result=>Result);
    
    gen_clk: process 
    begin
        clk <= '0';
        wait for 1 ps; 
        clk <= '1';
        wait for 1 ps;
    end process;

	process
	begin
	   
	    
		ALU_control <= X"6"; --AND
		a <= X"12345678";
		b <= X"00000008";
--		CarryIn <= '0';
		wait for 20 ps;
		
		ALU_control <= X"1"; -- or
		a <= X"00000110";
		b <= X"00001100";
	--	CarryIn <= '0';
		wait for 20 ps;
		
		ALU_control <= X"2";  -- add
		a <= X"00000110";
		b <= X"00000100";
	--	CarryIn <= '0';
		wait for 20 ps;
		
		ALU_control <= X"6"; --sub
		a <= X"00000110";
		b <= X"00001100";
	--	CarryIn <= '0';
		wait for 20 ps;
		
		ALU_control <= X"7"; --slt
		a <= X"00000110";
		b <= X"00001100";
	--	CarryIn <= '0';
		wait for 20 ps;
		
		ALU_control <= X"C"; --NOR
		a <= X"00000110";
		b <= X"00001100";
	--	CarryIn <= '0';
		wait for 20 ps;
		
		
	end process;
end thirtyTwo_bit_ALU_behav;
