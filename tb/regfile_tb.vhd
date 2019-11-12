library ieee;
use ieee.std_logic_1164.all;

entity regfile_tb is
end regfile_tb;

-- rW = regWrite enable signal
-- rR1, rR2 = readRegisterFile1 and 2
-- wR = writeRegister (register # to write data to)
-- wD = writeData (data to write to register)
-- rD1, rD2 = the data we read from the registers

architecture behavioral of regfile_tb is 
    signal rW, ck       : std_logic;
    signal rR1, rR2, wR : std_logic_vector(4 downto 0);
    signal wD, rD1, rD2 : std_logic_vector(31 downto 0);

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

begin

    uut : regfile
    port map (
        readRegisterFile1 => rR1,
        readRegisterFile2 => rR2,
        writeRegister     => wR,
        writeData         => wD,
        regWrite          => rW,
        clk               => ck,
        readData1         => rD1,
        readData2         => rD2
    );

    process is
    begin
        rR1 <= "01000";
        rR2 <= "01001";
        wait for 2 ns;
        wR <= "01000";
        wD <= x"0000000A";
        wait for 2 ns;
        rR1 <= "01000";
        rR2 <= "01001";
        wait for 10 ns;
    end process;
end behavioral;



