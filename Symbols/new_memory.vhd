----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:34:39 12/15/2020 
-- Design Name: 
-- Module Name:    new_memory - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity new_memory is
	port (
			clk : in std_logic;
			reset,enable : in std_logic;
			input : in std_logic_vector(3 downto 0);
			mode : in std_logic_vector(3 downto 0);
			step : out std_logic_vector(2 downto 0);--for debug
			
			digit_3 : in std_logic_vector(3 downto 0);
			digit_2 : in std_logic_vector(3 downto 0);
			digit_1 : in std_logic_vector(3 downto 0);
			digit_0 : in std_logic_vector(3 downto 0);
			
			win_out : out std_logic;
			mistake_out : out std_logic--must use oneshot inside this
	);
end new_memory;

architecture Behavioral of new_memory is
	signal mistake : std_logic := '0';
	signal win : std_logic := '0';
	
	signal regis : std_logic := '0';
	
	signal num_0 : std_logic_vector(3 downto 0) := (others => '0');
	signal btn_0 : std_logic_vector(3 downto 0) := (others => '0');
	
	signal num_1 : std_logic_vector(3 downto 0) := (others => '0');
	signal btn_1 : std_logic_vector(3 downto 0) := (others => '0');
	
	signal num_2 : std_logic_vector(3 downto 0) := (others => '0');
	signal btn_2 : std_logic_vector(3 downto 0) := (others => '0');
	
	signal num_3 : std_logic_vector(3 downto 0) := (others => '0');
	signal btn_3 : std_logic_vector(3 downto 0) := (others => '0');
	
	signal num_4 : std_logic_vector(3 downto 0) := (others => '0');
	signal btn_4 : std_logic_vector(3 downto 0) := (others => '0');
	
	constant startState: std_logic_vector(2 downto 0) 		:= "000";
	constant firstState: std_logic_vector(2 downto 0) 		:= "001";
	constant secondState: std_logic_vector(2 downto 0) 	:= "010";
	constant thirdState: std_logic_vector(2 downto 0) 		:= "011";
	constant fourthState: std_logic_vector(2 downto 0) 	:= "100";
	constant fifthState: std_logic_vector(2 downto 0) 		:= "101";
	constant winState: std_logic_vector(2 downto 0) 		:= "110";
	constant strikeState: std_logic_vector(2 downto 0) 	:= "111";
	signal currentState: std_logic_vector(2 downto 0) 		:= startState;
begin

	process(clk, input, reset)
	begin
		if reset = '1' then
			win_out <= '0';
			mistake_out <= '0';
			currentState <= startState;
			
			num_0 <= (others => '0');
			btn_0 <= (others => '0');
			num_1 <= (others => '0');
			btn_1 <= (others => '0');
			num_2 <= (others => '0');
			btn_2 <= (others => '0');
			num_3 <= (others => '0');
			btn_3 <= (others => '0');
		elsif (rising_edge(clk) and enable = '1')then
			case currentState is
				when startState =>
					if enable = '1' then
						currentState <= firstState;
					else
						currentState <= startState;
					end if;
					num_0 <= (others => '0');
					btn_0 <= (others => '0');
					num_1 <= (others => '0');
					btn_1 <= (others => '0');
					num_2 <= (others => '0');
					btn_2 <= (others => '0');
					num_3 <= (others => '0');
					btn_3 <= (others => '0');
					
					win_out <= '0';
					mistake_out <= '0';
				when firstState =>
					case mode is
						when "0001" =>
							if input = "0100" then
								currentState <= secondState;
							else
								currentState <= strikeState;
							end if;
						when "0010" =>
							if input = "0100" then
								currentState <= secondState;
							else
								currentState <= strikeState;
							end if;
						when "0011" =>
							if input = "0010" then
								currentState <= secondState;
							else
								currentState <= strikeState;
							end if;
						when "0100" =>
							if input = "0001" then
								currentState <= secondState;
							else
								currentState <= strikeState;
							end if;
						when others => null;
					end case;
					win_out <= '0';
					mistake_out <= '0';
					case input is
						when "0100" => num_0 <= digit_2;
						when "0010" => num_0 <= digit_1;
						when "0001" => num_0 <= digit_0;
						when others => null;
					end case;
					btn_0 <= input;
				when secondState =>
					case input is
						when "1000" => num_1 <= digit_3;
						when "0100" => num_1 <= digit_2;
						when "0010" => num_1 <= digit_1;
						when "0001" => num_1 <= digit_0;
						when others => null;
					end case;
					case mode is
						when "0001" =>
							if num_1 = "0100" then
								currentState <= thirdState;
							else
								currentState <= strikeState;
							end if;
						when "0010" =>
							if input = btn_0 then
								currentState <= thirdState;
							else
								currentState <= strikeState;
							end if;
						when "0011" =>
							if input = "1000" then
								currentState <= thirdState;
							else
								currentState <= strikeState;
							end if;
						when "0100" =>
							if input = btn_0 then
								currentState <= thirdState;
							else
								currentState <= strikeState;
							end if;
						when others => null;
					end case;	
					btn_1 <= input;
					win_out <= '0';
					mistake_out <= '0';
				when thirdState =>
					case input is
						when "1000" => num_2 <= digit_3;
						when "0100" => num_2 <= digit_2;
						when "0010" => num_2 <= digit_1;
						when "0001" => num_2 <= digit_0;
						when others => null;
					end case;
					
					case mode is
							when "0001" =>
							if num_2 = num_1 then
								currentState <= fourthState;
							else
								currentState <= strikeState;
							end if;
						when "0010" =>
							if num_2 = num_0 then
								currentState <= fourthState;
							else
								currentState <= strikeState;
							end if;	
						when "0011" =>
							if input = "0010" then
								currentState <= fourthState;
							else
								currentState <= strikeState;
							end if;
						when "0100" =>
							if num_2 = "0100" then
								currentState <= fourthState;
							else
								currentState <= strikeState;
							end if;
						when others => null;
					end case;
					
					btn_2 <= input;
					win_out <= '0';
					mistake_out <= '0';
				when fourthState =>
					
					case input is
						when "1000" => num_3 <= digit_3;
						when "0100" => num_3 <= digit_2;
						when "0010" => num_3 <= digit_1;
						when "0001" => num_3 <= digit_0;
						when others => null;
					end case;
					case mode is
						when "0001" =>
							if input = btn_0 then
								currentState <= fifthState;
							else
								currentState <= strikeState;
							end if;
						when "0010" =>
							if input = "1000" then
								currentState <= fifthState;
							else
								currentState <= strikeState;
							end if;	
						when "0011" =>
							if input = btn_1 then
								currentState <= fifthState;
							else
								currentState <= strikeState;
							end if;	
						when "0100" =>
							if input = btn_1 then
								currentState <= fifthState;
							else
								currentState <= strikeState;
							end if;
						when others => null;
					end case;
					btn_3 <= input;
					win_out <= '0';
					mistake_out <= '0';
				when fifthState =>
					case input is
						when "1000" => num_4 <= digit_3;
						when "0100" => num_4 <= digit_2;
						when "0010" => num_4 <= digit_1;
						when "0001" => num_4 <= digit_0;
						when others => null;
					end case;
					case mode is
						when "0001" =>
							if num_4 = num_0 then
								currentState <= winState;
							else
								currentState <= strikeState;
							end if;
						when "0010" =>
							if num_4 = num_1 then
								currentState <= winState;
							else
								currentState <= strikeState;
							end if;	
						when "0011" =>
							if num_4 = num_3 then
								currentState <= winState;
							else
								currentState <= strikeState;
							end if;
						when "0100" =>
							if num_4 = num_2 then
								currentState <= winState;
							else
								currentState <= strikeState;
							end if;
						when others => null;
					end case;
						
					btn_4 <= input;
					win_out <= '0';
					mistake_out <= '0';
				when winState =>
					if reset = '1' then
						currentState <= startState;
					else
						currentState <= winState;
					end if;
					win_out <= '1';
					mistake_out <= '0';
				when strikeState =>
					currentState <= startState;
					win_out <= '0';
					mistake_out <= '1';--oneshot here
				when others =>
					currentState <= startState;
					win_out <= '0';
					mistake_out <= '0';
			end case;
		end if;
	end process;
	
	step <= currentState;


end Behavioral;

