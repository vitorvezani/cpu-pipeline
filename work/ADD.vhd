LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.components.all;

ENTITY ADD IS
    GENERIC(N : INTEGER := 32);
    PORT (
   	 A,B         :IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
   	 ADDResult   :OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
    );
END ADD;

ARCHITECTURE Behavior OF ADD IS
BEGIN
	PROCESS(A,B)
	BEGIN

		ADDResult <= A + B;	

	END PROCESS;
END Behavior;
