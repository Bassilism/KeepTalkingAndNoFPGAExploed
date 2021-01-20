----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:27:55 12/10/2020 
-- Design Name: 
-- Module Name:    BinaryToSevSeg - Behavioral 
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

entity BinaryToSevSeg is
    Port ( input : in  STD_LOGIC_VECTOR (3 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end BinaryToSevSeg;

architecture Behavioral of BinaryToSevSeg is

begin
	
	process(input)
	begin
		
		case (input) is
			when "0000" => output <= "11111100" ;
			when "0001" => output <= "01100000" ;
			when "0010" => output <= "11011010" ;
			when "0011" => output <= "11110010" ;
			when "0100" => output <= "01100110" ; 
			when "0101" => output <= "10110110" ;
			when "0110" => output <= "10111110" ;
			when "0111" => output <= "11100000" ;
			when "1000" => output <= "11111110" ;
			when "1001" => output <= "11110110" ;
			when "1010" => output <= "11101110" ;
			when "1011" => output <= "00111110" ;
			when "1100" => output <= "00011010" ;
			when "1101" => output <= "01111010" ;
			when "1110" => output <= "10011110" ;
			when "1111" => output <= "10001110" ;
			when others => output <= "00000000" ;
		end case;
	end process;			

end Behavioral;

