----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:30:09 12/11/2020 
-- Design Name: 
-- Module Name:    common_counter - Behavioral 
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
use ieee.std_logic_unsigned.all;

entity common_counter is
    Port ( osc : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (3 downto 0)
	);
end common_counter;

architecture Behavioral of common_counter is
	
	signal counter : std_logic_vector(1 downto 0) := (others => '0');
	signal clk : std_logic_vector(1 downto 0) := (others => '0');
	signal common : std_logic_vector(3 downto 0) := (others => '0');
	
begin

	CounterProcess: process(osc)
	begin
		
		if rising_edge(osc) then
			if clk < "11" then
				clk <= clk + 1;
			else
				clk <= (others => '0');
				counter <= counter + 1;
			end if;
		end if;
	end process;
	
	CommonProcess: process
	begin
		
		case counter is
			when "00" => common <= "1110";
			when "01" => common <= "1101";
			when "10" => common <= "1011";
			when "11" => common <= "0111";
			when others => null;
		end case;
	end process;
	
	output <= common;

end Behavioral;

