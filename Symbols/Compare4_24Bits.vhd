----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:35:44 12/12/2020 
-- Design Name: 
-- Module Name:    Compare4 - Behavioral 
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

entity Compare4_24Bits is
	generic (N : integer := 24);
    Port ( num_0 : in  STD_LOGIC_VECTOR (N-1 downto 0);
           num_1 : in  STD_LOGIC_VECTOR (N-1 downto 0);
           num_2 : in  STD_LOGIC_VECTOR (N-1 downto 0);
           num_3 : in  STD_LOGIC_VECTOR (N-1 downto 0);
           min : out  STD_LOGIC_VECTOR (N-1 downto 0);
           min_0 : out  STD_LOGIC_VECTOR (N-1 downto 0);
           max_0 : out  STD_LOGIC_VECTOR (N-1 downto 0);
           max : out  STD_LOGIC_VECTOR (N-1 downto 0));
end Compare4_24Bits;

architecture Behavioral of Compare4_24Bits is

	signal min_1 : std_logic_vector(N-1 downto 0);
	signal min_2 : std_logic_vector(N-1 downto 0);
	signal min_3 : std_logic_vector(N-1 downto 0);
	signal min_4 : std_logic_vector(N-1 downto 0);
	signal min_5 : std_logic_vector(N-1 downto 0);
	signal max_1 : std_logic_vector(N-1 downto 0);
	signal max_2 : std_logic_vector(N-1 downto 0);
	signal max_3 : std_logic_vector(N-1 downto 0);
	signal max_4 : std_logic_vector(N-1 downto 0);
	signal max_5 : std_logic_vector(N-1 downto 0);

	component Compare2_24Bits
		port (	
			A : in std_logic_vector (N-1 downto 0);-- first number
			B : in std_logic_vector (N-1 downto 0);-- Second number
			Max : out std_logic_vector (N-1 downto 0);-- Larger number
			Min : out std_logic_vector (N-1 downto 0)-- Smaller number
		);
	end component;
	
begin

	A : Compare2_24Bits
		port map (
			A => num_0,
			B => num_1,
			Max => max_1,
			Min => min_1
		);
		
	B : Compare2_24Bits
		port map (
			A => num_2,
			B => num_3,
			Max => max_2,
			Min => min_2
		);
		
	C : Compare2_24Bits
		port map (
			A => max_1,
			B => max_2,
			Max => max_3,
			Min => min_3
		);
		
	D : Compare2_24Bits
		port map (
			A => min_1,
			B => min_2,
			Max => max_4,
			Min => min_4
		);
		
	E : Compare2_24Bits
		port map (
			A => min_3,
			B => max_4,
			Max => max_5,
			Min => min_5
		);
		
	min <= min_4;
	min_0 <= min_5;
	
	max <= max_3;
	max_0 <= max_5;


end Behavioral;