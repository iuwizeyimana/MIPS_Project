library ieee;
use ieee.std_logic_1164.all;
-- The numeric_std library is used to sign-extend the input
use ieee.numeric_std.all;

-- The entity is very straight-forward!
-- input: The 16-bit input
-- output: The 32-bit output
entity sign_ext is
    port(input: in std_logic_vector(15 downto 0);
         output: out std_logic_vector(31 downto 0));
end sign_ext;

-- To sign-extend in VHDL, use the resize(input, length) function
-- We convert the input to be signed, and the 'length attribute
-- resizes the input to be length equal to the specified vector
architecture behavioral of sign_ext is
begin
    output <= std_logic_vector(resize(signed(input), output'length));
end architecture;
