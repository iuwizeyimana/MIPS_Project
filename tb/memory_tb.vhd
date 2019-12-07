library ieee;
use ieee.std_logic_1164.all;

entity memory_tb is
end memory_tb;

architecture behavioral of memory_tb is 
    signal clk, MemRead, MemWrite                  : std_logic;
    signal in_data, out_data, address, instruction : std_logic_vector(31 downto 0);
    
    component memory is
        port(address: in std_logic_vector(31 downto 0);
             in_data: in std_logic_vector(31 downto 0);
             clk: in std_logic;
             MemRead, MemWrite: in std_logic;
             instruction: out std_logic_vector(31 downto 0);
             out_data: out std_logic_vector(31 downto 0));
    end component memory;

begin

    uut : memory

    port map (
        address     => address,
        in_data     => in_data,
        clk         => clk,
        MemRead     => MemRead,
        MemWrite    => MemWrite,
        instruction => instruction,
        out_data    => out_data
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
        in_data     <= x"00000000";
        MemRead  <= '1';
        MemWrite <= '0';
        wait for 2 ns;
        address  <= x"00000001";
        in_data     <= x"00000000";
        MemRead  <= '1';
        MemWrite <= '0';
        wait for 2 ns;
        address  <= x"00000002";
        in_data     <= x"00000000";
        MemRead  <= '1'; 
        MemWrite <= '0';
        wait for 2 ns;
        address  <= x"00000003";
        in_data     <= x"00000000";
        MemRead  <= '1';
        MemWrite <= '0';
        wait for 2 ns;
        address  <= x"00000004";
        in_data     <= x"00000000";
        MemRead  <= '1';
        MemWrite <= '0';
        wait for 2 ns;
        address  <= x"00000005";
        in_data     <= x"00000000";
        MemRead  <= '1';
        MemWrite <= '0';
        wait for 2 ns;
        address  <= x"00000006";
        in_data     <= x"00000000";
        MemRead  <= '1';
        MemWrite <= '0';
        wait for 2 ns;
        address  <= x"00000007";
        in_data     <= x"00000000";
        MemRead  <= '1';
        MemWrite <= '0';
        wait for 1 ns; -- Final wait
    end process;
end behavioral;



