library ieee;
use ieee.std_logic_1164.all;

entity memory_tb is
end memory_tb;

architecture behavioral of memory_tb is 
    signal clk, MemRead, MemWrite     : std_logic;
    signal address, data, instruction : std_logic_vector(31 downto 0);
    
    component memory is
        port(address: in std_logic_vector(31 downto 0);
             data: in std_logic_vector(31 downto 0);
             clk: in std_logic;
             MemRead, MemWrite: in std_logic;
             instruction: out std_logic_vector(31 downto 0));
    end component memory;

begin

    uut : memory

    port map (
        address     => address,
        data        => data,
        clk         => clk,
        MemRead     => MemRead,
        MemWrite    => MemWrite,
        instruction => instruction
    );

    gen_clk : process
    begin
        clk <= '0';
        wait for 1 ns;
        clk <= '1';
        wait for 1 ns;
    end process;

    process is
    begin
        wait for 1 ns;
        address  <= x"00000000";
        data     <= x"00000000";
        MemRead  <= '1';
        MemWrite <= '0';
        wait for 2 ns;
        address  <= x"00000001";
        data     <= x"00000000";
        MemRead  <= '1';
        MemWrite <= '0';
        wait for 2 ns;
        address  <= x"00000002";
        data     <= x"00000000";
        MemRead  <= '1'; 
        MemWrite <= '0';
        wait for 2 ns;
        address  <= x"00000003";
        data     <= x"00000000";
        MemRead  <= '1';
        MemWrite <= '0';
        wait for 2 ns;
        address  <= x"00000004";
        data     <= x"00000000";
        MemRead  <= '1';
        MemWrite <= '0';
        wait for 2 ns;
        address  <= x"00000005";
        data     <= x"00000000";
        MemRead  <= '1';
        MemWrite <= '0';
        wait for 2 ns;
        address  <= x"00000006";
        data     <= x"00000000";
        MemRead  <= '1';
        MemWrite <= '0';
        wait for 2 ns;
        address  <= x"00000007";
        data     <= x"00000000";
        MemRead  <= '1';
        MemWrite <= '0';
        wait for 1 ns; -- Final wait
    end process;
end behavioral;



