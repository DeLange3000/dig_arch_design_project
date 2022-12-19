library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity top_model_sim is
    Port ( 
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
end top_model_sim;

architecture Behavioral of top_model_sim is

component full_encoding is port(
    clk : in std_logic;
    input_array : in std_logic_vector(127 downto 0);
    output_array : out std_logic_vector(127 downto 0);
    --temp_array : out std_logic_vector(127 downto 0);
    start_encode : in std_logic;
    reset : in std_logic;
    finished : out std_logic
    );
    
end component;
 
--signal input_array, output_array : std_logic_vector(127 downto 0);
signal finished : std_logic;
signal reset : std_logic;
signal output_array_temp : std_logic_vector(127 downto 0); -- used for debugging

---TESTING
signal switch : std_logic_vector(1 downto 0) := "00";
signal inputs : std_logic_vector(3 downto 0) := "0000";
signal counter : std_logic_vector(10 downto 0) := "00000000000";
signal output_counter : std_logic_vector(16 downto 0):= "00000000000000000";
signal switch_output : std_logic_vector(3 downto 0) := "0000";
signal output_selector : std_logic_vector (3 downto 0) := "0000";

--debugging button behaviour
--signal button_counter : std_logic_vector(3 downto 0) := "0000";
--signal button_press : std_logic := '0';

begin

--CHOOSE INPUT ARRAY:
--input_array <= x"6BC1BEE22E409F96E93D7E117393172A";
--input_array <= x"AE2D8A571E03AC9C9EB76FAC45AF8E51";
--input_array <= x"30C81C46A35CE411E5FBC1191A0A52EF";
--input_array <= x"F69F2445DF4F9B17AD2B417BE66C3710";

encoding : full_encoding port map(clk => clk, input_array => input_array, output_array => output_array_temp, start_encode => btnC, finished => finished, reset => reset); --start_encode => btnC, reset => btnR
reset <= btnR;
output_array <= output_array_temp;

--debugging button behaviour
--process(clk)
--begin

--if (clk'event and clk = '1') then

--    if(button_counter = "0011") then 
--    button_press <= '1';
--    button_counter <= button_counter + 1;
--    elsif (button_counter = "1111") then 
--    button_press <= '0';
--    else button_counter <= button_counter + 1;
--    end if;

--    end if;
--end process;
----------------------------------------------


process(clk)
begin
--this controls leds:

--is output array is same as wanted one, led(0) is on
if(output_array_temp = x"3AD77BB40D7A3660A89ECAF32466EF97") then
    led(0) <= '1';
    else led(0) <= '0';
 end if;
 
 --if the encryption is finished, led(1) is on
 if(finished = '1') then led(1) <= '1';
 else led(1) <= '0';
 end if;
 
 -- if a button is pressed, led(2) is on
 if(btnL = '1' or btnC = '1' or btnR = '1' or btnU = '1' or btnD = '1') then led(2) <= '1';
 else led(2) <= '0';
 end if;
 
 --shows which part of the output is shown
 case output_selector is
       when "0001" => led(15 downto 7) <= "100000000";
       when "0010" => led(15 downto 7) <= "010000000";
       when "0011" => led(15 downto 7) <= "001000000";
       when "0100" => led(15 downto 7) <= "000100000";
       when "0101" => led(15 downto 7) <= "000010000";
       when "0110" => led(15 downto 7) <= "000001000";
       when "0111" => led(15 downto 7) <= "000000100";
       when "1000" => led(15 downto 7) <= "000000010";
       when "1001" => led(15 downto 7) <= "000000001";
       when others => led(15 downto 7) <= "000000000";
end case;
 
 

    
--end process;

   
    if (clk'event and clk = '1') then
    
     -- counter for controlling the anodes of the 7-seg display
        if(counter = "11111111111") then
        counter <= "00000000000";
        
    --shows output in sequential order
    if(output_selector = "0000") then an <= "1111";
            else
            case switch is
                when "00" => switch <= "01";
                    an <= "0111";
                    case output_selector is
                    when "0001" => inputs <= x"a";
                    when "0010" => inputs <= output_array_temp(127 downto 124);
                    when "0011" => inputs <= output_array_temp(111 downto 108);
                    when "0100" => inputs <= output_array_temp(95 downto 92);
                    when "0101" => inputs <= output_array_temp(79 downto 76);
                    when "0110" => inputs <= output_array_temp(63 downto 60);
                    when "0111" => inputs <= output_array_temp(47 downto 44);
                    when "1000" => inputs <= output_array_temp(31 downto 28);
                    when "1001" => inputs <= output_array_temp(15 downto 12);
                    when others => inputs <= x"0";
                    end case;
                when "01" => switch <= "10";
                an <= "1011";
                case output_selector is
                    when "0001" => inputs <= x"e";
                    when "0010" => inputs <= output_array_temp(123 downto 120);
                    when "0011" => inputs <= output_array_temp(107 downto 104);
                    when "0100" => inputs <= output_array_temp(91 downto 88);
                    when "0101" => inputs <= output_array_temp(75 downto 72);
                    when "0110" => inputs <= output_array_temp(59 downto 56);
                    when "0111" => inputs <= output_array_temp(43 downto 40);
                    when "1000" => inputs <= output_array_temp(27 downto 24);
                    when "1001" => inputs <= output_array_temp(11 downto 8);
                    when others => inputs <= x"0";
                    end case;
                when "10" => switch <= "11";
                an <= "1101";
                case output_selector is
                    when "0001" => inputs <= x"5";
                    when "0010" => inputs <= output_array_temp(119 downto 116);
                    when "0011" => inputs <= output_array_temp(103 downto 100);
                    when "0100" => inputs <= output_array_temp(87 downto 84);
                    when "0101" => inputs <= output_array_temp(71 downto 68);
                    when "0110" => inputs <= output_array_temp(55 downto 52);
                    when "0111" => inputs <= output_array_temp(39 downto 36);
                    when "1000" => inputs <= output_array_temp(23 downto 20);
                    when "1001" => inputs <= output_array_temp(7 downto 4);
                    when others => inputs <= x"0";
                    end case;
                when "11" => switch <= "00";
                --switch off last anode for first part of shown output
                if(output_selector = "0001") then an <= "1111";
                else an <= "1110";
                    case output_selector is
                        when "0001" => inputs <= x"0";
                        when "0010" => inputs <= output_array_temp(115 downto 112);
                        when "0011" => inputs <= output_array_temp(99 downto 96);
                        when "0100" => inputs <= output_array_temp(83 downto 80);
                        when "0101" => inputs <= output_array_temp(67 downto 64);
                        when "0110" => inputs <= output_array_temp(51 downto 48);
                        when "0111" => inputs <= output_array_temp(35 downto 32);
                        when "1000" => inputs <= output_array_temp(19 downto 16);
                        when "1001" => inputs <= output_array_temp(3 downto 0);
                        when others => inputs <= x"0";
                        end case;
                      end if;  
                    when others => switch <= "00";
                    an <= "1111";
                    inputs <= "0000";
                    end case;
          end if;
          
          --if encryption is finished, the 7-seg display will turn on
            if(finished = '1' and output_selector = "0000") then 
                output_selector <= output_selector + 1;
            elsif (finished = '1') then
            -- counter for displaying the output in sequential order (reset makes sure that new output starts at beginning on 7-seg display)
            -- reset counter to 0 to keep cycling through output_array
                if (output_counter = "11111111111111111" or reset = '1') then
                    output_counter <= "00000000000000000";
                    -- reset output selector to keep cycling through output_array
                    if( output_selector = "1001") then output_selector <= "0001";
                    else output_selector <= output_selector + 1;
                    end if; 
                else output_counter <= output_counter + 1;     
                end if;
            else 
                -- keep display off
                output_selector <= "0000";
                output_counter <= "00000000000000000";
            end if;

         else
         counter <= counter + '1';
         end if;
            -- dont show dots on 7-seg display
           dp <= '1';
        end if;
end process;


--LUT for 7-seg display
process(inputs)
begin
        case inputs is
        when "0000" => seg <= "0000001"; --0
        when "0001" => seg <= "1001111"; --1
        when "0010" => seg <= "0010010"; --2
        when "0011" => seg <= "0000110"; --3
        when "0100" => seg <= "1001100"; --4
        when "0101" => seg <= "0100100"; --5
        when "0110" => seg <= "0100000"; --6
        when "0111" => seg <= "0001111"; --7
        when "1000" => seg <= "0000000"; --8
        when "1001" => seg <= "0000100"; --9
        when "1010" => seg <= "0000010"; --a
        when "1011" => seg <= "1100000"; --b
        when "1100" => seg <= "0110001"; --c
        when "1101" => seg <= "1000010"; --d
        when "1110" => seg <= "0110000"; --e
        when "1111" => seg <= "0111000"; --f
        when others => seg <= "1111110"; -- -
        end case;
end process;
