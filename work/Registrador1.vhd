LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY Registrador0 IS
	GENERIC(N : INTEGER := 32);
	PORT(	R       :IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			Rin 	:IN  STD_LOGIC;
			Clock	:IN  STD_LOGIC;
	     	Q       :OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
	);
END Registrador0;

ARCHITECTURE Behavior OF Registrador0 IS
BEGIN
	PROCESS
	BEGIN
		WAIT UNTIL Clock'EVENT AND Clock = '1';
			IF(Rin = '1') THEN
				Q <= R;
			END IF;
	END PROCESS;
END Behavior;