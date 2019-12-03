library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
    port(address: in std_logic_vector(31 downto 0);
         data: in std_logic_vector(31 downto 0);
         clk: in std_logic;
         MemRead, MemWrite: in std_logic;
         instruction: out std_logic_vector(31 downto 0));
end memory;

architecture behavioral of memory is
    type mem_arr is array(0 to 7) of std_logic_vector(31 downto 0);
    signal mem : mem_arr := (
                                    x"8d490000",
                                    x"8d6a0001",
                                    x"012a8820",
                                    x"022a4822",
                                    x"014b4824",
                                    x"014b4825",
                                    x"200b0008",
                                    x"08000000"
                            );
begin
    writeToMem: process(clk) is
    begin
        if rising_edge(clk) then
            if MemWrite = '1' then
                mem(to_integer(unsigned(address))) <= data;
            end if;
        end if;

        if rising_edge(clk) then
            if MemRead = '1' then
                instruction <= mem(to_integer(unsigned(address))); 
            end if;
        end if;
    end process;
end behavioral;
