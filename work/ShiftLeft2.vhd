LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

ENTITY ShiftLeft2 IS
    GENERIC(N : INTEGER := 32);
    PORT (
	 A 	          :IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
     Aext	      :OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
    );
END ShiftLeft2;

ARCHITECTURE Behavior OF ShiftLeft2 IS
BEGIN
 PROCESS(A)
 BEGIN
	FOR i IN 0 TO 29 LOOP
		Aext(i+2) <= A(i);
	END LOOP;
  Aext(1) <= '0';
  Aext(0) <= '0';
 END PROCESS;
END Behavior;