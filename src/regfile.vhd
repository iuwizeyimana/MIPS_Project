library ieee;
use ieee.std_logic_1164.all;
-- The numeric_std package is used to convert std_logic_vector to integer
use ieee.numeric_std.all;

-- The register file is straight-forward, featuring 5 inputs
-- and 2 outputs. readRegisterFileN inputs specify 
-- which registers to read, writeRegister describes what 
-- register to write to, writeData specifies what data you're
-- writing, regWrite is a control signal saying if you're
-- actually writing to a register or not.

-- The two outputs (readDataN) just are the register data
-- you read from the two registers described eariler.

-- There is an additional clk input to synchronize 

entity regfile is 
    port(readRegisterFile1: in std_logic_vector(4 downto 0);
         readRegisterFile2: in std_logic_vector(4 downto 0);
         writeRegister: in std_logic_vector(4 downto 0);
         writeData: in std_logic_vector(31 downto 0);
         regWrite: in std_logic;
         clk: in std_logic;
         readData1: out std_logic_vector(31 downto 0);
         readData2: out std_logic_vector(31 downto 0));
end regfile;

architecture behavioral of regfile is
    -- In the MIPS ISA, there are 32 32-bit registers.
    -- Thus, create an array of 32-bit registers, each register 
    -- holding a 32-bit value
    type reg_arr is array(0 to 31) of std_logic_vector(31 downto 0);
    signal reg_data :
    reg_arr := reg_arr'(
                       x"00000000", x"00000000", x"00000000", x"00000000", 
                       x"00000000", x"00000000", x"00000000", x"00000000", 
                       x"00000000", x"00000000", x"00000000", x"00000000",
                       x"00000000", x"00000000", x"00000000", x"00000000", 
                       x"00000000", x"00000000", x"00000000", x"00000000",
                       x"00000000", x"00000000", x"00000000", x"00000000", 
                       x"00000000", x"00000000", x"00000000", x"00000000",
                       x"00000000", x"00000000", x"00000000", x"00000000"
                     );

begin

-- In the clocked process below, we are synchronizing the regWrite signal
-- with the clock. In the aptly named process 'writeReg' below, if the 
-- clock is on the rising edge, and the regWrite signal is 1, we write the
-- data to the appropriate register. 
writeReg: process(clk) is
begin
    if rising_edge(clk) then
        -- The primary behavior of the register file is to output
        -- the data associated with the registers determined by the
        -- readRegisterFileN inputs.
        readData1 <= reg_data(to_integer(unsigned(readRegisterFile1)));
        readData2 <= reg_data(to_integer(unsigned(readRegisterFile2)));
        if regWrite = '1' then
            reg_data(to_integer(unsigned(writeRegister))) <= writeData;
        end if;
    end if;
end process;
end behavioral;
