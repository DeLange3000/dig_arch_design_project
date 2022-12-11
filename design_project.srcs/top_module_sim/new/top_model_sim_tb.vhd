library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity top_model_sim_tb is
end entity;

architecture ben of top_model_sim_tb is
    component top_model_sim is port(
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
    dp : out STD_LOGIC;
    
    --debug
    input_array : in std_logic_vector(127 downto 0);
    output_array : out std_logic_vector(127 downto 0)
    );
       --inputs and outputs: "D : in std_logic_vector(3 downto 0);"
    end component;

 signal clk, btnR, btnL, btnC, btnU, btnD, dp: std_logic;
 signal input_array, output_array : std_logic_vector(127 downto 0);
 signal sw, led : std_logic_vector(15 downto 0);
 signal seg : std_logic_vector(0 to 6);
 signal an : std_logic_vector(3 downto 0);
 --signal temp_array : std_logic_vector(127 downto 0);
 --signal debug : std_logic;

begin
    --btnL => reset
    --btnC => start_encode
    
    uut6 : top_model_sim port map(clk => clk, btnR => btnR, btnL => btnL, btnC => btnC, btnU => btnU, btnD => btnD, led => led, an => an, seg => seg, sw => sw, dp => dp, input_array => input_array, output_array => output_array);
    stim : process
    begin
    btnL <='1';
    btnC <= '0';
    input_array <= x"6BC1BEE22E409F96E93D7E117393172A";
    clk <= '0';
    
    wait for 1 ns;
    clk <= '1';
    wait for 1 ns;
    btnL <= '0';
    clk <= '0';
    wait for 1 ns;
    clk <= '1';
    wait for 1 ns;
    
    btnC <= '1';
    
        clk <= '0';
    wait for 1 ns;
    clk <= '1';
    wait for 1 ns;
    
    btnC <= '0';
    
    for i in 0 to 100 loop
        clk <= '0';
        wait for 1 ns;
        clk <= '1';
        wait for 1 ns;
    end loop;

end process;
end ben;