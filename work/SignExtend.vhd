LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY SignExtend IS
    GENERIC(N : INTEGER := 16);
    PORT (
   	 A           :IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
   	 Aext      :OUT STD_LOGIC_VECTOR((N*2)-1 DOWNTO 0)
    );
END SignExtend;

ARCHITECTURE Behavior OF SignExtend IS
BEGIN
	PROCESS(A)
	BEGIN
	IF A(15)='0'THEN
		Aext (31 DOWNTO 16) <= "0000000000000000";
		Aext (15 DOWNTO 0) <= A;
	ELSIF A(15)='1'THEN
		Aext (31 DOWNTO 16) <= "1111111111111111";
		Aext (15 DOWNTO 0) <= A;
	END IF;
    END PROCESS;
END Behavior;
