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

entity mem_random is
	generic (N : integer := 24);
	port (
			  clk : in  STD_LOGIC;
			  enable : in std_logic;
			  reset : in std_logic;
			  
			  mode_out : out std_logic_vector (3 downto 0);
           random_0 : out  STD_LOGIC_VECTOR (3 downto 0);
           random_1 : out  STD_LOGIC_VECTOR (3 downto 0);
           random_2 : out  STD_LOGIC_VECTOR (3 downto 0);
           random_3 : out  STD_LOGIC_VECTOR (3 downto 0)
	);
end mem_random;

architecture Behavioral of mem_random is

	signal column : std_logic_vector (3 downto 0) := (others => '0');
	
	component pseudorandom is
		 Port ( clk : in  STD_LOGIC;
				  enable : in  STD_LOGIC;
				  reset : in std_logic;
				  condition : in std_logic_vector(N-1 downto 0);
				  value : in std_logic_vector(11 downto 0);

				  random : out  STD_LOGIC_VECTOR (N-1 downto 0)
				);
	end component;
	
	component Compare4_24Bits is
    Port ( num_0 : in  STD_LOGIC_VECTOR (N-1 downto 0);
           num_1 : in  STD_LOGIC_VECTOR (N-1 downto 0);
           num_2 : in  STD_LOGIC_VECTOR (N-1 downto 0);
           num_3 : in  STD_LOGIC_VECTOR (N-1 downto 0);
           min   : out  STD_LOGIC_VECTOR (N-1 downto 0);
           min_0 : out  STD_LOGIC_VECTOR (N-1 downto 0);
           max_0 : out  STD_LOGIC_VECTOR (N-1 downto 0);
           max   : out  STD_LOGIC_VECTOR (N-1 downto 0));
	end component;
	
	
	-- random
		signal random_00 : std_logic_vector(23 downto 0) := "100000011100101011011010";
		signal random_01 : std_logic_vector(23 downto 0) := "101110011001000111000010";
		signal random_02 : std_logic_vector(23 downto 0) := "100101100010101000001010";
		signal random_03 : std_logic_vector(23 downto 0) := "101111111111111111111111";
		
		signal first 	: STD_LOGIC_VECTOR (N-1 downto 0);
		signal second 	: STD_LOGIC_VECTOR (N-1 downto 0);
		signal third 	: STD_LOGIC_VECTOR (N-1 downto 0);
		signal fourth 	: STD_LOGIC_VECTOR (N-1 downto 0);
		
		signal c : std_logic := '0';
		signal counter : std_logic_vector(3 downto 0) := "0000";

begin

	process (clk)
	begin
		
		if rising_edge(clk) and ( enable = '1' or reset = '1' ) then		
				if column < "0100" then 
					column <= column + 1;
				else
					column <= "0001";
				end if;
		end if;
	
		if rising_edge(clk) then
			if counter < "1001" then
				counter <= counter + 1;
			else
				counter <= "0000";
				c <= not c;
			end if;
		end if;
	end process;
	
	mode_out <= column;

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
		
	cmp4 : Compare4_24Bits
    Port map( 
				num_0 => random_00,
				num_1 => random_01,
				num_2 => random_02,
				num_3 => random_03,
				min 	=> first,
				min_0 => second,
				max_0 => third,
				max 	=> fourth
	);
		
	random_0 <= "0001" when random_00 = first 	else
					"0010" when random_00 = second 	else
					"0011" when random_00 = third 	else
					"0100" ;
					
	random_1 <= "0001" when random_01 = first 	else
					"0010" when random_01 = second 	else
					"0011" when random_01 = third 	else
					"0100" ;
					
	random_2 <= "0001" when random_02 = first 	else
					"0010" when random_02 = second 	else
					"0011" when random_02 = third 	else
					"0100" ;
					
	random_3 <= "0001" when random_03 = first 	else
					"0010" when random_03 = second 	else
					"0011" when random_03 = third 	else
					"0100" ;				
	

end Behavioral;

