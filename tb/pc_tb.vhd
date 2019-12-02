library ieee;
use ieee.std_logic_1164.all;

entity pc_tb is
end pc_tb;

architecture behavioral of pc_tb is 
    signal x, y       : std_logic_vector(31 downto 0);
    signal sel, ck    : std_logic;

    -- The component we are testing is the program counter,
    -- so we declare that component here.
    component pc is
        port(input:  in std_logic_vector(31 downto 0);
             sel:    in std_logic;
             clk:    in std_logic;
             output: out std_logic_vector(31 downto 0));
    end component pc;

begin

    -- 'uut' stands for unit under test
    -- And the unit we are testing is the
    -- regsiter file.
    uut : pc

    -- As we did for the full-adder project,
    -- we must map each input and output of the register file
    -- to the signals we declared eariler. 
    port map (
        input             => x,
        sel               => sel,
        clk               => ck,
        output            => y
    );

    -- We have to generate a clock to use for setting our program counter!
    -- This clock is simple and flips every nanosecond.
    gen_clk : process
    begin
        ck <= '0';
        wait for 1 ns;
        ck <= '1';
        wait for 1 ns;
    end process;

    process is
    begin
        x <= x"8000A000";
        sel <= '1';
        wait for 1 ns;
        x <= x"A0008000";
        sel <= '1';
        wait for 1 ns;
        x <= x"ABADCAFE";
        sel <= '1';
        wait for 1 ns;
        x <= x"BABEBABE";
        sel <= '0';
        wait for 1 ns;
        x <= x"00000400";
        sel <= '0';
        wait for 1 ns;
        x <= x"FFFFFFFF";
        sel <= '0';
        wait for 1 ns;
        x <= x"000000F0";
        sel <= '1';
        wait for 1 ns;
    end process;
end behavioral;



