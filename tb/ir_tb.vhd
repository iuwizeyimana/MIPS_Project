library ieee;
use ieee.std_logic_1164.all;

entity ir_tb is
end ir_tb;

architecture behavioral of ir_tb is 
    signal i            : std_logic_vector(31 downto 0);
    signal iW           : std_logic;
    signal op           : std_logic_vector(5 downto 0);
    signal r1,r2,muxOut : std_logic_vector(4 downto 0);
    signal shiftOut     : std_logic_vector(25 downto 0);
    signal immOut       : std_logic_vector(15 downto 0);

    -- The component we are testing is the instruction register,
    -- so we declare that component here.
	component ir is
		port(instruction: in std_logic_vector(31 downto 0);
			 IRWrite: in std_logic;
			 opcode: out std_logic_vector(5 downto 0);
			 reg1, reg2, mux_output: out std_logic_vector(4 downto 0);
			 shift_output: out std_logic_vector(25 downto 0);
			 immediate_output: out std_logic_vector(15 downto 0));
    end component ir;

begin

    -- 'uut' stands for unit under test
    -- And the unit we are testing is the
    -- instruction register.
    uut : ir

    -- As we did for the full-adder project,
    -- we must map each input and output of the instruction register
    -- to the signals we declared eariler. 
    port map (
        instruction 	 => i,
        IRWrite 		 => iW,
	    opcode 			 => op,
        reg1 			 => r1,
        reg2 			 => r2,
		mux_output 		 => muxOut,
		shift_output 	 => shiftOut,
	    immediate_output => immOut
    );

	-- Example program and its disassembly:
	-- Assume all numbers displayed are in hex unless stated otherwise
	-- Opcodes verified using: DrMIPS, MARS, and https://alanhogan.com/asu/assembler.php
    -- LOOP: (At address 00400000)
        -- lw $t1, 100($t2)   (8d490064)
        -- add $s1, $t2, $s7  (01578820)
        -- sub $t1, $t3, $t8  (01784822)
        -- and $t1, $t2, $t3  (014b4824)
        -- or $s1, $s2, $s3   (02538825)
        -- beq $t1, $t2, LOOP (112afffa)
        -- addi $t4, $t2, 100 (214c0064)
        -- j LOOP			  (08100000)

    process is
    begin
        i  <= x"8d490064";
        iW <= '1';
        wait for 1 ns;
        i  <= x"01578820";
        iW <= '1';
        wait for 1 ns;
        i  <= x"01784822";
        iW <= '1';
        wait for 1 ns;
        i  <= x"014b4824";
        iW <= '1';
        wait for 1 ns;
        i  <= x"02538825";
        iW <= '1';
        wait for 1 ns;
        i  <= x"112afffa";
        iW <= '1';
        wait for 1 ns;
        i  <= x"214c0064";
        iW <= '1';
        wait for 1 ns;
        i  <= x"08100000";
        iW <= '1';
        wait for 1 ns;
    end process;
end behavioral;



