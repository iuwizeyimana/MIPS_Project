library ieee;
use ieee.std_logic_1164.all;

entity alu_control_tb is
end alu_control_tb;

architecture alu_control_tb_behav of alu_control_tb is 
	component alu_control
		port(ALUOP : in std_logic_vector(1 downto 0);
		     func_code : in std_logic_vector(5 downto 0);
		     clk: in std_logic;
		     ALU_control_code: out std_logic_vector(3 downto 0) );
	end component;

	signal ALUOP: std_logic_vector(1 downto 0);
	signal func_code: std_logic_vector(5 downto 0);
	signal clk:  std_logic;
	signal ALU_control_code: std_logic_vector(3 downto 0);
begin
		-- unit under test
	UUT: alu_control port map( ALUOP => ALUOP, func_code => func_code,  clk => clk, ALU_control_code=> ALU_control_code);
    
    gen_clk: process 
    begin
        clk <= '0';
        wait for 1 ps; 
        clk <= '1';
        wait for 1 ps;
    end process;

	process
	begin
	
	wait for 1 ps;
	func_code <= "100000";
	ALUOP <= "10";
	wait for 2 ps;

	func_code <= "100010";
	ALUOP <= "10";
	wait for 2 ps;

	func_code <= "100100";
	ALUOP <= "10";
	wait for 2 ps;

	ALUOP <= "01";
	wait for 2 ps;

	ALUOP <= "00";
	wait for 2 ps;
	   
	end process;
end alu_control_tb_behav; 
