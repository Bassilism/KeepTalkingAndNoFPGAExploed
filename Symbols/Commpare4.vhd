----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:15:33 12/12/2020 
-- Design Name: 
-- Module Name:    Commpare4 - Behavioral 
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

entity Commpare4 is
    Port ( num_0 : in  STD_LOGIC_VECTOR (2 downto 0);
           num_1 : in  STD_LOGIC_VECTOR (2 downto 0);
           num_2 : in  STD_LOGIC_VECTOR (2 downto 0);
           num_3 : in  STD_LOGIC_VECTOR (2 downto 0);
           min : out  STD_LOGIC_VECTOR (2 downto 0);
           min_2 : out  STD_LOGIC_VECTOR (2 downto 0);
           max_2 : out  STD_LOGIC_VECTOR (2 downto 0);
           max : out  STD_LOGIC_VECTOR (2 downto 0));
end Commpare4;

architecture Behavioral of Commpare4 is

begin


end Behavioral;

