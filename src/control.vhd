library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Signals and their description:
-- PCWriteCond: Load conditionally branch address into PC if Zero = 1
-- PCWrite: Load unconditionally next instruction address into PC
-- IorD: Read data from either PC address or LW address
-- MemRead and MemWrite: Read or write for memory
-- MemtoReg: Write data from either Memory Data Register (MDR) or ALUoutput (R-type)
-- IRWrite: Controls whether to write to instruction register
-- ALUSrcA: Selects either the PC or RegFile(IR[25-21]) data for one of the ALU's operands
-- RegWrite: Controls whether to write to register file
-- RegDst: Specifies which register to write to, either IR[20-16] from LW or IR[15-11] from R-Type Instructions
-- PCSource: Selects one of the three possible choices for new PC (00: PC + 4) (01: ALUout from beq) (10: j-type addr)
-- ALUSrcB: Selects one of four possible choices for the second ALU operand:
    -- 00: RegFile(IR[20-16]) for R-Type
    -- 01: 4 for PC = PC + 4
    -- 10: sign_extend(IR[15-0]) for LW
    -- 11: shift_left2(sign_extend(IR[15-0])) for beq
-- ALUOp: Selects which ALU operation to perform

entity control is
    port(opcode: in std_logic_vector(5 downto 0);
         clk: in std_logic;
         PCWriteCond, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, ALUSrcA, RegWrite, RegDst: out std_logic;
         PCSource, ALUSrcB, ALUOp: out std_logic_vector(1 downto 0));
end control; 

architecture behavioral of control is
begin
    selecting: process(opcode, clk)
    begin
        if rising_edge(clk) then
            case opcode is
                when "100011" => -- lw
                    PCWriteCond <= '0';
                    PCWrite <= '1';
                    IorD <= '1';
                    MemRead <= '1';
                    MemWrite <= '0';
                    MemtoReg <= '1';
                    IRWrite <= '1';
                    ALUSrcA <= '1';
                    RegWrite <= '1';
                    RegDst <= '0';
                    PCSource <= "00";
                    ALUSrcB <= "10";
                    ALUOp <= "00";
                when "000000" => -- add
                    PCWriteCond <= '0';
                    PCWrite <= '1';
                    IorD <= '0';
                    MemRead <= '1';
                    MemWrite <= '0';
                    MemtoReg <= '0';
                    IRWrite <= '1';
                    ALUSrcA <= '1';
                    RegWrite <= '1';
                    RegDst <= '1';
                    PCSource <= "00";
                    ALUSrcB <= "00";
                    ALUOp <= "10";
                when "000010" => -- j
                    PCWriteCond <= '0';
                    PCWrite <= '1';
                    IorD <= '0';
                    MemRead <= '1';
                    MemWrite <= '0';
                    MemtoReg <= '0';
                    IRWrite <= '1';
                    ALUSrcA <= '0';
                    RegWrite <= '0';
                    RegDst <= '0';
                    PCSource <= "10";
                    ALUSrcB <= "00";
                    ALUOp <= "10";
                when "000100" => -- beq
                    PCWriteCond <= '1';
                    PCWrite <= '1';
                    IorD <= '0';
                    MemRead <= '1';
                    MemWrite <= '0';
                    MemtoReg <= 'X';
                    IRWrite <= '0';
                    ALUSrcA <= '0';
                    RegWrite <= '0';
                    RegDst <= 'X';
                    PCSource <= "01";
                    ALUSrcB <= "11";
                    ALUOp <= "01";
                when "001000" => -- addi
                    PCWriteCond <= '0';
                    PCWrite <= '1';
                    IorD <= '0';
                    MemRead <= '1';
                    MemWrite <= '0';
                    MemtoReg <= '0';
                    IRWrite <= '0';
                    ALUSrcA <= '0';
                    RegWrite <= '1';
                    RegDst <= '1';
                    PCSource <= "01";
                    ALUSrcB <= "11";
                    ALUOp <= "00";
                when others =>
            end case;
        end if;
end process;
end behavioral;


