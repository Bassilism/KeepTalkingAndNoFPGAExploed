----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:11:42 12/12/2020 
-- Design Name: 
-- Module Name:    Compare_symbols - Behavioral 
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

entity Compare_symbols is
    Port ( 
			  clk : in std_logic;
			  reset : in std_logic;
			  counter : in  STD_LOGIC_VECTOR (2 downto 0);
           button : in  STD_LOGIC_VECTOR (3 downto 0);
           digit_0 : in  STD_LOGIC_VECTOR (2 downto 0);
           digit_1 : in  STD_LOGIC_VECTOR (2 downto 0);
           digit_2 : in  STD_LOGIC_VECTOR (2 downto 0);
           digit_3 : in  STD_LOGIC_VECTOR (2 downto 0);
           first : in  STD_LOGIC_VECTOR (2 downto 0);
           second : in  STD_LOGIC_VECTOR (2 downto 0);
           third : in  STD_LOGIC_VECTOR (2 downto 0);
           fourth : in  STD_LOGIC_VECTOR (2 downto 0);
			  correct : out std_logic_vector (3 downto 0);
			  s_out : out std_logic_vector (2 downto 0);
			  l_out : out std_logic_vector (2 downto 0);
           output : out  STD_LOGIC);
end Compare_symbols;

architecture Behavioral of Compare_symbols is

	signal sym_out : std_logic_vector ( 2 downto 0 );
	signal list_out : std_logic_vector ( 2 downto 0 );
	signal correct_counter : std_logic_vector ( 3 downto 0) := ( others => '0');
	
	signal is_equal : std_logic := '1';
	
	signal c : std_logic_vector(23 downto 0) := (others => '0');
	
	component select_symbols
		port (
					button : in  STD_LOGIC_VECTOR (3 downto 0);
					digit_0 : in std_logic_vector (2 downto 0);
					digit_1 : in std_logic_vector (2 downto 0);
					digit_2 : in std_logic_vector (2 downto 0);
					digit_3 : in std_logic_vector (2 downto 0);
					output : out std_logic_vector (2 downto 0)
				);
	end component;
	
	component select_minmax
		port (
					counter : in  STD_LOGIC_VECTOR (2 downto 0);
					digit_0 : in std_logic_vector (2 downto 0);
					digit_1 : in std_logic_vector (2 downto 0);
					digit_2 : in std_logic_vector (2 downto 0);
					digit_3 : in std_logic_vector (2 downto 0);
					output : out std_logic_vector (2 downto 0)
				);
	end component;
	
begin

	sym : select_symbols
		port map(
			button => button,
			digit_0 => digit_0,
			digit_1 => digit_1,
			digit_2 => digit_2,
			digit_3 => digit_3,
			output => sym_out
		);

	lst : select_minmax
		port map(
			counter => counter,
			digit_0 => first,
			digit_1 => second,
			digit_2 => third,
			digit_3 => fourth,
			output => list_out
		);
		
	SymbolPrecess : process(sym_out, list_out, reset)
	begin
		
		if rising_edge(clk) then
			if reset = '1' then
				if c < "111111111111111111111111" then
					c <= c + 1;
					correct_counter <= (others => '0');
				else
					is_equal <= '1';
					c <= (others => '0');
				end if;
			else
				if sym_out = list_out then
					correct_counter <= correct_counter xor button;
				else
					is_equal <= '0';
				end if;
			end if;
		end if;
		
	end process;

	s_out <= sym_out;
	l_out <= list_out;
	correct <= correct_counter;
	output <= not is_equal;

end Behavioral;

