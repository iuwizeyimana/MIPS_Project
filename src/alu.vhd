-- One bit ALU 
--our input to the ALU would be the 4 bit ALU control signal our input A and B and Carryin
-- for the 4 bit ALU signal, the most significant bit will be used as a select for A_invert in the A_invert Mux, the next bit as the select for the B_invert Mux and the last two to select the operation at hand
--we will first make the adder, and and or entities then use those to create the ALU entity
library ieee;
use ieee.std_logic_1164.all;
-- 1 bit full adder
entity FA is 
	port (a, b, ci: in std_logic;
		s, co: out std_logic);
end FA;
-- 1 bit adder architecture
architecture addition of FA is 
begin
	s<= (a xor b) xor ci;
    co <= (a and b) or (ci and (a xor b));
end addition;

library ieee;
use ieee.std_logic_1164.all;
-- 1 bit and
entity one_bit_and is 
	port (a, b: in std_logic;
		and_out: out std_logic);
end one_bit_and;
-- 1 bit and architecture
architecture and_behav  of one_bit_and is 
begin
	and_out <= a and  b;
end and_behav;

library ieee;
use ieee.std_logic_1164.all;
-- 1 bit full or
entity one_bit_or is 
	port (a, b: in std_logic;
		or_out: out std_logic);
end one_bit_or;
-- 1 bit or architecture
architecture or_behav  of one_bit_or is 
begin
	or_out <= a and  b;
end or_behav;

--now we make the 1 bit ALU entity
library ieee;
use ieee.std_logic_1164.all;
entity one_bit_ALU is port ( ALU_control : in std_logic_vector(3 downto 0);
			a,b, CarryIn: in std_logic;
			CarryOut, Result: out std_logic);
end one_bit_ALU;
--our control signal comes in as 4 bit but needs to be split 
-- ALU_control(3) is A_invert, ALU_control(2) is B_invert and ALU_control(1:0) is the operation
architecture ALU_1_behav of one_bit_ALU is
	--let us declare internal signals
	signal a_int, b_int: std_logic;
	signal and_result, or_result, adder_result, set_result: std_logic;
	component FA
		port(a, b, c: in std_logic;
		     s, co: out std_logic);
	end component;

	component one_bit_and
		port(a, b: in std_logic;
		     and_out: out std_logic);
	end component;

	component one_bit_or
		port(a, b: in std_logic;
		     or_out: out std_logic);
	end component;
begin 
	-- invert the two inputs in case they need to be inverted
	if ALU_control(3) then
		 a_int <= not a;
	else 
		a_int <= a;
	end if;
	
	if ALU_control(2) then
		 b_int <= not b;
	else 
		b_int <= b;
	end if;
	

	FA0: FA port map(a_int, b_int, CarryIn, adder_result, CarryOut);
	AND0: one_bit_and port map(a_int, b_int,and_result);
	OR0: one_bit_or port map(a_int, b_int, or_result);
	
	if (adder_result > 0) then 
			set_result <= 1; --set on less than, b<a
	else 
			set_result <= 0;
	end if;
	-- the last 2 bits of the ALU control are used in the mux (switch case) to select the operation 
	case ALU_control(1:0) is
		when "00" => Result <= and_result;
		when "01" => Result <= or_result;
		when "10" => Result <= add_result;
		when "11" => Result <= set_result;
		when others => Result <= 0;
end ALU_1_behav;

-- 4 bit ALU
library ieee;
use ieee.std_logic_1164.all;
entity four_bit_ALU is
	port ( ALU_control, a,b: in std_logic_vector (3 downto 0);
		CarryIn: in std_logic;
		CarryOut: out std_logic;
		Result: out std_logic_vector(3 downto 0));
end four_bit_ALU;

architecture four_bit_ALU_behav of four_bit_ALU is
	signal c: std_logic_vector(2 downto 0); -- internal ripple carries
	component one_bit_ALU
		port(ALU_control: in std_logic_vector (3 downto 0);
		     a, b, CarryIn: in std_logic;
		     CarryOut, Result: out std_logic);
	end component;
	begin
		one_bit_ALU0: one_bit_ALU port map(ALU_control, a(0), b(0), CarryIn, c(0), Result(0));
		one_bit_ALU1: one_bit_ALU port map(ALU_control, a(1), b(1), c(0), c(1), Result(1));
		one_bit_ALU2: one_bit_ALU port map(ALU_control, a(2), b(2), c(1), c(2), Result(2));
		one_bit_ALU3: one_bit_ALU port map(ALU_control, a(3), b(3), c(2), CarryOut, Result(3));
end four_bit_ALU_behav;

-- 32 bit ALU	
library ieee;
use ieee.std_logic_1164.all;
entity thirtyTwo_bit_ALU is
	port ( ALU_control: in std_logic_vector(3 downto 0);
		 a,b: in std_logic_vector (31 downto 0);
	--	CarryIn: in std_logic; we don't need a CarryIn input for the 32 bit ALU
		CarryOut: out std_logic;
		Result: out std_logic_vector(31 downto 0));
end thirtyTwo_bit_ALU;

architecture thirtyTwo_bit_ALU_behav of thirtyTwo_bit_ALU is
	signal c: std_logic_vector(7 downto 0); --internal ripple carries

	component four_bit_ALU
		port ( ALU_control, a,b: in std_logic_vector (3 downto 0);
			CarryIn: in std_logic;
			CarryOut: out std_logic;
			Result: out std_logic_vector(3 downto 0));
	end component;
begin
	if (ALU_control = X"6") then --then it's a subtraction
--we will need to make the carryin 1 for the 2's complement as it will be b' plus 1
		c(0) <= 1;
	else 
		c(0) <= 0;
	end if;
	
	--now time for the 32 bit ALU using 4 bit ALU components
	four0: four_bit_ALU(ALU_control, a(3 downto 0), b(3 downto 0), c(0), c(1), Result(3 downto 0));
	four1: four_bit_ALU(ALU_control, a(7 downto 4), b(7 downto 4), c(1), c(2), Result(7 downto 4));
	four2: four_bit_ALU(ALU_control, a(11 downto 8), b(11 downto 8), c(2), c(3), Result(11 downto 8));
	four3: four_bit_ALU(ALU_control, a(15 downto 12), b(15 downto 12), c(3), c(4), Result(15 downto 12));
	four4: four_bit_ALU(ALU_control, a(19 downto 16), b(19 downto 16), c(4), c(5), Result(19 downto 16));
	four5: four_bit_ALU(ALU_control, a(23 downto 20), b(23 downto 20), c(5), c(6), Result(23 downto 20));
	four6: four_bit_ALU(ALU_control, a(27 downto 24), b(27 downto 24), c(6), c(7), Result(27 downto 24));
	four7: four_bit_ALU(ALU_control, a(31 downto 28), b(31 downto 28), c(7), CarryOut, Result(31 downto 28));

end thirtyTwo_bit_ALU_behav;
	
