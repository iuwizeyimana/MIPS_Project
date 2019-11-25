library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2 is
    port(selector: in std_logic;
         input1, input2: in std_logic_vector(4 downto 0); 
         output: out std_logic_vector(4 downto 0));
end mux2;

architecture behavioral of mux2 is
begin
    process(selector)
    begin
        case selector is
            when '0' =>
                output <= input1;
            when '1' =>
                output <= input2;
            when others =>
        end case;
    end process;
end behavioral;
