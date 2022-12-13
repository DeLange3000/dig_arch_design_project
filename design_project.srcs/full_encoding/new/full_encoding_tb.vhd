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
    temp_array : out std_logic_vector(127 downto 0);
    reset : in std_logic;
    start_encode : in std_logic;
    finished : out std_logic
    --debug : out std_logic
    );
       --inputs and outputs: "D : in std_logic_vector(3 downto 0);"
    end component;

 signal clk, reset, start_encode, finished : std_logic;
 signal input_array, output_array : std_logic_vector(127 downto 0);
 signal temp_array : std_logic_vector(127 downto 0);
 --signal debug : std_logic;

begin
    uut5 : full_encoding port map(clk => clk, input_array => input_array, output_array => output_array, reset => reset, start_encode => start_encode, finished => finished, temp_array => temp_array);--, debug => debug); --, , debug => debug);
    stim : process
    begin
    reset <='1';
    start_encode <= '0';
    input_array <= x"6BC1BEE22E409F96E93D7E117393172A";
    clk <= '0';
    
    wait for 1 ns;
    clk <= '1';
    wait for 1 ns;
    reset <= '0';
    clk <= '0';
    wait for 1 ns;
    clk <= '1';
    wait for 1 ns;
    
    start_encode <= '1';
    
        clk <= '0';
    wait for 1 ns;
    clk <= '1';
    wait for 1 ns;
    
    clk <= '0';
    wait for 1 ns;
    clk <= '1';
    wait for 1 ns;
    
        start_encode <= '0';
        
    clk <= '0';
    wait for 1 ns;
    clk <= '1';
    wait for 1 ns;
    
    clk <= '0';
    wait for 1 ns;
    clk <= '1';
    wait for 1 ns;
    
    start_encode <= '1';
    
    clk <= '0';
    wait for 1 ns;
    clk <= '1';
    wait for 1 ns;
    
    clk <= '0';
    wait for 1 ns;
    clk <= '1';
    wait for 1 ns;
        
    start_encode <= '0';
    
    for i in 0 to 100 loop
        clk <= '0';
        wait for 1 ns;
        clk <= '1';
        wait for 1 ns;
    end loop;

end process;
end ben;