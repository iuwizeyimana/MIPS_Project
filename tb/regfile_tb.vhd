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

    -- The component we are testing is the register file,
    -- so we declare that component here.
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

    -- 'uut' stands for unit under test
    -- And the unit we are testing is the
    -- regsiter file.
    uut : regfile

    -- As we did for the full-adder project,
    -- we must map each input and output of the register file
    -- to the signals we declared eariler. 
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

    -- We have to generate a clock to use for our register file!
    -- This clock is simple and flips every nanosecond.
    gen_clk : process
    begin
        ck <= '0';
        wait for 1 ns;
        ck <= '1';
        wait for 1 ns;
    end process;

    -- The first test asserts the regWrite signal, and we are 
    -- attempting to write to register 0. However, since the clock
    -- is low, the output (rD1) will not be the data we are attempting
    -- to write to the 0th register. The second test works similarly,
    -- but this time the clock is on the rising edge and the data we write
    -- should be an output. The third test is the same as the first, but
    -- the regWrite signal is not asserted. The 4th-6th tests are similar
    -- to the first three but another register is tested.
    process is
    begin
        rW <= '1';
        wR <= "00000";
        wD <= x"DEADBEEF";
        rR1 <= "00000";
        rR2 <= "00001";
        wait for 1 ns;
        rW <= '1';
        wR <= "00000";
        wD <= x"BABECAFE";
        rR1 <= "00000";
        rR2 <= "00001";
        wait for 1 ns;
        rW <= '0';
        wR <= "00000";
        wD <= x"ABADCAFE";
        rR1 <= "00000";
        rR2 <= "00001";
        wait for 1 ns;
        rW <= '1';
        wR <= "00001";
        wD <= x"BAADF00D";
        rR1 <= "00000";
        rR2 <= "00001";
        wait for 1 ns;
        rW <= '1';
        wR <= "00001";
        wD <= x"BEEFBABE";
        rR1 <= "00000";
        rR2 <= "00001";
        wait for 1 ns;
        rW <= '0';
        wR <= "00001";
        wD <= x"BADDCAFE";
        rR1 <= "00000";
        rR2 <= "00001";
        wait for 1 ns;
    end process;
end behavioral;



