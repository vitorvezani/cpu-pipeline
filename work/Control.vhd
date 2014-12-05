LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.components.all;


ENTITY Control IS
    PORT (
   	 OPCode      :IN STD_LOGIC_VECTOR(5 DOWNTO 0);
	 WB          :OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	 M           :OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
   	 EX          :OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
    );
END Control;

ARCHITECTURE Behavior OF Control IS
BEGIN
	PROCESS(OPCode)
	BEGIN
		IF OPCode = "000000" THEN --TIPO R FEITO
			WB   <= "10";
			M   <= "000";
			EX <= "10100";

		ELSIF OPCode = "000010" THEN --ADDI FEITO
			WB   <= "10";
			M   <= "000";
			EX <= "00001";

		ELSIF OPCode = "000011" THEN --SUBI FEITO
			WB   <= "10";
			M   <= "000";
			EX <= "00011";

		ELSIF OPCode = "000100" THEN --LW FEITO
			WB   <= "11";
			M   <= "010";
			EX <= "00001";

		ELSIF OPCode = "000101" THEN --SW FEITO
			WB   <= "0-";
			M   <= "001";
			EX <= "-0001";

		ELSIF OPCode = "000111" THEN --ANDI FEITO
			WB   <= "10";
			M   <= "000";
			EX <= "00111";

		ELSIF OPCode = "001001" THEN --ORI FEITO
			WB   <= "10";
			M   <= "000";
			EX <= "01001";

		ELSIF OPCode = "001010" THEN --BEQ FEITO
			WB   <= "0-";
			M   <= "100";
			EX <= "-0010";

		ELSIF OPCode = "001011" THEN --J
			WB   <= "00";
			M   <= "000";
			EX <= "00000";

		ELSIF OPCode = "001100" THEN --JR
			WB   <= "00";
			M   <= "000";
			EX <= "00000";
		ELSIF OPCode = "001101" THEN --NOP
			WB   <= "00";
			M   <= "000";
			EX <= "00000";
		END IF;
	END PROCESS;
END Behavior;
