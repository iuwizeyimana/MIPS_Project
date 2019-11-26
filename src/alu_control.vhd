library ieee;
use ieee.std_logic_1164.all;

entity alu_control is port(ALUOP: in std_logic_vector(1 downto 0);
			  func_code: in std_logic_vector(5 downto 0);
			  clk: in std_logic;
			 ALU_control_code: out std_logic_vector(3 downto 0));
end alu_control;

architecture alu_control_behav of alu_control  is
begin 
    process(ALUOP, func_code, clk) is 
	begin 
	if rising_edge(clk) then 
	case ALUOP is
		when "00" => ALU_control_code <= "0010"; 
		when "01" => ALU_control_code <= "0110";
		when "10" => 
			if func_code = "100000" then ALU_control_code <= "0010"; 
			elsif func_code = "100010" then ALU_control_code <= "0110";
			elsif func_code = "100100" then ALU_control_code <= "0000"; end if;
		when others =>  ALU_control_code <= "1111";
	end case;
	end if;
	end process;
	
	
end alu_control_behav;
