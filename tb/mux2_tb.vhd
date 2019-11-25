library ieee;
use ieee.std_logic_1164.all;

entity mux2_tb is
end mux2_tb;

architecture behavioral of mux2_tb is 
    signal s,ck  : std_logic;
    signal x,y,z : std_logic_vector(31 downto 0);

    -- The component we are testing is the 2-input multiplexer,
    -- so we declare that component here.
    component mux2 is
        port(selector: in std_logic;
             input1, input2: in std_logic_vector(31 downto 0);
             clk: in std_logic;
             output: out std_logic_vector(31 downto 0));
    end component mux2;

begin

    -- 'uut' stands for unit under test
    -- And the unit we are testing is the
    -- 2-input multiplexer.
    uut : mux2

    -- As we did for the full-adder project,
    -- we must map each input and output of the 2-input multiplexer
    -- to the signals we declared eariler. 
    port map (
        selector => s,
        input1 => x,
        input2 => y,
        clk    => ck,
        output => z
    );

    gen_clk : process
    begin
        ck <= '0';
        wait for 1 ns;
        ck <= '1';
        wait for 1 ns;
    end process;

    -- The test for the 2-input multiplexer is very simple,
    -- all we do is feed the process two inputs, set the selector bit
    -- to either 0 or 1, and ensure it outputs the correct result
    -- based on the selector bit.
    process is
    begin
        wait for 1 ns;
        x <= "11110101010101010101000000011010";
        y <= "00001100010000110000011000011011";
        s <= '0';
        wait for 2 ns;
        x <= x"FEEDC0DE";
        y <= x"00004B1D";
        s <= '1';
        wait for 2 ns;
        x <= x"DEADBABE";
        y <= x"B0000000";
        s <= '1';
    end process;
end behavioral;



