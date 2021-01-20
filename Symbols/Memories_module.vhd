library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Memories_module is
	generic (N : integer := 16);
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
			
end Memories_module;

architecture Behavioral of Memories_module is

	-- Control
		signal reset : std_logic;
		signal mistake : std_logic := '0';
		signal rand : std_logic := '1';
		
		signal regis : std_logic := '0';
		
		signal win_temp : std_logic := '1';
		signal end_module : std_logic := '0';
		signal step : std_logic_vector(2 downto 0) := (others => '0');
		signal temp : std_logic := '0';
		signal c : std_logic_vector(23 downto 0) := (others => '0');
	--end control

	-- Random
		signal mode : std_logic_vector(3 downto 0) := "0001";
		signal counter : std_logic_vector(3 downto 0) := "0001";
		
		component mem_random
			port (
					  clk : in  STD_LOGIC;
					  enable : in std_logic;
					  reset : in std_logic;
					  
					  mode_out : out std_logic_vector (3 downto 0);
					  random_0 : out  STD_LOGIC_VECTOR (3 downto 0);
					  random_1 : out  STD_LOGIC_VECTOR (3 downto 0);
					  random_2 : out  STD_LOGIC_VECTOR (3 downto 0);
					  random_3 : out  STD_LOGIC_VECTOR (3 downto 0)
			);
		end component;
	--end random
	
	-- Switch one shot
		signal oneshot : std_logic_vector(3 downto 0);
		
		component switch_oneshot
			 Port ( osc : in  STD_LOGIC;
					  switch : in  STD_LOGIC_VECTOR (3 downto 0);
					  output : out  STD_LOGIC_VECTOR (3 downto 0));
		end component;
	-- end one shot
	
	-- Main
		
		component stage_memory
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
		end component;
		
		signal num_0,num0_tmp : std_logic_vector(3 downto 0) := (others => '0');
		signal num_1,num1_tmp : std_logic_vector(3 downto 0) := (others => '0');
		signal num_2,num2_tmp : std_logic_vector(3 downto 0) := (others => '0');
		signal num_3,num3_tmp : std_logic_vector(3 downto 0) := (others => '0');
		signal num_4,num4_tmp : std_logic_vector(3 downto 0) := (others => '0');
		
		
	-- end main
	
	-- Display
		signal digit_0 : std_logic_vector(3 downto 0);
		signal digit_1 : std_logic_vector(3 downto 0);
		signal digit_2 : std_logic_vector(3 downto 0);
		signal digit_3 : std_logic_vector(3 downto 0);
		
		component num_display
			 Port ( digit_0 : in  STD_LOGIC_VECTOR (N-1 downto 0);
					  digit_1 : in  STD_LOGIC_VECTOR (N-1 downto 0);
					  digit_2 : in  STD_LOGIC_VECTOR (N-1 downto 0);
					  digit_3 : in  STD_LOGIC_VECTOR (N-1 downto 0);
					  out_0 : out  STD_LOGIC_VECTOR (3 downto 0);
					  out_1 : out  STD_LOGIC_VECTOR (3 downto 0);
					  out_2 : out  STD_LOGIC_VECTOR (3 downto 0);
					  out_3 : out  STD_LOGIC_VECTOR (3 downto 0)
			);
		end component;
		
		signal seg_temp : std_logic_vector(7 downto 0);
		signal step_seg : std_logic_vector(7 downto 0);
	-- end display
	
	-- Common
		signal com : std_logic_vector(4 downto 0);
	
		component common_mem
			port (
				osc : std_logic;
				output : out std_logic_vector(4 downto 0)
			);
		end component;
	-- end common
	
	-- 7 segment
		signal input_num : std_logic_vector(3 downto 0);
		
		component BinaryToSevSeg
			Port ( input : in  STD_LOGIC_VECTOR (3 downto 0);
					  output : out  STD_LOGIC_VECTOR (7 downto 0)
			);
		end component;
	-- end
	
	-- Others
		component AND2
			port ( I0 : in std_logic;
					 I1 : in std_logic;
					 O : out std_logic
					);
		end component;
		
		component VCC
			port ( P : out std_logic);
		end component;
		
		component GND
			port ( P : out	std_logic);
		end component;
		
		component INV
			port ( I : in    std_logic; 
					 O : out   std_logic);
		end component;
	-- end others

begin
	
	-- Stage
			rand <= 	'1' when reset_stage = '1' else
						'0' when enable = '1';
						
			win_temp <= '0' when reset_stage = '1'else
							'1' when end_module = '1';
	-- end stage

	-- Reset
		reset <= reset_stage or mistake;
	-- end reset
	
	-- Input button
		AAA : switch_oneshot
			 Port map( 
					osc => osc,
					switch => input,
					output => oneshot
			);
			
	-- end input
	
	-- Main
	
		rnd : mem_random
			port map(
					  clk => osc,
					  enable => (rand or temp) and not win_temp,
					  reset => reset,
					  
					  mode_out => mode,
					  random_0 => digit_0,
					  random_1 => digit_1,
					  random_2 => digit_2,
					  random_3 => digit_3
			);
			
		process (step)
		begin
			
			case step is
				-- step 1
					when "000" =>
						
						case oneshot is
							when "0100" => num0_tmp <= digit_2;
							when "0010" => num0_tmp  <= digit_1;
							when "0001" => num0_tmp <= digit_0;
							when others => null;
						end case;
					
				-- step 2
					when "001" =>
				
						case oneshot is
							when "1000" => num1_tmp  <= digit_3;
							when "0100" => num1_tmp <= digit_2;
							when "0010" => num1_tmp <= digit_1;
							when "0001" => num1_tmp <= digit_0;
							when others => null;
						end case;

				-- step 3
					when "010" =>
				
						case oneshot is
							when "1000" => num2_tmp <= digit_3;
							when "0100" => num2_tmp <= digit_2;
							when "0010" => num2_tmp <= digit_1;
							when "0001" => num2_tmp <= digit_0;
							when others => null;
						end case;
					
				-- step 4
					when "011" =>
				
						case oneshot is
							when "1000" => num3_tmp <= digit_3;
							when "0100" => num3_tmp <= digit_2;
							when "0010" => num3_tmp <= digit_1;
							when "0001" => num3_tmp <= digit_0;
							when others => null;
						end case;
						
				-- step 5
					when "100" =>
				
						case oneshot is
							when "1000" => num4_tmp <= digit_3;
							when "0100" => num4_tmp <= digit_2;
							when "0010" => num4_tmp  <= digit_1;
							when "0001" => num4_tmp <= digit_0;
							when others => null;
						end case;
				
				-- others
					when others => null;
						
				end case;
		end process;
		
		num_0 <= num0_tmp;
		num_1 <= num1_tmp;
		num_2 <= num2_tmp;
		num_3 <= num3_tmp;
		num_4 <= num4_tmp;
	
		s_mem : stage_memory
			port map(
					osc => osc,
					reset => reset,
					input => oneshot,
					mode => mode,
					
					next_out => temp,
					step_out => step,
					
					numin_0 => num_0,
					numin_1 => num_1,
					numin_2 => num_2,
					numin_3 => num_3,
					numin_4 => num_4,
					win_out => end_module,
					mistake_out => mistake
			);
	
	-- end main
	
	-- Num Display and common
		cmmn : common_mem
			port map(	osc => osc,
							output(4 downto 0) => com
						);
		
		CommonProcess: process(com)
		begin
			
			case com is
				when "11110" => input_num <= digit_0;
				when "11101" => input_num <= digit_1;
				when "11011" => input_num <= digit_2;
				when "10111" => input_num <= digit_3;
				when "01111" => input_num <= mode;
				when others => null;
			end case;
		end process;

		-- 7 segmaent
		BBB : BinaryToSevSeg
			port map (
				input => input_num,
				output => step_seg
			);
		seg <= not step_seg;
			
		-- common
		common <= not com;
		
	-- end display

	-- Step	
		process (step)
		begin
		
			case step is
				when "000" => step_display <= "00001";
				when "001" => step_display <= "00011";
				when "010" => step_display <= "00111";
				when "011" => step_display <= "01111";
				when "100" => step_display <= "11111";
				when "101" => step_display <= "11111";
				when others => null;
			end case;
		
		end process;
	
	-- end step
	
	-- OUTPUT
		win <= end_module;
		mistake_out <= mistake;

end Behavioral;