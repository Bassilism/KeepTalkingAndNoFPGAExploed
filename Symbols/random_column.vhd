----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:32:43 12/16/2020 
-- Design Name: 
-- Module Name:    random_column - Behavioral 
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

entity random_column is
    Port ( clk : in  STD_LOGIC;
           enable : in  STD_LOGIC;
			  reset : in std_logic;
           column_out : out  STD_LOGIC_VECTOR (2 downto 0));
end random_column;

architecture Behavioral of random_column is

	signal column : std_logic_vector (2 downto 0) := (others => '0');
	signal counter : std_logic_vector(23 downto 0) := (others => '0');

begin

	CounterProcess: process(clk, reset)
	begin
		
		if clk = '1' and ( enable = '1' or reset = '1' ) then		
				if column < "100" then 
					column <= column + 1;
				else
					column <= (others => '0');
				end if;
		end if;
	end process;

	column_out <= column;

end Behavioral;

