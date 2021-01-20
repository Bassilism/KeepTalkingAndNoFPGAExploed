----------------------------------------------------------------------------------
-- Company: 
-- Engineer:  
-- Create Date:    16:04:29 12/16/2020 
-- Design Name: 
-- Module Name:    new_random - Behavioral 
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

entity new_random is
	generic (N : integer := 24);
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
end new_random;

architecture Behavioral of new_random is

	component random_column
    Port ( clk : in  STD_LOGIC;
           enable : in  STD_LOGIC;
			  reset : in std_logic;
           column_out : out  STD_LOGIC_VECTOR (2 downto 0)
			);
	end component;
	
	component pseudorandom is
		 Port ( clk : in  STD_LOGIC;
				  enable : in  STD_LOGIC;
				  reset : in std_logic;
				  condition : in std_logic_vector(N-1 downto 0);
				  value : in std_logic_vector(11 downto 0);

				  random : out  STD_LOGIC_VECTOR (N-1 downto 0)
				);
	end component;
	
	component Compare8 
	port (
			
				num_0 : in  STD_LOGIC_VECTOR (N-1 downto 0);
				num_1 : in  STD_LOGIC_VECTOR (N-1 downto 0);
				num_2 : in  STD_LOGIC_VECTOR (N-1 downto 0);
				num_3 : in  STD_LOGIC_VECTOR (N-1 downto 0);
				num_4 : in  STD_LOGIC_VECTOR (N-1 downto 0);
				num_5 : in  STD_LOGIC_VECTOR (N-1 downto 0);
				num_6 : in  STD_LOGIC_VECTOR (N-1 downto 0);
				num_7 : in  STD_LOGIC_VECTOR (N-1 downto 0);
				
				first 	: out  STD_LOGIC_VECTOR (N-1 downto 0);
				second 	: out  STD_LOGIC_VECTOR (N-1 downto 0);
				third 	: out  STD_LOGIC_VECTOR (N-1 downto 0);
				fourth 	: out  STD_LOGIC_VECTOR (N-1 downto 0);
				fifth 	: out  STD_LOGIC_VECTOR (N-1 downto 0);
				sixth 	: out  STD_LOGIC_VECTOR (N-1 downto 0);
				seventh 	: out  STD_LOGIC_VECTOR (N-1 downto 0);
				eighth 	: out  STD_LOGIC_VECTOR (N-1 downto 0)
		);
	end component;
	
	
	-- random
		signal random_00 : std_logic_vector(23 downto 0) := "100000011100101011011010";
		signal random_01 : std_logic_vector(23 downto 0) := "101110011001000111000010";
		signal random_02 : std_logic_vector(23 downto 0) := "100101100010101000001010";
		signal random_03 : std_logic_vector(23 downto 0) := "101111111111111111111111";
		signal random_04 : std_logic_vector(23 downto 0) := "101110011000001111011111";
		signal random_05 : std_logic_vector(23 downto 0) := "100101010101100111011010";
		signal random_06 : std_logic_vector(23 downto 0) := "100110011001101110110101";
		signal random_07 : std_logic_vector(23 downto 0) := "100101010101000111011010";
		
		signal first 	: STD_LOGIC_VECTOR (N-1 downto 0);
		signal second 	: STD_LOGIC_VECTOR (N-1 downto 0);
		signal third 	: STD_LOGIC_VECTOR (N-1 downto 0);
		signal fourth 	: STD_LOGIC_VECTOR (N-1 downto 0);
		signal fifth 	: STD_LOGIC_VECTOR (N-1 downto 0);
		signal sixth 	: STD_LOGIC_VECTOR (N-1 downto 0);
		signal seventh : STD_LOGIC_VECTOR (N-1 downto 0);
		signal eighth 	: STD_LOGIC_VECTOR (N-1 downto 0);
		
		signal c : std_logic := '0';
		signal counter : std_logic_vector(3 downto 0) := "0000";

begin

	process (clk)
	begin
	
		if rising_edge(clk) then
			if counter < "1001" then
				counter <= counter + 1;
			else
				counter <= "0000";
				c <= not c;
			end if;
		end if;
	end process;

	AA : random_column
		port map (
				clk  => c,
				enable => enable,
				reset => reset,
				column_out => column_out
		);
		
	rn0 : pseudorandom 
		 Port map( 
				clk => c,
				enable => enable,
				reset => reset,
				condition => "100101010101000111011010",
				value => "011101011111",

				random => random_00
		);
	
	rn1 : pseudorandom 
		 Port map( 
				clk => c,
				enable => enable,
				reset => reset,
				condition => "100101010101100111011010",
				value => "000110101110",

				random => random_01
		);
	
	rn2 : pseudorandom 
		 Port map( 
				clk => c,
				enable => enable,
				reset => reset,
				condition => "100000011100101011011010",
				value => "011100010111",

				random => random_02
		);
	
	rn3 : pseudorandom 
		 Port map( 
				clk => c,
				enable => enable,
				reset => reset,
				condition => "100101100010101000001010",
				value => "001011110111",

				random => random_03
		);
	
	rn4 : pseudorandom 
		 Port map( 
				clk => c,
				enable => enable,
				reset => reset,
				condition => "100110011001101110110101",
				value => "000110010111",

				random => random_04
		);
	
	rn5 : pseudorandom 
		 Port map( 
				clk => c,
				enable => enable,
				reset => reset,
				condition => "101110011000001111011111",
				value => "111111110111",

				random => random_05
		);
	
	rn6 : pseudorandom 
		 Port map( 
				clk => c,
				enable => enable,
				reset => reset,
				condition => "101110011001000111000010",
				value => "110000011111",

				random => random_06
		);
	
	rn7 : pseudorandom 
		 Port map( 
				clk => c,
				enable => enable,
				reset => reset,
				condition => "101111111111111111111111",
				value => "011111101111",

				random => random_07
		);
		
	cmp8 : Compare8 
	port map(
			
				num_0 => random_00,
				num_1 => random_01,
				num_2 => random_02,
				num_3 => random_03,
				num_4 => random_04,
				num_5 => random_05,
				num_6 => random_06,
				num_7 => random_07,
				
				first 	=> first,
				second 	=> second,
				third 	=> third,	
				fourth 	=> fourth,
				fifth 	=> fifth,
				sixth 	=> sixth,
				seventh 	=> seventh,
				eighth 	=> eighth
		);
		
	random_0 <= "000" when random_00 = first 		else
					"001" when random_00 = second 	else
					"010" when random_00 = third 		else
					"011" when random_00 = fourth 	else
					"100" when random_00 = fifth 		else
					"101" when random_00 = sixth 		else
					"110" when random_00 = seventh 	else
					"111";
					
	random_1 <= "000" when random_02 = first 		else
					"001" when random_02 = second 	else
					"010" when random_02 = third 		else
					"011" when random_02 = fourth 	else
					"100" when random_02 = fifth 		else
					"101" when random_02 = sixth 		else
					"110" when random_02 = seventh 	else
					"111";
					
	random_2 <= "000" when random_04 = first 		else
					"001" when random_04 = second 	else
					"010" when random_04 = third 		else
					"011" when random_04 = fourth 	else
					"100" when random_04 = fifth 		else
					"101" when random_04 = sixth 		else
					"110" when random_04 = seventh 	else
					"111";
					
	random_3 <= "000" when random_06 = first 		else
					"001" when random_06 = second 	else
					"010" when random_06 = third 		else
					"011" when random_06 = fourth 	else
					"100" when random_06 = fifth 		else
					"101" when random_06 = sixth 		else
					"110" when random_06 = seventh 	else
					"111";				
	

end Behavioral;

