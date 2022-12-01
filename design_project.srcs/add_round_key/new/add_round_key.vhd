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

entity add_round_key is port(
clk : in std_logic;
input_array : in std_logic_vector(127 downto 0); --x"3243f6a8885a308d313198a2e0370734";
key: in std_logic_vector(127 downto 0);-- x"2b7e151628aed2a6abf7158809cf4f3c";
output_array : out std_logic_vector(127 downto 0)
 );
end add_round_key;

architecture Behavioral of add_round_key is
begin
   a :process(clk)
   begin
   output_array <= input_array xor key;
   
   end process;


end Behavioral;
