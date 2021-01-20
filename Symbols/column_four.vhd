----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:35:58 12/10/2020 
-- Design Name: 
-- Module Name:    column_four - Behavioral 
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

entity column_four is
    Port ( input : in  STD_LOGIC_VECTOR (2 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end column_four;

architecture Behavioral of column_four is

begin

	process(input)
	begin
		
		case (input) is
			when "000" => output <= "10101111" ;
			when "001" => output <= "01110111" ;
			when "010" => output <= "00101011" ;
			when "011" => output <= "11011111" ;
			when "100" => output <= "10001001" ;
			when "101" => output <= "01110011" ;
			when "110" => output <= "11100111" ;
			when "111" => output <= "10101011" ;
			when others => output <= "00000000";
		end case;
	end process;

end Behavioral;

