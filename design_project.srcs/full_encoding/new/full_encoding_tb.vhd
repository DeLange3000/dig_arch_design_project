library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity full_encoding_tb is
end entity;

architecture ben of full_encoding_tb is
    component full_encoding is port(
    clk :in std_logic;
    input_array : in std_logic_vector(127 downto 0);
    output_array : out std_logic_vector(127 downto 0);
    --temp_array : out std_logic_vector(127 downto 0);
    reset : in std_logic;
    start_encode : in std_logic
    --debug : out std_logic_vector(3 downto 0)
    );
       --inputs and outputs: "D : in std_logic_vector(3 downto 0);"
    end component;

 signal clk, reset, start_encode : std_logic;
 signal input_array, output_array : std_logic_vector(127 downto 0);
 --signal temp_array : std_logic_vector(127 downto 0);
 --signal debug : std_logic_vector(3 downto 0);

begin
    uut5 : full_encoding port map(clk => clk, input_array => input_array, output_array => output_array, reset => reset, start_encode => start_encode); --, temp_array => temp_array, debug => debug);
    stim : process
    begin
    reset <='1';
    start_encode <= '0';
    input_array <= x"6BC1BEE22E409F96E93D7E117393172A";
    clk <= '0';
    
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
    reset <= '0';
    clk <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
    
    start_encode <= '1';
    
    for i in 0 to 100 loop
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end loop;

end process;
end ben;