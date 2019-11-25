library ieee;
use ieee.std_logic_1164.all;

entity mux2_tb is
end mux2_tb;

architecture behavioral of mux2_tb is 
    signal s     : std_logic;
    signal x,y,z : std_logic_vector(4 downto 0);

    -- The component we are testing is the 2-input multiplexer,
    -- so we declare that component here.
    component mux2 is
        port(selector: in std_logic;
             input1, input2: in std_logic_vector(4 downto 0);
             output: out std_logic_vector(4 downto 0));
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
        output => z
    );

    -- The test for the 2-input multiplexer is very simple,
    -- all we do is feed the process two inputs, set the selector bit
    -- to either 0 or 1, and ensure it outputs the correct result
    -- based on the selector bit.
    process is
    begin
        x <= "11010";
        y <= "11011";
        s <= '0';
        wait for 1 ns;
        x <= "11110";
        y <= "11111";
        s <= '1';
        wait for 1 ns;
    end process;
end behavioral;



