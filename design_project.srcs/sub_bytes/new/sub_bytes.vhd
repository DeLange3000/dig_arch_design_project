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

entity sub_bytes is port(
clk : in std_logic;
input_array : in std_logic_vector(127 downto 0); --x"3243f6a8885a308d313198a2e0370734";
output_array : out std_logic_vector(127 downto 0)
 );
end sub_bytes;

architecture Behavioral of sub_bytes is
    component S_box is port(
           byte_in : in STD_LOGIC_VECTOR (7 downto 0);
           byte_out : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
begin

   
    sub_bytes_gen: for i in 0 to 15 generate
     uut2: S_box port map (byte_in => input_array(i*8 + 7 downto i*8)  , byte_out => output_array(i*8 + 7 downto i*8));   
    end generate;


end Behavioral;
