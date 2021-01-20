----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:05:45 12/12/2020 
-- Design Name: 
-- Module Name:    select_symbols - Behavioral 
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

entity select_symbols is
	port (
				button : in  STD_LOGIC_VECTOR (3 downto 0);
				digit_0 : in std_logic_vector (2 downto 0);
				digit_1 : in std_logic_vector (2 downto 0);
				digit_2 : in std_logic_vector (2 downto 0);
				digit_3 : in std_logic_vector (2 downto 0);
				output : out std_logic_vector (2 downto 0)
			);
end select_symbols;

architecture Behavioral of select_symbols is

begin

	process (button)
	begin
	
		case button is
			when "1000" => output <= digit_3;
			when "0100" => output <= digit_2;
			when "0010" => output <= digit_1;
			when "0001" => output <= digit_0;
			when others => output <= "000";
		end case;
	
	end process;

end Behavioral;

