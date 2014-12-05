LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY Reg1b IS
	PORT(	R       :IN  STD_LOGIC;
			Rin		:IN  STD_LOGIC;
			Clock	:IN  STD_LOGIC;
	    	Q       :OUT STD_LOGIC
	);
END Reg1b;

ARCHITECTURE Behavior OF Reg1b IS
BEGIN
	PROCESS
	BEGIN
		WAIT UNTIL Clock'EVENT AND Clock = '0';
			IF(Rin = '1') THEN
				Q <= R;
			END IF;
	END PROCESS;
END Behavior;
