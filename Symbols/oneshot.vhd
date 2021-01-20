----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:12:43 12/13/2020 
-- Design Name: 
-- Module Name:    oneshot - Behavioral 
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

entity oneshot is
	port (
			clk : in std_logic;
			input : in std_logic;
			output : out std_logic
		);
end oneshot;

architecture Behavioral of oneshot is

	signal out_1 : std_logic;
	signal out_2 : std_logic;
	
	signal temp : std_logic;

	component DFF
		port (
			D : in std_logic;
			CLK : in std_logic;
			Q : Buffer std_logic
		);
	end component;

begin

	A : DFF
		port map (
				D => input,
				CLK => clk,
				Q => out_1
		);
	
	B : DFF
		port map (
				D => out_1,
				CLK => clk,
				Q => out_2
		);
		
	temp <= out_1 and (not out_2);
	output  <= temp;

end Behavioral;

