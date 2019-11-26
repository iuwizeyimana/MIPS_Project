library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity mips is 
    port(
            clk:         in std_logic;
            current_pc:  in std_logic_vector(31 downto 0);
            instruction: in std_logic_vector(31 downto 0);
            ALUout:      out std_logic_vector(31 downto 0);
            new_pc:      out std_logic_vector(31 downto 0)
        );
end mips;

architecture behavioral of mips is
    signal PC_INT            : std_logic_vector(31 downto 0);
    signal OPCODE            : std_logic_vector(5 downto 0);
    signal REG1              : std_logic_vector(4 downto 0);
    signal REG2              : std_logic_vector(4 downto 0);
    signal IMM_OUT           : std_logic_vector(15 downto 0);
    signal MUX_IR_OUT        : std_logic_vector(4 downto 0);
    signal FUNC_CODE         : std_logic_vector(5 downto 0);
    signal WRITE_REG         : std_logic_vector(4 downto 0);
    signal IMM_32EXT         : std_logic_vector(31 downto 0);
    signal SL2_32            : std_logic_vector(31 downto 0);
    signal READDATA2         : std_logic_vector(31 downto 0);
    signal READDATA1         : std_logic_vector(31 downto 0);
    signal READDATA1_MUX_OUT : std_logic_vector(31 downto 0);
    signal READDATA2_MUX_OUT : std_logic_vector(31 downto 0);
    signal ALUCTRL_SIGNAL    : std_logic_vector(3 downto 0);
    signal ALU_RESULT        : std_logic_vector(31 downto 0);
    signal ALU_ZERO          : std_logic;
    signal SL2_26_IN         : std_logic_vector(25 downto 0); -- Input to SL2 unit 
    signal SL2_26_TO_28      : std_logic_vector(27 downto 0); -- Output from SL2 unit
    signal JUMP_ADDR         : std_logic_vector(31 downto 0); -- Real jump address
    signal NEW_PC_MUX_OUT    : std_logic_vector(31 downto 0);
    signal PCWRITECOND       : std_logic;
    signal PCWRITE           : std_logic;
    signal IORD              : std_logic;
    signal MEMREAD           : std_logic;
    signal MEMWRITE          : std_logic;
    signal MEMTOREG          : std_logic;
    signal IRWRITE           : std_logic;
    signal PCSOURCE          : std_logic_vector(1 downto 0);
    signal ALUOP             : std_logic_vector(1 downto 0);
    signal ALUSRCB           : std_logic_vector(1 downto 0);
    signal ALUSRCA           : std_logic;
    signal REGWRITE          : std_logic;
    signal REGDST            : std_logic;

    component pc is
        port(input:  in std_logic_vector(31 downto 0);
             clk:    in std_logic;
             output: out std_logic_vector(31 downto 0));
    end component pc;

    component ir is
		port(instruction: in std_logic_vector(31 downto 0);
			 IRWrite: in std_logic;
             clk: in std_logic;
			 opcode, func_code: out std_logic_vector(5 downto 0);
			 reg1, reg2, mux_output: out std_logic_vector(4 downto 0);
			 shift_output: out std_logic_vector(25 downto 0);
			 immediate_output: out std_logic_vector(15 downto 0));
    end component ir;

    component control is
        port(opcode: in std_logic_vector(5 downto 0);
             clk: in std_logic;
             PCWriteCond, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, ALUSrcA, RegWrite, RegDst: out std_logic;
             PCSource, ALUSrcB, ALUOp: out std_logic_vector(1 downto 0));
    end component control;

    component mux2 is
        port(selector: in std_logic;
             input1, input2: in std_logic_vector(31 downto 0);
             clk: in std_logic;
             output: out std_logic_vector(31 downto 0));
    end component mux2;

    component mux2_5bit is
        port(selector: in std_logic;
             input1, input2: in std_logic_vector(4 downto 0);
             clk: in std_logic;
             output: out std_logic_vector(4 downto 0));
    end component mux2_5bit;

    component sign_ext is
        port(input: in std_logic_vector(15 downto 0);
             clk: std_logic;
             output: out std_logic_vector(31 downto 0));
    end component sign_ext;

    component shiftleft2 is
        port(input: in std_logic_vector(31 downto 0);
             clk: in std_logic;
             output: out std_logic_vector(31 downto 0));
    end component shiftleft2;

    component regfile is
        port(readRegisterFile1: in std_logic_vector(4 downto 0);
             readRegisterFile2: in std_logic_vector(4 downto 0);
             writeRegister: in std_logic_vector(4 downto 0);
             writeData: in std_logic_vector(31 downto 0);
             regWrite: in std_logic;
             clk: in std_logic;
             readData1: out std_logic_vector(31 downto 0);
             readData2: out std_logic_vector(31 downto 0));
    end component regfile;

    component mux4 is
        port(selector: in std_logic_vector(1 downto 0);
             input1, input2, input3: in std_logic_vector(31 downto 0);
             clk: in std_logic;
             output: out std_logic_vector(31 downto 0));
    end component mux4;

    component thirtyTwo_bit_ALU
		port(ALU_control : in std_logic_vector(3 downto 0);
		     a, b: in std_logic_vector(31 downto 0);
			clk: in std_logic;
			CarryOut: out std_logic;
			Zero: out std_logic;
			Result: out std_logic_vector(31 downto 0) );
	end component;

    component alu_control
		port(ALUOP : in std_logic_vector(1 downto 0);
		     func_code : in std_logic_vector(5 downto 0);
		     clk: in std_logic;
		     ALU_control_code: out std_logic_vector(3 downto 0) );
	end component;

    component shiftleft1 is -- 26 to 28 bits
        port(input: in std_logic_vector(25 downto 0);
             clk: in std_logic;
             output: out std_logic_vector(27 downto 0));
    end component shiftleft1;

    component mux3 is
        port(selector: in std_logic_vector(1 downto 0);
             input1, input2, input3: in std_logic_vector(31 downto 0);
             clk: in std_logic;
             output: out std_logic_vector(31 downto 0));
    end component mux3;

begin

    mips_ir : ir

    port map ( 
        instruction      => instruction,
        IRWrite          => IRWRITE,
        clk              => clk,
        opcode           => OPCODE,
        func_code        => FUNC_CODE,
        reg1             => REG1,
        reg2             => REG2,
        mux_output       => MUX_IR_OUT,
        shift_output     => SL2_26_IN,
        immediate_output => IMM_OUT
    );

    write_reg_mux : mux2_5bit

    port map ( 
        selector => MEMTOREG,
        input1   => REG2,
        input2   => MUX_IR_OUT,
        clk      => clk,
        output   => WRITE_REG
    );

    mips_regfile : regfile

    port map ( 
        readRegisterFile1 => REG1,
        readRegisterFile2 => REG2,
        writeRegister     => WRITE_REG,
        -- TODO: Figure out what writeData should map to
        --writeData         => ,
        regWrite          => REGWRITE,
        clk               => clk,
        readData1         => READDATA1,
        readData2         => READDATA2
    );

    mips_sign_ext : sign_ext

    port map (
        input  => IMM_OUT,
        clk    => clk,
        output => IMM_32EXT
    );

    mips_sl2_32 : shiftleft2

    port map (
        input  => IMM_32EXT,
        clk    => clk,
        output => SL2_32
    );

    alu_input_1 : mux2

    port map (
        selector => ALUSRCA,
        input1   => READDATA1,
        input2   => current_pc,
        clk      => clk,
        output   => READDATA1_MUX_OUT
    );

    alu_input_2 : mux4

    port map (
        selector => ALUSRCB,
        input1   => READDATA2,
        input2   => IMM_32EXT,
        input3   => SL2_32,
        clk      => clk,
        output   => READDATA2_MUX_OUT
    );

    mips_alu_control : alu_control

    port map (
        ALUOP            => ALUOP,
        func_code        => FUNC_CODE,
        clk              => clk,
        ALU_control_code => ALUCTRL_SIGNAL
    );

    mips_alu : thirtyTwo_bit_ALU

    port map (
        ALU_control => ALUCTRL_SIGNAL,
        a           => READDATA1_MUX_OUT,
        b           => READDATA2_MUX_OUT,
        clk         => clk,
        -- TODO: Figure out what CarryOut should map to
        --CarryOut    => ,
        Zero        => ALU_ZERO,
        Result      => ALU_RESULT
    );

    mips_sl2_26_28 : shiftleft1

    port map (
        input  => SL2_26_IN,
        clk    => clk,
        output => SL2_26_TO_28
    );

    mips_new_pc : mux3
    
    port map (
        selector => PCSOURCE,
        input1   => ALU_RESULT,
        input2   => PC_INT,
        input3   => JUMP_ADDR,
        clk      => clk,
        output   => new_pc
    );

    mips_control_unit : control

    port map (
        opcode      => OPCODE,
        clk         => clk,
        PCWriteCond => PCWRITECOND,
        IorD        => IORD,
        MemRead     => MEMREAD,
        MemWrite    => MEMWRITE,
        MemtoReg    => MEMTOREG,
        IRWrite     => IRWRITE,
        ALUSrcA     => ALUSRCA,
        RegWrite    => REGWRITE,
        RegDst      => REGDST,
        PCSource    => PCSOURCE,
        ALUSrcB     => ALUSRCB,
        ALUOp       => ALUOP
    );

    JUMP_ADDR(31 downto 28) <= current_pc(31 downto 28);
    JUMP_ADDR(27 downto 0)  <= SL2_26_to_28;
    PC_INT                  <= current_pc + 4;
end behavioral;
