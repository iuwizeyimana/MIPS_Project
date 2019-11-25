library ieee;
use ieee.std_logic_1164.all;

entity mux3_tb is
end mux3_tb;

architecture behavioral of mux3_tb is 
    signal s       : std_logic_vector(1 downto 0);
    signal w,x,y,z : std_logic_vector(31 downto 0);

    -- The component we are testing is the 3-input multiplexer,
    -- so we declare that component here.
    component mux3 is
        port(selector: in std_logic_vector(1 downto 0);
             input1, input2, input3: in std_logic_vector(31 downto 0);
             output: out std_logic_vector(31 downto 0));
    end component mux3;

begin

    -- 'uut' stands for unit under test
    -- And the unit we are testing is the
    -- 3-input multiplexer.
    uut : mux3

    -- As we did for the full-adder project,
    -- we must map each input and output of the 3-input multiplexer
    -- to the signals we declared eariler. 
    port map (
        selector => s,
        input1 => w,
        input2 => x,
        input3 => y,
        output => z
    );

    -- The test for the 3-input multiplexer is very simple,
    -- all we do is feed the process three inputs, set the selector bits
    -- to either 00, 01, or 10, and ensure it outputs the correct result
    -- based on the selector bits.

    -- For these tests, assume the current PC is 0x4000
    -- w = PC + 4
    -- x = ALUout PC from beq (0x4040)
    -- y = Jump address (0xDEAD4000)
    process is
    begin
        w <= x"00004000";
        x <= x"00004040";
        y <= x"DEAD4000";
        s <= "00";
        wait for 1 ns;
        w <= x"00004000";
        x <= x"00004040";
        y <= x"DEAD4000";
        s <= "01";
        wait for 1 ns;
        w <= x"00004000";
        x <= x"00004040";
        y <= x"DEAD4000";
        s <= "10";
        wait for 1 ns;
    end process;
end behavioral;



