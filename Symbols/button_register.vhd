----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:42:38 12/12/2020 
-- Design Name: 
-- Module Name:    button_register - Behavioral 
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

entity button_register is
    Port ( 
			clk: in std_logic;
			button : in  STD_LOGIC_VECTOR (3 downto 0);
			reset : in std_logic;
         counter : out  STD_LOGIC_VECTOR (3 downto 0);
			regis : out std_logic_vector (3 downto 0);
         output : out  STD_LOGIC_VECTOR (3 downto 0)
	);
end button_register;

architecture Behavioral of button_register is

	signal regis_out : std_logic_vector(3 downto 0) := (others => '0');
	signal count : std_logic_vector(3 downto 0) := (others => '0');
	
	signal select_out : std_logic_vector(3 downto 0) := (others => '0');
	
begin

	process (button)
	begin
		if(rising_edge(clk)) then
			if reset = '1' then
				regis_out <= (others => '0');
				count <= (others => '0');
				select_out <= (others => '0');
			else
				if button(0) = '1' then
					if regis_out(0) = '0' then
						regis_out(0) <= '1';
						count <= count + '1';
						select_out <= "0001";
					end if;
				end if;
				
				if button(1) = '1' then
					if regis_out(1) = '0' then
						regis_out(1) <= '1';
						count <= count + '1';
						select_out <= "0010";
					end if;
				end if;
				
				if button(2) = '1' then
					if regis_out(2) = '0' then
						regis_out(2) <= '1';
						count <= count + '1';
						select_out <= "0100";
					end if;
				end if;
				
				if button(3) = '1' then
					if regis_out(3) = '0' then
						regis_out(3) <= '1';
						count <= count + '1';
						select_out <= "1000";
					end if;
				end if;
			end if;
		end if;
		
	end process;
	
	regis <= regis_out;
	counter <= count;
	output <= select_out;

end Behavioral;

