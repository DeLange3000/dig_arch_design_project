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
use ieee.math_real.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity full_encoding is port(
    clk : in std_logic;
    input_array : in std_logic_vector(127 downto 0);
    output_array : out std_logic_vector(127 downto 0);
    --temp_array : out std_logic_vector(127 downto 0);
    reset : in std_logic;
    start_encode : in std_logic;
    finished : out std_logic;
    debug : out std_logic 
    );
end full_encoding;

architecture Behavioral of full_encoding is

    component add_round_key is port(
        input_array : in std_logic_vector(127 downto 0); 
        key: in std_logic_vector(127 downto 0);
        output_array : out std_logic_vector(127 downto 0)
        );
    end component;
    
    component sub_bytes is port(
        input_array : in std_logic_vector(127 downto 0); --x"3243f6a8885a308d313198a2e0370734";
        output_array : out std_logic_vector(127 downto 0)
         );
    end component;
    
    component shift_rows is port(
        input_array : in std_logic_vector(127 downto 0); --x"3243f6a8885a308d313198a2e0370734";
        output_array : out std_logic_vector(127 downto 0)
         );
    end component;
    
    component mix_columns is port(
        input_array : in std_logic_vector(127 downto 0); --x"3243f6a8885a308d313198a2e0370734";
        output_array : out std_logic_vector(127 downto 0)
    );
    end component;

--signal input_array : std_logic_vector(127 downto 0) := x"6BC1BEE22E409F96E93D7E117393172A";
--signal output_array : std_logic_vector(127 downto 0);
signal input_key : std_logic_vector(127 downto 0); --first key
signal first_key : std_logic_vector(127 downto 0) := x"2b7e151628aed2a6abf7158809cf4f3c";
signal last_key : std_logic_vector(127 downto 0) := x"d014f9a8c9ee2589e13f0cc8b6630ca6";

signal output_add_round_key : std_logic_vector(127 downto 0);
signal output_sub_bytes : std_logic_vector(127 downto 0);
signal output_mix_columns : std_logic_vector(127 downto 0);
signal output_shift_rows : std_logic_vector(127 downto 0);

signal input_all : std_logic_vector(127 downto 0);
signal loop_counter :std_logic_vector(3 downto 0);
signal encode_pressed : std_logic;
signal encode_button_pressed: std_logic;

type statetype is (idle, addkey, mixcolumns,  subbytes, shiftrows, error);
signal currentState, nextState : statetype;

begin

ark1: add_round_key port map(input_array => input_all, key => input_key, output_array => output_add_round_key);
sub1 : sub_bytes port map(input_array => input_all, output_array => output_sub_bytes);
shift1 : shift_rows port map(input_array => input_all, output_array => output_shift_rows);
mix1 : mix_columns port map(input_array => input_all, output_array => output_mix_columns);

process(start_encode, currentState)
begin
    if(start_encode = '1') then
    encode_pressed <= '1';
    end if;
    if (loop_counter = 10) then 
        encode_pressed <= '0';
    end if;
    
    debug <= encode_pressed;

--    if (loop_counter <= 9 and loop_counter > 0) then 
--        encode_pressed <= '1';
--        encode_button_pressed <= '0';
--        else
--            if (start_encode = '1') then 
--                encode_button_pressed <= '1';
--                encode_pressed <= '0';
--            elsif (start_encode = '0') then 
--                if(encode_button_pressed = '1') then
--                    encode_pressed <= '1';
--                else encode_pressed <= '0';
--                end if;
--                --encode_button_pressed <= '0';
--            else
--                encode_button_pressed <= '0';
--                encode_pressed <= '0';
--            end if;
   
--    end if;
    --debug <= encode_pressed;
end process;

process(currentState, encode_pressed)
begin
        case currentState is
        when idle =>
            if(encode_pressed = '1') then
                --output_array <= x"00000000000000000000000000000000"; -- is zero before output
                finished <= '0';
                nextState <= addkey;
                input_all <= input_array;
                input_key <= first_key;   
            end if;
            if(start_encode = '0') then 
            nextState <= idle;              
            end if;
            loop_counter <= "0000"; --reset loop counter when state is idle
            
            --debug
            --temp_array <= input_all;
            
        when addkey =>
            if(loop_counter < "1010") then nextState <= subbytes;
            loop_counter <= loop_counter + '1';
            input_all <= output_add_round_key;
            else nextState <= idle;
            output_array <= output_add_round_key;
            finished <= '1';
            end if;
                    
            --debug
            --temp_array <= input_all;
            
        when subbytes => nextState <= shiftrows;
            input_all <= output_sub_bytes;
                    
            --debug
            --temp_array <= input_all;
            
        when shiftrows =>
            if(loop_counter < "1010") then nextState <= mixcolumns;
            else nextState <= addkey;
            input_key <=  last_key;
            end if;
            input_all <= output_shift_rows;
                    
            --debug
            --temp_array <= input_all;
            
        when mixcolumns => nextState <= addkey;
            case loop_counter is
                when "0001" => input_key <= x"a0fafe1788542cb123a339392a6c7605";
                when "0010" => input_key <= x"f2c295f27a96b9435935807a7359f67f";
                when "0011" => input_key <= x"3d80477d4716fe3e1e237e446d7a883b";
                when "0100" => input_key <= x"ef44a541a8525b7fb671253bdb0bad00";
                when "0101" => input_key <= x"d4d1c6f87c839d87caf2b8bc11f915bc";
                when "0110" => input_key <= x"6d88a37a110b3efddbf98641ca0093fd";
                when "0111" => input_key <= x"4e54f70e5f5fc9f384a64fb24ea6dc4f";
                when "1000" => input_key <= x"ead27321b58dbad2312bf5607f8d292f";
                when "1001" => input_key <= x"ac7766f319fadc2128d12941575c006e";
                when others => nextState <= error;
            end case;
            input_all <= output_mix_columns;
            
            --debug
            --temp_array <= input_all;
            
         when error => nextState <= error;
        end case;

end process;


process(clk)
begin
 
    if(clk'event) and (clk='1') then
           if(reset = '1') then
            currentState <= idle;
        end if;
        currentState <= nextState;   
        --debug
        --debug <= loop_counter;
    end if;
    
    --if(currentState = error) then TURN ON A LED?

end process;
    

--GET STATES
--ADD KEYS
--GET LOOP WORKING

    
end Behavioral;
