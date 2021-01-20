----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:09:23 12/12/2020 
-- Design Name: 
-- Module Name:    select_row - Behavioral 
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

entity select_row is
    Port ( input : in  STD_LOGIC_VECTOR (2 downto 0);
			  column : in std_logic_vector (2 downto 0);
           seg_out : out  STD_LOGIC_VECTOR (7 downto 0)
			);
end select_row;

architecture Behavioral of select_row is

	-- symbols 6 column
	signal seg_0: std_logic_vector(7 downto 0);
	signal seg_1: std_logic_vector(7 downto 0);
	signal seg_2: std_logic_vector(7 downto 0);
	signal seg_3: std_logic_vector(7 downto 0);
	signal seg_4: std_logic_vector(7 downto 0);
	signal seg_5: std_logic_vector(7 downto 0);

	component column_one
		port (
			input : std_logic_vector(2 downto 0);
			output : std_logic_vector(7 downto 0)
		);
	end component;
	
	component column_two
		port (
			input : std_logic_vector(2 downto 0);
			output : std_logic_vector(7 downto 0)
		);
	end component;
	
	component column_three
		port (
			input : std_logic_vector(2 downto 0);
			output : std_logic_vector(7 downto 0)
		);
	end component;
	
	component column_four
		port (
			input : std_logic_vector(2 downto 0);
			output : std_logic_vector(7 downto 0)
		);
	end component;
	
	component column_five
		port (
			input : std_logic_vector(2 downto 0);
			output : std_logic_vector(7 downto 0)
		);
	end component;
	
	component column_six
		port (
			input : std_logic_vector(2 downto 0);
			output : std_logic_vector(7 downto 0)
		);
	end component;

begin

-- init column
					
	one : column_one
	port map(	input(2 downto 0) => input(2 downto 0),
					output(7 downto 0) => seg_0(7 downto 0)
				);
				
	two : column_two
	port map(	input(2 downto 0) => input(2 downto 0),
					output(7 downto 0) => seg_1(7 downto 0)
				);
				
	three : column_three
	port map(	input(2 downto 0) => input(2 downto 0),
					output(7 downto 0) => seg_2(7 downto 0)
				);
	
	four : column_four
	port map(	input(2 downto 0) => input(2 downto 0),
					output(7 downto 0) => seg_3(7 downto 0)
				);
				
	five : column_five
	port map(	input(2 downto 0) => input(2 downto 0),
					output(7 downto 0) => seg_4(7 downto 0)
				);
	
	six : column_six
	port map(	input(2 downto 0) => input(2 downto 0),
					output(7 downto 0) => seg_5(7 downto 0)
					);
					
	-- end init column
	
	ColumnMultiplexer: process (column)
	begin
	
		case column is 
			when "000" => seg_out <= seg_0 ;
			when "001" => seg_out <= seg_1 ;
			when "010" => seg_out <= seg_2 ;
			when "011" => seg_out <= seg_3 ;
			when "100" => seg_out <= seg_4 ;
			when "101" => seg_out <= seg_5 ;
			when others => null;
		end case;
	
	end process;


end Behavioral;

