----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:29:36 12/14/2020 
-- Design Name: 
-- Module Name:    Symbols_module - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Symbols_module is
	port (	
				-- INOUT
				input : in std_logic;
				switch : in std_logic_vector(3 downto 0);
				reset_stage : in std_logic;
				osc : in std_logic;
				
				-- DEBUG
--				seg_1 : out std_logic_vector(7 downto 0);			-- 41 40 35 34 32 29 27 26
--				common_1 : out std_logic_vector(3 downto 0);		-- 30 33 43 44
--				common_2 : out std_logic_vector(3 downto 0);		-- common sort 16 9 7 6
--				seg_2 : out std_logic_vector(7 downto 0);			-- sort random 14 5 10 15 17 11 8 12
--				led : out std_logic_vector(3 downto 0);			-- column mode 88 84 85 87
--				led_regis :out std_logic_vector(3 downto 0);		-- button push 92 93 94 95
--				led_count : out std_logic_vector(3 downto 0);	-- button count 79 80 81 82
--				bt_num : out std_logic_vector(7 downto 0);
--				ls_num : out std_logic_vector(7 downto 0);
--				common_3 : out std_logic_vector( 1 downto 0);
				
				-- OUTPUT
				seg : out std_logic_vector(7 downto 0);
				common : out std_logic_vector(3 downto 0);
				correct : out std_logic_vector(3 downto 0);
				win : out std_logic;
				mistake_out : out std_logic
			);
end Symbols_module;

architecture Behavioral of Symbols_module is

	-- random 
		signal clk : std_logic;
		signal reset : std_logic := '0';
		signal column : std_logic_vector(2 downto 0) := (others => '0');

		signal random_0 : std_logic_vector(2 downto 0) := (others => '0');
		signal random_1 : std_logic_vector(2 downto 0) := (others => '0');
		signal random_2 : std_logic_vector(2 downto 0) := (others => '0');
		signal random_3 : std_logic_vector(2 downto 0) := (others => '0');
	
		component Random4
			 Port ( clk : in  STD_LOGIC;
					  column_out : out std_logic_vector (2 downto 0);
					  random_0 : out  STD_LOGIC_VECTOR (2 downto 0);
					  random_1 : out  STD_LOGIC_VECTOR (2 downto 0);
					  random_2 : out  STD_LOGIC_VECTOR (2 downto 0);
					  random_3 : out  STD_LOGIC_VECTOR (2 downto 0));
		end component;
		
		component new_random is
			port (
					  clk : in  STD_LOGIC;
					  enable : in std_logic;
					  reset : in std_logic;
					  column_out : out std_logic_vector (2 downto 0);
					  random_0 : out  STD_LOGIC_VECTOR (2 downto 0);
					  random_1 : out  STD_LOGIC_VECTOR (2 downto 0);
					  random_2 : out  STD_LOGIC_VECTOR (2 downto 0);
					  random_3 : out  STD_LOGIC_VECTOR (2 downto 0)
			);
		end component;
	-- end random
	
	-- Switch one shot
		signal oneshot : std_logic_vector(3 downto 0);
		
		component switch_oneshot
			 Port ( osc : in  STD_LOGIC;
					  switch : in  STD_LOGIC_VECTOR (3 downto 0);
					  output : out  STD_LOGIC_VECTOR (3 downto 0));
		end component;
	-- end one shot
	
	-- Select row of symbols
		signal input_num : std_logic_vector(2 downto 0);
		signal seg_num : std_logic_vector(7 downto 0);
		signal com : std_logic_vector(3 downto 0);
		
		component select_row 
		Port ( 
					input : in  STD_LOGIC_VECTOR (2 downto 0);
					column : in std_logic_vector (2 downto 0);
					seg_out : out  STD_LOGIC_VECTOR (7 downto 0)
				);
		end component;
	-- end select
	
	-- compare
		signal input_sort : std_logic_vector(2 downto 0);
		signal seg_sort : std_logic_vector(7 downto 0);
		
		signal first : std_logic_vector(2 downto 0);
		signal second : std_logic_vector(2 downto 0);
		signal third : std_logic_vector(2 downto 0);
		signal fourth : std_logic_vector(2 downto 0);
	
		component Compare4
			port (
				  num_0 : in  STD_LOGIC_VECTOR (2 downto 0);
				  num_1 : in  STD_LOGIC_VECTOR (2 downto 0);
				  num_2 : in  STD_LOGIC_VECTOR (2 downto 0);
				  num_3 : in  STD_LOGIC_VECTOR (2 downto 0);
				  min   : out  STD_LOGIC_VECTOR (2 downto 0);
				  min_0 : out  STD_LOGIC_VECTOR (2 downto 0);
				  max_0 : out  STD_LOGIC_VECTOR (2 downto 0);
				  max   : out  STD_LOGIC_VECTOR (2 downto 0)
			);
		end component;
	-- end compare 
	
	-- Compare symbols
		signal mistake : std_logic := '1';
		signal stage : std_logic := '0';
		signal rand : std_logic := '1';
		signal correct_button : std_logic_vector (3 downto 0);
		
		signal s_num : std_logic_vector (2 downto 0);
		signal l_num : std_logic_vector (2 downto 0);
		signal s_out : std_logic_vector (7 downto 0);
		signal l_out : std_logic_vector (7 downto 0);
	
		component Compare_symbols is
			 Port ( 
						clk : in std_logic;
						reset : in std_logic;
						counter : in  STD_LOGIC_VECTOR (2 downto 0);
						button : in  STD_LOGIC_VECTOR (3 downto 0);
						digit_0 : in  STD_LOGIC_VECTOR (2 downto 0);
						digit_1 : in  STD_LOGIC_VECTOR (2 downto 0);
						digit_2 : in  STD_LOGIC_VECTOR (2 downto 0);
						digit_3 : in  STD_LOGIC_VECTOR (2 downto 0);
						first : in  STD_LOGIC_VECTOR (2 downto 0);
						second : in  STD_LOGIC_VECTOR (2 downto 0);
						third : in  STD_LOGIC_VECTOR (2 downto 0);
						fourth : in  STD_LOGIC_VECTOR (2 downto 0);
						correct : out std_logic_vector (3 downto 0);
						s_out : out std_logic_vector (2 downto 0);
						l_out : out std_logic_vector (2 downto 0);
						output : out  STD_LOGIC
					);
		end component;
	-- end comp sym
	
	-- Common
		component common_counter
			port (
				osc : std_logic;
				output : std_logic_vector(3 downto 0)
			);
		end component;
	-- end common
	
	-- Button
		signal button_count : std_logic_vector(3 downto 0);
		signal button_out : std_logic_vector(3 downto 0);
		
		component button_register
			port ( 
				clk : in std_logic;
				button : in  STD_LOGIC_VECTOR (3 downto 0);
				reset : in std_logic;
				counter : out  STD_LOGIC_VECTOR (3 downto 0);
				regis : out std_logic_vector (3 downto 0);
				output : out  STD_LOGIC_VECTOR (3 downto 0)
			);
		end component;
	-- end button
	
	-- Others
		component AND2
			port ( I0 : in std_logic;
					 I1 : in std_logic;
					 O : out std_logic
					);
		end component;
		
		component VCC
			port ( P : out std_logic);
		end component;
		
		component GND
			port ( P : out	std_logic);
		end component;
		
		component INV
			port ( I : in    std_logic; 
					 O : out   std_logic);
		end component;
	-- end others

begin

	rand <= 	'1' when reset_stage = '1' else
				'0' when input = '1';
	
	reset <= mistake;
	
	-- Input button
		AAA : switch_oneshot
			 Port map( 
					osc => osc,
					switch => switch,
					output => oneshot
			);
	-- end input

	-- random	
		A : AND2
		port map(	I0 => osc, I1 => '1',
						O => clk
					);
					
		R4 : new_random
		Port map( 
						clk => clk,
						enable => rand,
						reset => reset,
						column_out => column,
						random_0 => random_0,
						random_1 => random_1,
						random_2 => random_2,
						random_3 => random_3
		);
	-- end random
	
	-- Compare
		comp : Compare4
		port map (
			num_0 => random_0,	num_1 => random_1,
			num_2 => random_2,	num_3 => random_3,
			min => first,			min_0 => second,
			max_0 => third,		max => fourth
		);
	-- end compare

	-- Common
	
		cmmn : common_counter
			port map(	osc => osc,
							output(3 downto 0) => com
						);
		
		common <= not com;
		-- common_1 <= com;
		-- common_2 <= not com;
		-- common_3 <= "11";
		
		CommonProcess: process(com)
		begin
			
			case com is
				when "1110" => input_num <= random_0;
									input_sort <= fourth;
									
				when "1101" => input_num <= random_1;
									input_sort <= third;
									
				when "1011" => input_num <= random_2;
									input_sort <= second;
									
				when "0111" => input_num <= random_3;
									input_sort <= first;
									
				when others => null;
			end case;
			
		end process;
	-- end common
	
	-- Select row of symbols
		row : select_row 
		Port map( 
					input => input_num,
					column => column,
					seg_out =>seg_num
				);		
		row_s : select_row 
		Port map( 
					input => input_sort,
					column => column,
					seg_out =>seg_sort
				);
	-- end select
	
	-- Button
		btrgt : button_register
			port map (
					clk => osc,
					button => switch, 
					reset => reset,
					counter => button_count,
					regis => correct,
					output => button_out
				);
	-- end button
	
	-- Compare symbols
		comp_symbolss : Compare_symbols
			 Port map( 
						clk => osc,
						reset => reset,
						counter 	=> button_count(2 downto 0),
						button 	=> button_out,
						digit_0 	=> random_0,
						digit_1 	=> random_1,
						digit_2 	=> random_2,
						digit_3 	=> random_3,
						first 	=> first,
						second 	=> second,
						third 	=> third,
						fourth 	=> fourth,
						correct 	=> correct_button,
						s_out 	=> s_num,
						l_out		=> l_num,
						output 	=> mistake
					);			
	-- end compare symbold
	
	-- Win status
	
		process (button_count)
		begin
		
			case button_count is
				when "0100" => win <= '1';
				when others => win <= '0';
			end case;
		
		end process;
	
	-- end win
	
	-- Debug compare
	
		row_smb : select_row 
		Port map( 
					input => s_num,
					column => column,
					seg_out => s_out
				);
				
		row_lst : select_row 
		Port map( 
					input => l_num,
					column => column,
					seg_out => l_out
				);
				
	-- end debug
	
	-- OUTPUT
	
		seg <= not seg_num;
		mistake_out <= mistake;
	
	-- DEBUG
	
		--	seg_1 <= seg_num;
		--	seg_2 <= not seg_sort;
		--	bt_num <= not s_out;
		--	ls_num <= not l_out;
			
		--	led(3) <= 'Z';
		--	led(2 downto 0) <= column;
			
		--	led_count <= button_count;
		--	led_regis <= button_out;


end Behavioral;

