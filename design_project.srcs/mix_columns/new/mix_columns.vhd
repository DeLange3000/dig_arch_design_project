----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.11.2022 15:12:14
-- Design Name: 
-- Module Name: Dflipflop - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mix_columns is port(
input_array : in std_logic_vector(127 downto 0); --x"3243f6a8885a308d313198a2e0370734";
output_array : out std_logic_vector(127 downto 0)
 );
end mix_columns;

architecture Behavioral of mix_columns is


    component LUT_mul2 is port(
               byte_in : in STD_LOGIC_VECTOR (7 downto 0);
               byte_out : out STD_LOGIC_VECTOR (7 downto 0)
               );
    end component;
    
    component LUT_mul3 is
        Port ( byte_in : in STD_LOGIC_VECTOR (7 downto 0);
        byte_out : out STD_LOGIC_VECTOR (7 downto 0));
end component; 

signal a1, a2, a3, a4, b1, b2, b3, b4: std_logic_vector(31 downto 0);

begin

--calculates the first riw, then the second row with the second generate, ...
mix1: for i in 1 to 4 generate
lut1: LUT_mul2 port map(byte_in => input_array(i*32 - 1 downto i*32 - 8), byte_out => a1(i*8-1 downto (i-1)*8));
lut2: LUT_mul3 port map(byte_in => input_array(i*32 - 9 downto i*32 - 16), byte_out => b1(i*8-1 downto (i-1)*8));
output_array(i*32-1 downto i*32-8) <= a1(i*8-1 downto (i-1)*8) xor b1(i*8-1 downto (i-1)*8) xor input_array(32*i -  17 downto 32*i - 24) xor input_array(32*i - 25 downto 32*i-32);
end generate;

mix2: for i in 1 to 4 generate
lut2: LUT_mul2 port map(byte_in => input_array(i*32 - 9 downto i*32 - 16), byte_out => a2(i*8-1 downto (i-1)*8));
lut3: LUT_mul3 port map(byte_in => input_array(i*32 - 17 downto i*32 - 24), byte_out => b2(i*8-1 downto (i-1)*8));

output_array(i*32-9 downto i*32-16) <= input_array(32*i -  1 downto 32*i - 8) xor a2(i*8-1 downto (i-1)*8) xor b2(i*8-1 downto (i-1)*8) xor input_array(32*i - 25 downto 32*(i-1));

end generate;

mix3: for i in 1 to 4 generate
lut2: LUT_mul2 port map(byte_in => input_array(i*32 -17 downto i*32 - 24), byte_out => a3(i*8-1 downto (i-1)*8));
lut3: LUT_mul3 port map(byte_in => input_array(i*32 - 25 downto (i-1)*32), byte_out => b3(i*8-1 downto (i-1)*8));

output_array(i*32 - 17 downto i*32 - 24) <= input_array(32*i -  1 downto 32*i - 8) xor input_array(32*i - 9 downto 32*i-16) xor a3(i*8-1 downto (i-1)*8) xor b3(i*8-1 downto (i-1)*8);

end generate;

mix4: for i in 1 to 4 generate
lut2: LUT_mul2 port map(byte_in => input_array(i*32 - 25 downto (i-1)*32), byte_out => a4(i*8-1 downto (i-1)*8));
lut3: LUT_mul3 port map(byte_in => input_array(i*32 - 1 downto i*32 - 8), byte_out => b4(i*8-1 downto (i-1)*8));

output_array(i*32 - 25 downto (i-1)*32) <= b4(i*8-1 downto (i-1)*8) xor input_array(32*i -  9 downto 32*i - 16) xor input_array(32*i - 17 downto 32*i - 24) xor a4(i*8-1 downto (i-1)*8);

end generate;

end Behavioral;
