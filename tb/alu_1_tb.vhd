library ieee;
use ieee.std_logic_1164.all;

entity one_bit_ALU_tb is
end one_bit_ALU_tb;

architecture one_bit_ALU_behav of one_bit_ALU_tb is 
	component one_bit_ALU
		port(ALU_control: in std_logic_vector(3 downto 0);
			a,b, CarryIn: in std_logic;
			CarryOut, Result: out std_logic);
	end component;

	signal ALU_control: std_logic_vector(3 downto 0);
	signal a,b,CarryIn, CarryOut, Result: std_logic;
begin
		-- unit under test
	UUT: one_bit_ALU port map( ALU_control => ALU_control, a=>a, b=>b, CarryIn=>CarryIn, CarryOut=>CarryOut, Result=>Result);

	process
	begin
		ALU_control <= X"0"; --AND
		a <= 1;
		b <= 1;
		CarryIn <= 0;
		wait for 10ps;
		
		ALU_control <= X"1"; -- OR
		a <= 1;
		b <= 1;
		CarryIn <= 0;
		wait for 10ps;
		
		ALU_control <= X"2"; -- ADD
		a <= 1;
		b <= 1;
		CarryIn <= 0;
		wait for 10ps;

		ALU_control <= X"6"; -- subtract
		a <= 1;
		b <= 1;
		CarryIn <= 0;
		wait for 10ps;

		ALU_control <= X"7"; --set on less than
		a <= 1;
		b <= 1;
		CarryIn <= 0;
		wait for 10ps;

		ALU_control <= X"C"; --NOR
		a <= 1;
		b <= 1;
		CarryIn <= 0;
		wait for 10ps;

	end process;
end one_bit_ALU_behav 
