----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:53:02 12/16/2020 
-- Design Name: 
-- Module Name:    Compare8 - Behavioral 
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


entity Compare8 is
	generic (N : integer := 24);
	port (
			
				num_0 : in  STD_LOGIC_VECTOR (N-1 downto 0);
				num_1 : in  STD_LOGIC_VECTOR (N-1 downto 0);
				num_2 : in  STD_LOGIC_VECTOR (N-1 downto 0);
				num_3 : in  STD_LOGIC_VECTOR (N-1 downto 0);
				num_4 : in  STD_LOGIC_VECTOR (N-1 downto 0);
				num_5 : in  STD_LOGIC_VECTOR (N-1 downto 0);
				num_6 : in  STD_LOGIC_VECTOR (N-1 downto 0);
				num_7 : in  STD_LOGIC_VECTOR (N-1 downto 0);
				
				first 	: out  STD_LOGIC_VECTOR (N-1 downto 0);
				second 	: out  STD_LOGIC_VECTOR (N-1 downto 0);
				third 	: out  STD_LOGIC_VECTOR (N-1 downto 0);
				fourth 	: out  STD_LOGIC_VECTOR (N-1 downto 0);
				fifth 	: out  STD_LOGIC_VECTOR (N-1 downto 0);
				sixth 	: out  STD_LOGIC_VECTOR (N-1 downto 0);
				seventh 	: out  STD_LOGIC_VECTOR (N-1 downto 0);
				eighth 	: out  STD_LOGIC_VECTOR (N-1 downto 0)
		);
end Compare8;

architecture Behavioral of Compare8 is

	component Compare4_24Bits is
    Port ( num_0 : in  STD_LOGIC_VECTOR (N-1 downto 0);
           num_1 : in  STD_LOGIC_VECTOR (N-1 downto 0);
           num_2 : in  STD_LOGIC_VECTOR (N-1 downto 0);
           num_3 : in  STD_LOGIC_VECTOR (N-1 downto 0);
           min : out  STD_LOGIC_VECTOR (N-1 downto 0);
           min_0 : out  STD_LOGIC_VECTOR (N-1 downto 0);
           max_0 : out  STD_LOGIC_VECTOR (N-1 downto 0);
           max : out  STD_LOGIC_VECTOR (N-1 downto 0));
	end component;
	
	signal AA0 : std_logic_vector(N-1 downto 0) := (others => '0');
	signal AA1 : std_logic_vector(N-1 downto 0) := (others => '0');
	signal AA2 : std_logic_vector(N-1 downto 0) := (others => '0');
	signal AA3 : std_logic_vector(N-1 downto 0) := (others => '0');

	signal BB0 : std_logic_vector(N-1 downto 0) := (others => '0');
	signal BB1 : std_logic_vector(N-1 downto 0) := (others => '0');
	signal BB2 : std_logic_vector(N-1 downto 0) := (others => '0');
	signal BB3 : std_logic_vector(N-1 downto 0) := (others => '0');

	signal CC0 : std_logic_vector(N-1 downto 0) := (others => '0');
	signal CC1 : std_logic_vector(N-1 downto 0) := (others => '0');
	signal CC2 : std_logic_vector(N-1 downto 0) := (others => '0');
	signal CC3 : std_logic_vector(N-1 downto 0) := (others => '0');

	signal DD0 : std_logic_vector(N-1 downto 0) := (others => '0');
	signal DD1 : std_logic_vector(N-1 downto 0) := (others => '0');
	signal DD2 : std_logic_vector(N-1 downto 0) := (others => '0');
	signal DD3 : std_logic_vector(N-1 downto 0) := (others => '0');

	signal EE0 : std_logic_vector(N-1 downto 0) := (others => '0');
	signal EE1 : std_logic_vector(N-1 downto 0) := (others => '0');
	signal EE2 : std_logic_vector(N-1 downto 0) := (others => '0');
	signal EE3 : std_logic_vector(N-1 downto 0) := (others => '0');
	
begin

	AA : Compare4_24Bits
		port map (
		
			num_0 => num_0,
			num_1 => num_1,
			num_2 => num_2,
			num_3 => num_3,
			
			min => AA0,
			min_0 => AA1,
			max_0 => AA2,
			max => AA3
		
		);
		
	BB : Compare4_24Bits
		port map (
		
			num_0 => num_4,
			num_1 => num_5,
			num_2 => num_6,
			num_3 => num_7,
			
			min => BB0,
			min_0 => BB1,
			max_0 => BB2,
			max => BB3
		
		);
		
	-- max from two compare
	CC : Compare4_24Bits
		port map (
		
			num_0 => AA3,
			num_1 => AA2,
			num_2 => BB3,
			num_3 => BB2,
			
			min => CC0,
			min_0 => CC1,
			max_0 => CC2,
			max => CC3
		
		);
		
	-- min from two compare
	DD : Compare4_24Bits
		port map (
		
			num_0 => AA1,
			num_1 => AA0,
			num_2 => BB1,
			num_3 => BB0,
			
			min => DD0,
			min_0 => DD1,
			max_0 => DD2,
			max => DD3
		
		);
		
	-- half 
	EE : Compare4_24Bits
		port map (
		
			num_0 => CC0,
			num_1 => CC1,
			num_2 => DD2,
			num_3 => DD3,
			
			min => EE0,
			min_0 => EE1,
			max_0 => EE2,
			max => EE3
		
		);
		
	first 	<= DD0;
	second	<= DD1;
	third		<= EE0;
	fourth	<= EE1;
	fifth		<= EE2;
	sixth		<= EE3;
	seventh	<= CC2;
	eighth	<= CC3;


end Behavioral;

