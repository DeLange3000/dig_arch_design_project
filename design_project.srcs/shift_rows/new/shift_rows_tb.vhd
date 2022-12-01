library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity shift_rows_tb is
end entity;

architecture ben of shift_rows_tb is
component shift_rows is port(
clk : in std_logic;
input_array : in std_logic_vector(127 downto 0); --x"3243f6a8885a308d313198a2e0370734";
output_array : out std_logic_vector(127 downto 0)
);
   --inputs and outputs: "D : in std_logic_vector(3 downto 0);"
end component;

 signal clk : std_logic;
 signal input_array, output_array: std_logic_vector(127 downto 0);
-- These are the internal wires
-- define signals: "signal D: std_logic_vector(3 downto 0);"

begin
    uut3 : shift_rows port map(clk => clk, input_array => input_array, output_array => output_array);
    stim : process
    begin
    clk <= '0';
    wait for 10 ns;
    input_array <= x"090862BF6F28E3042C747FEEDA4A6A47";
    

    clk <= '1';
    wait for 10 ns;

    end process;
end ben;