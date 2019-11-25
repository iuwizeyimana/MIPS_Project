library ieee;
use ieee.std_logic_1164.all;

entity control_tb is
end control_tb;

architecture behavioral of control_tb is 
    signal op                                                : std_logic_vector(5 downto 0);
    signal ck, pWC, pW, I, mR, mW, MtR, IW, aluA, regW, regD : std_logic;
    signal pcS, aluB, aluOP                                  : std_logic_vector(1 downto 0);

    -- The component we are testing is the control unit,
    -- so we declare that component here.
    component control is
        port(opcode: in std_logic_vector(5 downto 0);
             clk: in std_logic;
             PCWriteCond, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, ALUSrcA, RegWrite, RegDst: out std_logic;
             PCSource, ALUSrcB, ALUOp: out std_logic_vector(1 downto 0));
    end component control;

begin

    -- 'uut' stands for unit under test
    -- And the unit we are testing is the
    -- control unit.
    uut : control

    -- As we did for the full-adder project,
    -- we must map each input and output of the control unit
    -- to the signals we declared eariler. 
    port map (
        opcode => op,
        clk => ck,
        PCWriteCond => pWC,
        PCWrite => pW,
        IorD => I,
        MemRead => mR,
        MemWrite => mW,
        MemtoReg => MtR,
        IRWrite => IW,
        ALUSrcA => aluA,
        RegWrite => regW,
        regDst => regD,
        PCSource => pcS,
        ALUSrcB => aluB,
        ALUOp => aluOP
    );

    gen_clk : process
    begin
        ck <= '0';
        wait for 1 ns;
        ck <= '1';
        wait for 1 ns;
    end process;

    -- The test for the control unit is very simple,
    -- as all the tests just test each opcode we must implement.
    -- And we check if the right control signals are asserted through
    -- the waveform viewer.
    process is
    begin
        wait for 1 ns;
        op <= "100011";
        wait for 2 ns;
        op <= "000000";
        wait for 2 ns;
        op <= "000010";
        wait for 2 ns;
        op <= "000100";
        wait for 2 ns;
        op <= "001000";
        wait for 1 ns;
    end process;
end behavioral;



