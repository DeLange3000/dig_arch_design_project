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

entity shift_rows is port(
input_array : in std_logic_vector(127 downto 0); --x"3243f6a8885a308d313198a2e0370734";
output_array : out std_logic_vector(127 downto 0)
 );
end shift_rows;

architecture Behavioral of shift_rows is
begin

output_array(31 downto 0) <= input_array(31 downto 24) & input_array(119 downto 112) & input_array(79 downto 72) & input_array(39 downto 32);
output_array(63 downto 32) <= input_array(63 downto 56) & input_array(23 downto 16) & input_array(111 downto 104) & input_array(71 downto 64);
output_array(95 downto 64) <= input_array(95 downto 88) & input_array(55 downto 48) & input_array(15 downto 8) & input_array(103 downto 96);
output_array(127 downto 96) <= input_array(127 downto 120) & input_array(87 downto 80) & input_array(47 downto 40) & input_array(7 downto 0);



end Behavioral;
