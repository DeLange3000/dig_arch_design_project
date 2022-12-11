library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity top_module_tb is
end entity;

architecture ben of top_module_tb is
    component top_module is port(
    clk: in STD_LOGIC; 
    btnR : in STD_LOGIC;
    btnL : in std_logic;
    btnC : in std_logic;
    btnU : in std_logic;
    btnD : in std_logic;
    led : out STD_LOGIC_vector(15 downto 0);
    an : out STD_LOGIC_vector(3 downto 0);
    seg : out STD_LOGIC_vector(0 to 6);
    sw : in STD_LOGIC_vector(15 downto 0);
    dp : out STD_LOGIC
    );
       --inputs and outputs: "D : in std_logic_vector(3 downto 0);"
    end component;

 signal clk2: std_logic;
 signal input_array, output_array : std_logic_vector(127 downto 0);
 --signal temp_array : std_logic_vector(127 downto 0);
 --signal debug : std_logic;

begin
    uut5 : top_module port map(clk => clk, input_array => input_array, output_array => output_array, reset => reset, start_encode => start_encode); --, debug => debug); --, temp_array => temp_array, debug => debug);
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
    
    for i in 0 to 100 loop
        clk <= '0';
        wait for 1 ns;
        clk <= '1';
        wait for 1 ns;
    end loop;

end process;
end ben;