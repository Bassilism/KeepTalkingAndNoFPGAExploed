----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:39:52 12/16/2020 
-- Design Name: 
-- Module Name:    pseudorandom - Behavioral 
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

entity pseudorandom is
    Port ( clk : in  STD_LOGIC;
           enable : in  STD_LOGIC;
			  reset : in std_logic;
			  condition : in std_logic_vector(23 downto 0);
			  value : in std_logic_vector(11 downto 0);

           random : out  STD_LOGIC_VECTOR (23 downto 0)
			);
end pseudorandom;

architecture Behavioral of pseudorandom is

	signal counter : std_logic_vector(23 downto 0) := (others => '0');
	signal temp : std_logic_vector(23 downto 0) := (others => '0');
	signal clock : std_logic;

begin

	clock <= clk;

	process (clk, reset)
	begin
	
		if clk = '1' and (enable = '1' or reset = '1') then
			if counter < condition then
				counter <= counter + 1;
			else
				counter <= (others => '0');
				temp <= temp + value;
			end if;
		end if;
	
	end process;
	
	random <= temp;

end Behavioral;

