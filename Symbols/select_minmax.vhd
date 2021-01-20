----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:07:43 12/12/2020 
-- Design Name: 
-- Module Name:    select_minmax - Behavioral 
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

entity select_minmax is
	port (
				counter : in  STD_LOGIC_VECTOR (2 downto 0);
				digit_0 : in std_logic_vector (2 downto 0);
				digit_1 : in std_logic_vector (2 downto 0);
				digit_2 : in std_logic_vector (2 downto 0);
				digit_3 : in std_logic_vector (2 downto 0);
				output : out std_logic_vector (2 downto 0)
			);
end select_minmax;

architecture Behavioral of select_minmax is

begin

	process (counter)
	begin
	
		case counter is
			when "001" => output <= digit_0;
			when "010" => output <= digit_1;
			when "011" => output <= digit_2;
			when "100" => output <= digit_3;
			when others => output <= "000";
		end case;
	end process;

end Behavioral;

