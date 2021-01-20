----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:22:59 12/14/2020 
-- Design Name: 
-- Module Name:    stage_memory - Behavioral 
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

entity stage_memory is
	port (
			osc : in std_logic;
			reset : in std_logic;
			input : in std_logic_vector(3 downto 0);
			mode : in std_logic_vector(3 downto 0);
			
			next_out : out std_logic;
			step_out : out std_logic_vector(2 downto 0);
			
			numin_0 : in std_logic_vector(3 downto 0);
			numin_1 : in std_logic_vector(3 downto 0);
			numin_2 : in std_logic_vector(3 downto 0);
			numin_3 : in std_logic_vector(3 downto 0);
			numin_4 : in std_logic_vector(3 downto 0);
			
			win_out : out std_logic;
			mistake_out : out std_logic
	);
end stage_memory;

 architecture Behavioral of stage_memory is

	-- signal step : std_logic_vector(2 downto 0) := (others => '0');
	signal mistake : std_logic := '0';
	signal win : std_logic := '0';
	
	signal regis : std_logic := '0';
	signal step : std_logic_vector(2 downto 0) := (others => '0');
	
	signal num_0 : std_logic_vector(3 downto 0) := (others => '0');
	signal btn_0 : std_logic_vector(3 downto 0) := (others => '0');
	
	signal num_1 : std_logic_vector(3 downto 0) := (others => '0');
	signal btn_1 : std_logic_vector(3 downto 0) := (others => '0');
	
	signal num_2 : std_logic_vector(3 downto 0) := (others => '0');
	signal btn_2 : std_logic_vector(3 downto 0) := (others => '0');
	
	signal num_3 : std_logic_vector(3 downto 0) := (others => '0');
	signal btn_3 : std_logic_vector(3 downto 0) := (others => '0');
	
	signal num_4 : std_logic_vector(3 downto 0) := (others => '0');
	signal btn_4 : std_logic_vector(3 downto 0) := (others => '0');
	
	signal next_step : std_logic;
	signal c : std_logic_vector(23 downto 0) := (others => '0');

begin

	process (osc,input, reset)
	begin
	
		num_0 <= numin_0;
		num_1 <= numin_1;
		num_2 <= numin_2;
		num_3 <= numin_3;
		num_4 <= numin_4;
	
		if rising_edge(osc) then
		
			if next_step = '1' then
				if c < "111100011011110011101011" then
					c <= c + 1;
				else
					next_step <= '0';
					c <= (others => '0');
				end if;
			else
		
		
				if input = "0000" then 
					regis <= '0';
				end if;	
				
				if reset = '1' then
					num_0 <= (others => '0');
					btn_0 <= (others => '0');
					
					num_1 <= (others => '0');
					btn_1 <= (others => '0');
					
					num_2 <= (others => '0');
					btn_2 <= (others => '0');
					
					num_3 <= (others => '0');
					btn_3 <= (others => '0');
					
					num_4 <= (others => '0');
					btn_4 <= (others => '0');
					
					step <= (others => '0');
					mistake <= '0';
					win <= '0';
					
				elsif regis ='0' and input > "0000" then
				
					regis <= '1';
					mistake <= '0';
					next_step <= '1';
					
					--case step is
					-- step 1
						if step = "000" then
							
							-- case mode is
								-- when "0001" =>
								if mode = "0001" then
								
									if input = "0100" then
										mistake <= '0';
										step <= "001";
									else
										mistake <= '1';
									end if;
								
								-- when "0010" =>
								elsif mode = "0010" then
								
									if input = "0100" then
										mistake <= '0';
										step <= "001";
									else
										mistake <= '1';
									end if;
									
								-- when "0011" =>
								elsif mode = "0011"  then
								
									if input = "0010" then
										mistake <= '0';
										step <= "001";
									else
										mistake <= '1';
									end if;
									
								-- when "0100" =>
								elsif mode = "0100" then
								
									if input = "0001" then
										mistake <= '0';
										step <= "001";
									else
										mistake <= '1';
									end if;
									
								---when others => null;
							--end case;
								end if;
							
							btn_0 <= input;
						
					-- step 2
						elsif step = "001" then
						
								if mode = "0001" then
								
									if num_1 = "0100" then
										mistake <= '0';
										step <= "010";
									else
										mistake <= '1';
									end if;
									
								-- when "0010" =>
								elsif mode = "0010" then
								
									if input = btn_0 then
										mistake <= '0';
										step <= "010";
									else
										mistake <= '1';
									end if;
									
								-- when "0011" =>
								elsif mode = "0011" then
								
									if input = "1000" then
										mistake <= '0';
										step <= "010";
									else
										mistake <= '1';
									end if;
									
								-- when "0100" =>
								elsif mode = "0100" then
								
									if input = btn_0 then
										mistake <= '0';
										step <= "010";
									else
										mistake <= '1';
									end if;
									
								--when others => null;
							--end case;
								end if;
							
							btn_1 <= input;

					-- step 3
						elsif step = "010" then
						
							--case mode is
								---when "0001" =>
								if mode = "0001" then
								
									if num_2 = num_1 then
										mistake <= '0';
										step <= "011";
									else
										mistake <= '1';
									end if;
									
								-- when "0010" =>
								elsif mode = "0010" then
								
									if num_2 = num_0 then
										mistake <= '0';
										step <= "011";
									else
										mistake <= '1';
									end if;
									
								-- when "0011" =>
								elsif mode = "0011" then
								
									if input = "0010" then
										mistake <= '0';
										step <= "011";
									else
										mistake <= '1';
									end if;
									
								--when "0100" =>
								elsif mode = "0100" then
									if num_2 = "0100" then
										mistake <= '0';
										step <= "011";
									else
										mistake <= '1';
									end if;
									
								--when others => null;
							--end case;
								end if;
							
							btn_2 <= input;
						
					-- step 4
						elsif step = "011" then
						
							--case mode is
								--when "0001" =>
								if mode = "0001" then
								
									if input = btn_0 then
										mistake <= '0';
										step <= "100";
									else
										mistake <= '1';
									end if;
									
								--when "0010" =>
								elsif mode = "0010" then
								
									if input = "1000" then
										mistake <= '0';
										step <= "100";
									else
										mistake <= '1';
									end if;
									
								--when "0011" =>
								elsif mode = "0011" then
								
									if input = btn_1 then
										mistake <= '0';
										step <= "100";
									else
										mistake <= '1';
									end if;
									
								--when "0100" =>
								elsif mode = "0100" then
								
									if input = btn_1 then
										mistake <= '0';
										step <= "100";
									else
										mistake <= '1';
									end if;
									
								end if;
							
								--when others => null;
							--end case;
							
							btn_3 <= input;
							
					-- step 5
						elsif step = "100" then
						
							--case mode is
								--when "0001" =>
								if mode = "0001" then
								
									if num_4 = num_0 then
										mistake <= '0';
										step <= "101";
										win <= '1';
									else
										mistake <= '1';
									end if;
									
								--when "0010" =>
								elsif mode = "0010" then
								
									if num_4 = num_1 then
										mistake <= '0';
										step <= "101";
										win <= '1';
									else
										mistake <= '1';
									end if;
									
								--when "0011" =>
								elsif mode = "0011" then
								
									if num_4 = num_3 then
										mistake <= '0';
										step <= "101";
										win <= '1';
									else
										mistake <= '1';
									end if;
									
								--when "0100" =>
								elsif mode = "0100" then
								
									if num_4 = num_2 then
										mistake <= '0';
										step <= "101";
										win <= '1';
									else
										mistake <= '1';
									end if;
							
								end if;
								--when others => null;
							--end case;
							next_step <= '0'; 
							btn_4 <= input;
						elsif step = "101" then
							if reset = '1' then
								step <= "000";
							else
								step <= "101";
							end if;
							win <= '1';
					
					-- others
						-- when others => null;
					end if;
				end if;
			end if;
		end if;
	
	end process;
	
	next_out <= next_step;
	mistake_out <= mistake;
	step_out <= step;
	win_out <= win;

end Behavioral;

