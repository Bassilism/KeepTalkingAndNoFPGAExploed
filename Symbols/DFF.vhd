library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DFF is
	Port (
			D : in std_logic;
			CLK : in std_logic;
			Q : Buffer std_logic
	);
end DFF;

architecture Behavioral of DFF is

begin

	PROCESS (clk)
	BEGIN
	
		IF rising_edge(CLK) THEN
			Q <= D;
		ELSE
			Q <= Q;
		END IF;
	END PROCESS;
	
end Behavioral;