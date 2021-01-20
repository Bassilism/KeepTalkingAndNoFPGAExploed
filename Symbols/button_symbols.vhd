----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:28:00 12/12/2020 
-- Design Name: 
-- Module Name:    button_symbols - Behavioral 
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

entity button_symbols is
    Port ( 
				button : in  STD_LOGIC_VECTOR (3 downto 0);
				digit_0 : in std_logic_vector (2 downto 0);
				digit_1 : in std_logic_vector (2 downto 0);
				digit_2 : in std_logic_vector (2 downto 0);
				digit_3 : in std_logic_vector (2 downto 0);
				output : out std_logic_vector (2 downto 0)
			);
end button_symbols;

architecture Behavioral of button_symbols is

begin


end Behavioral;

