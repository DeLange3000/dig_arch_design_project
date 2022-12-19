library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity add_round_key_tb is
end entity;

architecture ben of add_round_key_tb is
component add_round_key is port(
input_array : in std_logic_vector(127 downto 0); --x"3243f6a8885a308d313198a2e0370734";
key: in std_logic_vector(127 downto 0);-- x"2b7e151628aed2a6abf7158809cf4f3c";
output_array : out std_logic_vector(127 downto 0)
);
   --inputs and outputs: "D : in std_logic_vector(3 downto 0);"
end component;

 signal clk : std_logic;
 signal input_array, key, output_array: std_logic_vector(127 downto 0);
-- These are the internal wires
-- define signals: "signal D: std_logic_vector(3 downto 0);"

begin
    uut : add_round_key port map(input_array => input_array, output_array => output_array, key => key);
    stim : process
    begin
    input_array <= x"6bc1bee22e409f96e93d7e117393172a";
    key <= x"2b7e151628aed2a6abf7158809cf4f3c";
    clk <= '0';
    wait for 10 ns;
    
    

    

    clk <= '1';
    wait for 10 ns;

    end process;
end ben;