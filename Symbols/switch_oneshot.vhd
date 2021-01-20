----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:05:04 12/13/2020 
-- Design Name: 
-- Module Name:    switch_oneshot - Behavioral 
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

entity switch_oneshot is
    Port ( osc : in  STD_LOGIC;
           switch : in  STD_LOGIC_VECTOR (3 downto 0);
           output : out  STD_LOGIC_VECTOR (3 downto 0));
end switch_oneshot;

architecture Behavioral of switch_oneshot is

	signal clk : std_logic := '0';
	signal counter : std_logic_vector (23 downto 0) := (others => '0');
	
	component oneshot
	port (
			clk : in std_logic;
			input : in std_logic;
			output : out std_logic
		);
	end component;

begin

	process (osc)
	begin
	
		if rising_edge(osc) then
			if counter < "000011110100001001000000" then
				counter <= counter + 1;
			else
				counter <= (others => '0');
				clk <= not clk;
			end if;
		end if;
	
	end process;

	A : oneshot 
		port map (
			clk => clk,
			input => switch(0),
			output => output(0)
		);
		
	B : oneshot 
		port map (
			clk => clk,
			input => switch(1),
			output => output(1)
		);
		
	C : oneshot 
		port map (
			clk => clk,
			input => switch(2),
			output => output(2)
		);
		
	D : oneshot 
		port map (
			clk => clk,
			input => switch(3),
			output => output(3)
		);
	
end Behavioral;

