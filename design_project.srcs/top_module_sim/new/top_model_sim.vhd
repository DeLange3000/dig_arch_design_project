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
    reset : in std_logic;
    start_encode : in std_logic;
    finished : out std_logic
    );
    --debug : out std_logic
end component;
 
signal temp_output_array : std_logic_vector(127 downto 0);

---TESTING
signal switch : std_logic_vector(1 downto 0) := "00";
signal inputs : std_logic_vector(3 downto 0) := "0000";
signal counter : std_logic_vector(10 downto 0) := "00000000000";
signal output_counter : std_logic_vector(16 downto 0):= "00000000000000000";
signal switch_output : std_logic_vector(3 downto 0) := "0000";
signal output_selector : std_logic_vector (3 downto 0) := "0000";
signal finished : std_logic;

begin
output_array <= temp_output_array;
encoding2 : full_encoding port map(clk => clk, input_array => input_array, output_array => temp_output_array, reset => btnR, start_encode => btnC, finished => finished);
--input_array <= x"6BC1BEE22E409F96E93D7E117393172A";

process(btnC, btnR, clk)
begin

if(temp_output_array = x"3AD77BB40D7A3660A89ECAF32466EF97") then
    led <= "0111111111111110";
    else
    led <= "1000000000000001";
 end if;

 
 if(btnL = '1' or btnC = '1' or btnR = '1') then led(3) <= '1';
 end if;
    
--end process;


----TESTING------------------
    if (clk'event and clk = '1') then
        if(counter = "11111111111") then
        counter <= "00000000000";
        
    if(output_selector = "0000") then an <= "1111";
            else
            case switch is
                when "00" => switch <= "01";
                    an <= "0111";
                    case output_selector is
                    when "0001" => inputs <= x"0";
                    when "0010" => inputs <= temp_output_array(127 downto 124);
                    when "0011" => inputs <= temp_output_array(111 downto 108);
                    when "0100" => inputs <= temp_output_array(95 downto 92);
                    when "0101" => inputs <= temp_output_array(79 downto 76);
                    when "0110" => inputs <= temp_output_array(63 downto 60);
                    when "0111" => inputs <= temp_output_array(47 downto 44);
                    when "1000" => inputs <= temp_output_array(31 downto 28);
                    when "1001" => inputs <= temp_output_array(15 downto 12);
                    when others => inputs <= x"0";
                    end case;
                when "01" => switch <= "10";
                an <= "1011";
                case output_selector is
                    when "0001" => inputs <= x"5";
                    when "0010" => inputs <= temp_output_array(123 downto 120);
                    when "0011" => inputs <= temp_output_array(107 downto 104);
                    when "0100" => inputs <= temp_output_array(91 downto 88);
                    when "0101" => inputs <= temp_output_array(75 downto 72);
                    when "0110" => inputs <= temp_output_array(59 downto 56);
                    when "0111" => inputs <= temp_output_array(43 downto 40);
                    when "1000" => inputs <= temp_output_array(27 downto 24);
                    when "1001" => inputs <= temp_output_array(11 downto 8);
                    when others => inputs <= x"0";
                    end case;
                when "10" => switch <= "11";
                an <= "1101";
                case output_selector is
                    when "0001" => inputs <= x"0";
                    when "0010" => inputs <= temp_output_array(119 downto 116);
                    when "0011" => inputs <= temp_output_array(103 downto 100);
                    when "0100" => inputs <= temp_output_array(87 downto 84);
                    when "0101" => inputs <= temp_output_array(71 downto 68);
                    when "0110" => inputs <= temp_output_array(55 downto 52);
                    when "0111" => inputs <= temp_output_array(39 downto 36);
                    when "1000" => inputs <= temp_output_array(35 downto 32);
                    when "1001" => inputs <= temp_output_array(7 downto 4);
                    when others => inputs <= x"0";
                    end case;
                when "11" => switch <= "00";
                an <= "1110";
                case output_selector is
                    when "0001" => inputs <= x"0";
                    when "0010" => inputs <= temp_output_array(115 downto 112);
                    when "0011" => inputs <= temp_output_array(99 downto 96);
                    when "0100" => inputs <= temp_output_array(83 downto 80);
                    when "0101" => inputs <= temp_output_array(67 downto 64);
                    when "0110" => inputs <= temp_output_array(51 downto 48);
                    when "0111" => inputs <= temp_output_array(35 downto 32);
                    when "1000" => inputs <= temp_output_array(31 downto 28);
                    when "1001" => inputs <= temp_output_array(3 downto 0);
                    when others => inputs <= x"0";
                    end case;
                when others => switch <= "00";
                an <= "1111";
                inputs <= "0000";
                end case;
          end if;
            
            if (output_counter = "11111111111111111") then
                output_counter <= "00000000000000000";
                if( output_selector = "1000") then output_selector <= "0001";
                else
                --output_selector <= output_selector + 1;
                    if(finished = '1') then output_selector <= output_selector + 1;
                    else output_selector <= "0000";
                    end if;
                end if;
            else
                output_counter <= output_counter + '1';
            end if;
         else
         counter <= counter + '1';
         end if;
    end if;
    
           dp <= '1';
end process;

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


-------------------------------




end Behavioral;
