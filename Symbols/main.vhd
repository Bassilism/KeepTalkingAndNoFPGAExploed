library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity main is
	port (	
				input : in std_logic;
				enable : in std_logic;
				reset : in std_logic;
				osc : in std_logic;
				
				-- Symbols
				switch : in std_logic_vector(3 downto 0);
				seg : out std_logic_vector(7 downto 0);
				common : out std_logic_vector(3 downto 0);
				correct : out std_logic_vector(3 downto 0);
				test : out std_logic_vector(3 downto 0);
				win_symbols : out std_logic;
				mistake : out std_logic;
				
				-- Memories
				button : in std_logic_vector(3 downto 0);
				sub_display : out std_logic_vector(7 downto 0);
				sub_common : out std_logic_vector(4 downto 0);
				step : out std_logic_vector(4 downto 0);
				display : out std_logic_vector(4 downto 0);
				win_memories : out std_logic
			);
end main;

architecture Behavioral of main is
	
	signal sym : std_logic;
	signal mem : std_logic;
	signal temp : std_logic_vector(3 downto 0);
	
	signal reg : std_logic_vector(4 downto 0);
	
	signal start : std_logic := '0';
	
	component Symbols_module
		port (	
				input : in std_logic;
				switch : in std_logic_vector(3 downto 0);
				reset_stage : in std_logic;
				osc : in std_logic;
				
				seg : out std_logic_vector(7 downto 0); 
				common : out std_logic_vector(3 downto 0);
				correct : out std_logic_vector(3 downto 0);
				win : out std_logic;
				mistake_out : out std_logic
			);
	end component;
	
	component Memories_module
		port (
				osc : in std_logic;
				reset_stage : in std_logic;
				enable : in std_logic;
				input : in std_logic_vector(3 downto 0);
				
				output : out std_logic_vector(4 downto 0);
				
				seg : out std_logic_vector(7 downto 0);
				common : out std_logic_vector(4 downto 0);
				
				step_display : out std_logic_vector(4 downto 0);
				
				win : out std_logic;
				mistake_out : out std_logic
			);
	end component;

begin	

	start <= input or enable;

	module_sym : Symbols_module
		port map (
				input => input,
				switch => switch,
				reset_stage => reset,
				osc => osc,
				seg => seg,
				common => common,
				correct => temp,
				win => win_symbols,
				mistake_out => sym
		);
		
	module_mem : Memories_module
		port map (
			osc => osc,
			reset_stage => reset,
			enable => input,
			input => button,
			
			output => step,
			
			seg => sub_display,
			common => sub_common,
			
			step_display => reg,
			
			win => win_memories,
			mistake_out => mem
		);
		
	mistake <= sym or mem;
	correct <= temp;
	test <= temp;
	
	display <= reg;
	step <= reg;

end Behavioral;

