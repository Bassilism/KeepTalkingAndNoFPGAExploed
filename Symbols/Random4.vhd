----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:21:22 12/12/2020 
-- Design Name: 
-- Module Name:    Random4 - Behavioral 
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

entity Random4 is
    Port ( clk : in  STD_LOGIC;
			  column_out : out std_logic_vector (2 downto 0);
           random_0 : out  STD_LOGIC_VECTOR (2 downto 0);
           random_1 : out  STD_LOGIC_VECTOR (2 downto 0);
           random_2 : out  STD_LOGIC_VECTOR (2 downto 0);
           random_3 : out  STD_LOGIC_VECTOR (2 downto 0));
end Random4;

architecture Behavioral of Random4 is

	signal column : std_logic_vector (2 downto 0) := (others => '0');
	signal random_00 : std_logic_vector(23 downto 0) := (others => '0');
	signal random_01 : std_logic_vector(23 downto 0) := (others => '0');
	signal random_02 : std_logic_vector(23 downto 0) := (others => '0');
	signal random_03 : std_logic_vector(23 downto 0) := (others => '0');
	
	signal counter_0 : std_logic_vector(23 downto 0) := (others => '0');
	signal counter_1 : std_logic_vector(23 downto 0) := (others => '0');
	signal counter_2 : std_logic_vector(23 downto 0) := (others => '0');
	signal counter_3 : std_logic_vector(23 downto 0) := (others => '0');

	signal regis : std_logic_vector(7 downto 0) := (others => '0');

begin

	CounterProcess: process(clk)
	begin
		
		regis <= "00000000";
		
		if clk = '1' then		
			if counter_0 < "10011000100101101000000" then
				counter_0 <= counter_0 + 1;
			else
				counter_0 <= (others => '0');
				random_00 <= random_00 + 5;
				
				if column < "100" then 
					column <= column + 1;
				else
					column <= (others => '0');
				end if;
			end if;
			
			--regis(conv_integer(unsigned(random_00(23 downto 21)))) <= '1';
			
			if counter_1 < "1001100010010110100001" then
				counter_1 <= counter_1 + 1;
			else
				counter_1 <= (others => '0');
				random_01 <= random_01 + 19;
			end if;
			
			if counter_2 < "100110001001011010100" then
				counter_2 <= counter_2 + 1;
			else
				counter_2 <= (others => '0');
				random_02 <= random_02 + 51;
			end if;
			
			if counter_3 < "10011000100101101110" then
				counter_3 <= counter_3 + 1;
			else
				counter_3 <= (others => '0');
				random_03 <= random_03 + 71;
			end if;
		end if;
	end process;
	
	column_out <= column;
	random_0 <= random_00(23 downto 21);
	random_1 <= random_01(17 downto 15);
	random_2 <= random_02(11 downto 9);
	random_3 <= random_03(4 downto 2);

end Behavioral;

