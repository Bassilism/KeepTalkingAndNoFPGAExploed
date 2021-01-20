----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:24:12 12/10/2020 
-- Design Name: 
-- Module Name:    column_three - Behavioral 
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

entity column_three is
	Port ( input : in  STD_LOGIC_VECTOR (2 downto 0);
			 output : out  STD_LOGIC_VECTOR (7 downto 0)
	);
end column_three;

architecture Behavioral of column_three is

begin
	
	process(input)
	begin
		
		case (input) is
			when "000" => output <= "01010111" ;
			when "001" => output <= "10110101" ;
			when "010" => output <= "00110111" ;
			when "011" => output <= "01110011" ;
			when "100" => output <= "10101111" ;
			when "101" => output <= "00101111" ;
			when "110" => output <= "11000111" ;
			when "111" => output <= "10101101" ;
			when others => output <= "00000000";
		end case;
	end process;

end Behavioral;

