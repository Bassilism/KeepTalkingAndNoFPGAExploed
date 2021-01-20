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

entity common_mem is
    Port ( osc : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (4 downto 0)
	);
end common_mem;

architecture Behavioral of common_mem is
	
	signal counter : std_logic_vector(2 downto 0) := (others => '0');
	signal clk : std_logic_vector(1 downto 0) := (others => '0');
	signal common : std_logic_vector(4 downto 0) := (others => '0');
	
begin

	CounterProcess: process(osc)
	begin
		
		if rising_edge(osc) then
			if clk < "11" then
				clk <= clk + 1;
			else
				clk <= (others => '0');
				
				if counter < "100" then
					counter <= counter + 1;
				else 
					counter <= "000";
				end if;
			end if;
		end if;
	end process;
	
	CommonProcess: process
	begin
		
		case counter is
			when "000" => common <= "11110";
			when "001" => common <= "11101";
			when "010" => common <= "11011";
			when "011" => common <= "10111";
			when "100" => common <= "01111";
			when others => null;
		end case;
	end process;
	
	output <= common;

end Behavioral;
