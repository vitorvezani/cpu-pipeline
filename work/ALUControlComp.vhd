LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.components.all;

ENTITY ALUControlComp IS
    PORT (
   	 ALUOp       :IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	 FunctionOP  :IN STD_LOGIC_VECTOR(5 DOWNTO 0);
   	 ALUControl  :OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END ALUControlComp;

ARCHITECTURE Behavior OF ALUControlComp IS
BEGIN
	PROCESS(FunctionOP,ALUOp)
	BEGIN
			IF ALUOp = "000" THEN --soma lw, sw, addi
				ALUControl <= "010";
			ELSIF ALUOp = "001" THEN --sub beq, subi
				ALUControl <= "110";
			ELSIF ALUOp = "011" THEN --andi
				ALUControl <= "000";
			ELSIF ALUOp = "100" THEN --ori
				ALUControl <= "001";
			ELSIF ALUOp = "010" THEN --r-type
				IF FunctionOP = "100000" THEN --soma
					ALUControl <= "010";
				ELSIF FunctionOP = "100010" THEN --sub
					ALUControl <= "110";
				ELSIF FunctionOP = "100100" THEN --and
					ALUControl <= "000";
				ELSIF FunctionOP = "100101" THEN --or
					ALUControl <= "001";
				END IF;
			END IF;
	END PROCESS;
END Behavior;
