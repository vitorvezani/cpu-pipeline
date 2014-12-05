LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.components.all;

ENTITY ALU IS
    GENERIC(N : INTEGER := 32);
    PORT (
   	 A,B         :IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	 ALUControl  :IN STD_LOGIC_VECTOR(2 DOWNTO 0);
   	 ALUResult   :OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	 Zero        :OUT STD_LOGIC
    );
END ALU;

ARCHITECTURE Behavior OF ALU IS
BEGIN
	PROCESS(A,B,ALUControl)
	BEGIN
		IF ALUControl = "010" THEN
			ALUResult <= A + B;
		ELSIF ALUControl = "110" THEN
			ALUResult <= A - B;
			IF A - B = "00000000000000000000000000000000" THEN
				Zero <= '1';
			ELSE
				Zero <= '0';
			END IF; 
		ELSIF ALUControl = "000" THEN
			ALUResult <= A and B;
		ELSIF ALUControl = "001" THEN
			ALUResult <= A or B;
		END IF;
	END PROCESS;
END Behavior;
