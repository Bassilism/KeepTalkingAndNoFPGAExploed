----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:48:25 12/10/2020 
-- Design Name: 
-- Module Name:    column_five - Behavioral 
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

entity column_five is
    Port ( input : in  STD_LOGIC_VECTOR (2 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end column_five;

architecture Behavioral of column_five is

begin

	process (input)
	begin
		case (input) is 
			when "000" => output <= "11101011" ;
			when "001" => output <= "11011001" ;
			when "010" => output <= "10101011" ;
			when "011" => output <= "11011111" ;
			when "100" => output <= "00101011" ;
			when "101" => output <= "10111101" ;
			when "110" => output <= "01010101" ;
			when "111" => output <= "00111011" ;
			when others => output <= "00000000";
		end case;
	end process;

end Behavioral;

