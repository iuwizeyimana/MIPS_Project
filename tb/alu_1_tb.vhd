library ieee;
use ieee.std_logic_1164.all;

entity one_bit_ALU_tb is
end one_bit_ALU_tb;

architecture one_bit_ALU_behav of one_bit_ALU_tb is 
	component one_bit_ALU
		port(ALU_control: in std_logic_vector(3 downto 0);
			a,b, CarryIn, clk: in std_logic;
			CarryOut, Result: out std_logic);
	end component;

	signal ALU_control: std_logic_vector(3 downto 0);
	signal a,b,CarryIn, clk, CarryOut, Result: std_logic;
begin
		-- unit under test
	UUT: one_bit_ALU port map( ALU_control => ALU_control, a=>a, b=>b, CarryIn=>CarryIn, clk => clk,  CarryOut=>CarryOut, Result=>Result);

    gen_clk: process 
    begin
        clk <= '0';
        wait for 5ps; 
        clk <= '1';
        wait for 5ps;
    end process;
	process
	begin
		ALU_control <= X"0"; --AND
		a <= '1';
		b <= '0';
		CarryIn <= '0';
		wait for 10ps;
		
		ALU_control <= X"1"; -- OR
		a <= '0';
		b <= '1';
		CarryIn <= '0';
		wait for 10ps;
		
		ALU_control <= X"2"; -- ADD
		a <= '1';
		b <= '0';
		CarryIn <= '0';
		wait for 10ps;

		ALU_control <= X"6"; -- subtract
		a <= '1';
		b <= '0';
		CarryIn <= '0';
		wait for 10ps;

		ALU_control <= X"7"; --set on less than
		a <= '0';
		b <= '0';
		CarryIn <= '0';
		wait for 10ps;

		ALU_control <= X"C"; --NOR
		a <= '0';
		b <= '0';
		CarryIn <= '0';
		wait for 10ps;

	end process;
end one_bit_ALU_behav;

-- 4 bit ALU TB

library ieee;
use ieee.std_logic_1164.all;

entity four_bit_ALU_tb is
end four_bit_ALU_tb;

architecture four_bit_ALU_behav of four_bit_ALU_tb is 
	component four_bit_ALU
		port(ALU_control, a, b: in std_logic_vector(3 downto 0);
			CarryIn, clk: in std_logic;
			CarryOut: out std_logic;
			Result: out std_logic_vector(3 downto 0) );
	end component;

	signal ALU_control, a, b, Result: std_logic_vector(3 downto 0);
	signal CarryIn, clk, CarryOut : std_logic;
begin
		-- unit under test
	UUT: four_bit_ALU port map( ALU_control => ALU_control, a=>a, b=>b, CarryIn=>CarryIn,clk => clk, CarryOut=>CarryOut, Result=>Result);
    
    gen_clk: process 
    begin
        clk <= '0';
        wait for 5ps; 
        clk <= '1';
        wait for 5ps;
    end process;

	process
	begin
		ALU_control <= X"0"; --AND
		a <= "0110";
		b <= "1100";
		CarryIn <= '0';
		wait for 10ps;
		
		ALU_control <= X"1"; -- or
		a <= "0110";
		b <= "1100";
		CarryIn <= '0';
		wait for 10ps;
		
		ALU_control <= X"2";  -- add
		a <= "0110";
		b <= "1100";
		CarryIn <= '0';
		wait for 10ps;
		
		ALU_control <= X"6"; --sub
		a <= "0110";
		b <= "1100";
		CarryIn <= '0';
		wait for 10ps;
		
		ALU_control <= X"7"; --slt
		a <= "0110";
		b <= "1100";
		CarryIn <= '0';
		wait for 10ps;
		
		ALU_control <= X"C"; --NOR
		a <= "0110";
		b <= "1100";
		CarryIn <= '0';
		wait for 10ps;
		
	end process;
end four_bit_ALU_behav;

