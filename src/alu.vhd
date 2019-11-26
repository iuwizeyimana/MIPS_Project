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
	or_out <= a or  b;
end or_behav;

--now we make the 1 bit ALU entity

library ieee;
use ieee.std_logic_1164.all;
entity one_bit_ALU is port( ALU_control : in std_logic_vector(3 downto 0);
			a,b, CarryIn, clk: in std_logic;
			CarryOut, Result: out std_logic);
end one_bit_ALU;
--our control signal comes in as 4 bit but needs to be split 
-- ALU_control(3) is A_invert, ALU_control(2) is B_invert and ALU_control(1:0) is the operation
architecture ALU_1_behav of one_bit_ALU is
	--let us declare internal signals
	signal a_int, b_int, c_int: std_logic;
	signal and_result, or_result, adder_result, set_result, co : std_logic;
	component FA
		port(a, b, ci: in std_logic;
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
    process(ALU_control,a,b, clk) is 
	begin 
	if rising_edge(clk) then 
	
	-- invert the two inputs in case they need to be inverted
	 --  a_int <= '0';
	    c_int <= CarryIn;
    if ALU_control(3) = '1' then
		 a_int <= not a;
	else 
		a_int <= a;
	end if;
	
	if ALU_control(2) = '1' then
		 b_int <= not b;
	else 
		b_int <= b;
	end if;
	
	end if;
	
	end process;
	
	FA0: FA port map(a => a_int, b => b_int, ci => c_int, s => adder_result, co => co);
	AND0: one_bit_and port map(a => a_int, b => b_int, and_out => and_result);
	OR0: one_bit_or port map(a => a_int,b => b_int, or_out => or_result);
	
	
	process(adder_result, and_result, or_result, clk) is
	begin
	
	if rising_edge(clk) then 
     --   set_result <= adder_result; 	
	case ALU_control(1 downto 0) is
		when "00" => Result <= and_result; 
		when "01" => Result <= or_result;
		when "10" => Result <= adder_result; CarryOut <= co;
		when "11" => Result <= adder_result; CarryOut <= co;
		when others =>  Result <= '0'; CarryOut <= '0';
	end case;
	end if;
	end process;
	
	
end ALU_1_behav;
-- 4 bit ALU
library ieee;
use ieee.std_logic_1164.all;
entity four_bit_ALU is
	port ( ALU_control, a,b: in std_logic_vector (3 downto 0);
		CarryIn, clk: in std_logic;
		CarryOut: out std_logic;
		Result: out std_logic_vector(3 downto 0));
end four_bit_ALU;

architecture four_bit_ALU_behav of four_bit_ALU is
	signal c: std_logic_vector(2 downto 0); -- internal ripple carries
	component one_bit_ALU
		port(ALU_control: in std_logic_vector (3 downto 0);
		     a, b, CarryIn, clk: in std_logic;
		     CarryOut, Result: out std_logic);
	end component;
	begin
		one_bit_ALU0: one_bit_ALU port map(ALU_control => ALU_control, a => a(0),b => b(0), CarryIn => CarryIn, clk => clk, CarryOut => c(0), Result => Result(0));
		one_bit_ALU1: one_bit_ALU port map(ALU_control => ALU_control, a => a(1),b =>  b(1),CarryIn => c(0), clk => clk, CarryOut => c(1),Result => Result(1));
		one_bit_ALU2: one_bit_ALU port map(ALU_control => ALU_control, a => a(2),b => b(2),CarryIn => c(1), clk => clk, CarryOut => c(2),Result => Result(2));
		one_bit_ALU3: one_bit_ALU port map(ALU_control => ALU_control, a => a(3),b => b(3),CarryIn => c(2), clk => clk, CarryOut => CarryOut,Result => Result(3));
end four_bit_ALU_behav;

-- 32 bit ALU	
library ieee;
use ieee.std_logic_1164.all;
entity thirtyTwo_bit_ALU is
	port ( ALU_control: in std_logic_vector(3 downto 0);
		 a,b: in std_logic_vector (31 downto 0);
		clk : in std_logic;  --we don't need a CarryIn input for the 32 bit ALU
		CarryOut: out std_logic;
		Zero: out std_logic;
		Result: out std_logic_vector(31 downto 0));
end thirtyTwo_bit_ALU;

architecture thirtyTwo_bit_ALU_behav of thirtyTwo_bit_ALU is
	signal c: std_logic_vector(7 downto 0); --internal ripple carries
	signal Result_int: std_logic_vector(31 downto 0);
	component four_bit_ALU
		port ( ALU_control, a,b: in std_logic_vector (3 downto 0);
			CarryIn, clk: in std_logic;
			CarryOut: out std_logic;
			Result: out std_logic_vector(3 downto 0));
	end component;
begin
    process(ALU_control) is
    begin
	if (ALU_control = X"6") then --then it's a subtraction
--we will need to make the carryin 1 for the 2's complement as it will be b' plus 1
		c(0) <= '1';
	else 
		c(0) <= '0';
	end if;
     end process;

     process(Result_int) is 
	begin
	 if (Result_int = X"00000000") then Zero <= '1';
		else Zero <= '0';
	end if;
		Result <= Result_int;
     end process;
	
	--now time for the 32 bit ALU using 4 bit ALU components
	four0: four_bit_ALU port map(ALU_control => ALU_control,a => a(3 downto 0),b =>  b(3 downto 0),CarryIn =>  c(0), clk => clk, CarryOut => c(1), Result => Result_int(3 downto 0));
	four1: four_bit_ALU port map(ALU_control => ALU_control,a => a(7 downto 4),b => b(7 downto 4),CarryIn => c(1),clk => clk, CarryOut => c(2),Result =>  Result_int(7 downto 4));
	four2: four_bit_ALU port map (ALU_control => ALU_control,a => a(11 downto 8),b => b(11 downto 8),CarryIn => c(2),clk => clk, CarryOut => c(3), Result => Result_int(11 downto 8));
	four3: four_bit_ALU port map(ALU_control => ALU_control,a => a(15 downto 12),b => b(15 downto 12),CarryIn => c(3),clk => clk, CarryOut => c(4),Result => Result_int(15 downto 12));
	four4: four_bit_ALU port map(ALU_control => ALU_control,a => a(19 downto 16),b => b(19 downto 16),CarryIn => c(4),clk => clk, CarryOut => c(5),Result => Result_int(19 downto 16));
	four5: four_bit_ALU port map (ALU_control => ALU_control,a => a(23 downto 20),b => b(23 downto 20),CarryIn => c(5),clk => clk, CarryOut => c(6),Result => Result_int(23 downto 20));
	four6: four_bit_ALU port map(ALU_control => ALU_control,a => a(27 downto 24),b => b(27 downto 24),CarryIn => c(6), clk => clk, CarryOut => c(7),Result => Result_int(27 downto 24));
	four7: four_bit_ALU port map(ALU_control => ALU_control,a => a(31 downto 28),b => b(31 downto 28),CarryIn => c(7),clk => clk, CarryOut => CarryOut, Result => Result_int(31 downto 28));
	


end thirtyTwo_bit_ALU_behav;
	

