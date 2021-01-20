----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:00:32 12/10/2020 
-- Design Name: 
-- Module Name:    column_one - Behavioral 
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

entity column_one is
    Port ( input : in  STD_LOGIC_VECTOR (2 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0)
	);
end column_one;

architecture Behavioral of column_one is

begin
	
	process(input)
	begin
		
		case (input) is
			when "000" => output <= "00101001" ;
			when "001" => output <= "00101111" ;
			when "010" => output <= "10010011" ;
			when "011" => output <= "10101011" ;
			when "100" => output <= "10001001" ;
			when "101" => output <= "10110001" ;
			when "110" => output <= "00011111" ;
			when "111" => output <= "11101011" ;
			when others => output <= "00000000";
		end case;
	end process;

end Behavioral;

