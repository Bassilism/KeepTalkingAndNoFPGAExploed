----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:54:01 12/14/2020 
-- Design Name: 
-- Module Name:    num_display - Behavioral 
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

entity num_display is
	generic (N : integer := 16);
    Port ( digit_0 : in  STD_LOGIC_VECTOR (N-1 downto 0);
           digit_1 : in  STD_LOGIC_VECTOR (N-1 downto 0);
           digit_2 : in  STD_LOGIC_VECTOR (N-1 downto 0);
           digit_3 : in  STD_LOGIC_VECTOR (N-1 downto 0);
           out_0 : out  STD_LOGIC_VECTOR (3 downto 0);
           out_1 : out  STD_LOGIC_VECTOR (3 downto 0);
           out_2 : out  STD_LOGIC_VECTOR (3 downto 0);
           out_3 : out  STD_LOGIC_VECTOR (3 downto 0)
	);
end num_display;

architecture Behavioral of num_display is
	
	-- compare		
		component mem_random
			port (
					  clk : in  STD_LOGIC;
					  enable : in std_logic;
					  reset : in std_logic;
					  
					  mode_out : out std_logic_vector (2 downto 0);
					  random_0 : out  STD_LOGIC_VECTOR (2 downto 0);
					  random_1 : out  STD_LOGIC_VECTOR (2 downto 0);
					  random_2 : out  STD_LOGIC_VECTOR (2 downto 0);
					  random_3 : out  STD_LOGIC_VECTOR (2 downto 0)
			);
		end component;
		
	-- end compare 

begin

	-- Compare
		comp : Compare4_16bits
		port map (
			num_0 => digit_0,		num_1 => digit_1,
			num_2 => digit_2,		num_3 => digit_3,
			min => first,			min_0 => second,
			max_0 => third,		max => fourth
		);
	-- end compare
	
	process
	begin
	
		if digit_0 = first then
			out_0 <= "0001";
		elsif digit_0 = second then
			out_0 <= "0010";
		elsif digit_0 = third then
			out_0 <= "0011";
		else
			out_0 <= "0100";
		end if;
		
		if digit_1 = first then
			out_1 <= "0001";
		elsif digit_1 = second then
			out_1 <= "0010";
		elsif digit_1 = third then
			out_1 <= "0011";
		else
			out_1 <= "0100";
		end if;
		
		if digit_2 = first then
			out_2 <= "0001";
		elsif digit_2 = second then
			out_2 <= "0010";
		elsif digit_2 = third then
			out_2 <= "0011";
		else
			out_2 <= "0100";
		end if;
		
		if digit_3 = first then
			out_3 <= "0001";
		elsif digit_3 = second then
			out_3 <= "0010";
		elsif digit_3 = third then
			out_3 <= "0011";
		else
			out_3 <= "0100";
		end if;
	
	end process;

end Behavioral;