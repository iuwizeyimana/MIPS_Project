library ieee;
use ieee.std_logic_1164.all;

entity mux4_tb is
end mux4_tb;

architecture behavioral of mux4_tb is 
    signal s       : std_logic_vector(1 downto 0);
    signal w,x,y,z : std_logic_vector(31 downto 0);

    -- The component we are testing is the 4-input multiplexer,
    -- so we declare that component here.
    component mux4 is
        port(selector: in std_logic_vector(1 downto 0);
             input1, input2, input3: in std_logic_vector(31 downto 0);
             output: out std_logic_vector(31 downto 0));
    end component mux4;

begin

    -- 'uut' stands for unit under test
    -- And the unit we are testing is the
    -- 4-input multiplexer.
    uut : mux4

    -- As we did for the full-adder project,
    -- we must map each input and output of the 4-input multiplexer
    -- to the signals we declared eariler. 
    port map (
        selector => s,
        input1 => w,
        input2 => x,
        input3 => y,
        output => z
    );

    -- The test for the 4-input multiplexer is very simple,
    -- all we do is feed the process three inputs, set the selector bits
    -- to either 00, 01, or 10, and ensure it outputs the correct result
    -- based on the selector bits.

    -- w = The data from register $t0 (0xFACEB00C)
    -- x = 0xFFFF8000
    -- y = 0x3FFFE000 
    process is
    begin
        w <= x"FACEB00C";
        x <= x"FFFF8000";
        y <= x"3FFFE000";
        s <= "00";
        wait for 1 ns;
        w <= x"FACEB00C";
        x <= x"FFFF8000";
        y <= x"3FFFE000";
        s <= "01";
        wait for 1 ns;
        w <= x"FACEB00C";
        x <= x"FFFF8000";
        y <= x"3FFFE000";
        s <= "10";
        wait for 1 ns;
        w <= x"FACEB00C";
        x <= x"FFFF8000";
        y <= x"3FFFE000";
        s <= "11";
        wait for 1 ns;
    end process;
end behavioral;



