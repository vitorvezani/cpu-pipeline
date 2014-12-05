LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.components.all;


ENTITY DataMemory IS
	GENERIC(N : INTEGER := 32);
	PORT(
		Address 	    :IN STD_LOGIC_VECTOR (N-1 DOWNTO 0);
		WriteData	    :IN STD_LOGIC_VECTOR (N-1 DOWNTO 0);
		MemWrite		:IN STD_LOGIC;
		MemRead			:IN STD_LOGIC;
		Clock			:IN STD_LOGIC;	
		ReadData		:OUT STD_LOGIC_VECTOR (N-1 DOWNTO 0)
		);
END DataMemory;

ARCHITECTURE Behavior OF DataMemory IS
 SIGNAL M0,M1,M2,M3,M4,M5,M6,M7 :STD_LOGIC_VECTOR(31 DOWNTO 0);
 SIGNAL Rent0,Rent1,Rent2,Rent3,Rent4,Rent5,Rent6,Rent7  :STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN

  Memoria0: Registrador0 PORT MAP (Rent0,MemWrite,Clock,M0);
  Memoria1: Registrador0 PORT MAP (Rent1,MemWrite,Clock,M1);
  Memoria2: Registrador0 PORT MAP (Rent2,MemWrite,Clock,M2);
  Memoria3: Registrador0 PORT MAP (Rent3,MemWrite,Clock,M3);
  Memoria4: Registrador0 PORT MAP (Rent4,MemWrite,Clock,M4);
  Memoria5: Registrador0 PORT MAP (Rent5,MemWrite,Clock,M5);
  Memoria6: Registrador0 PORT MAP (Rent6,MemWrite,Clock,M6);
  Memoria7: Registrador0 PORT MAP (Rent7,MemWrite,Clock,M7);
 
 PROCESS(Address,WriteData,MemWrite,MemRead)
 BEGIN
  IF MemRead = '1' THEN
	   IF Address = "00000000000000000000000000000000" THEN
		ReadData <= M0;
		   ELSIF Address = "00000000000000000000000000000001" THEN
			ReadData <= M1;
		   ELSIF Address = "00000000000000000000000000000010" THEN
			ReadData <= M2;
		   ELSIF Address = "00000000000000000000000000000011" THEN
			ReadData <= M3;
		   ELSIF Address = "00000000000000000000000000000100" THEN
			ReadData <= M4;
		   ELSIF Address = "00000000000000000000000000000101" THEN
			ReadData <= M5;
		   ELSIF Address = "00000000000000000000000000000110" THEN
			ReadData <= M6;
		   ELSIF Address = "00000000000000000000000000000111" THEN
			ReadData <= M7;
	   END IF;
  ELSIF MemRead = '0' THEN
		IF Address = "00000000000000000000000000000000" THEN
		 Rent0 <= WriteData;
			ELSIF Address = "00000000000000000000000000000001" THEN
			 Rent1 <= WriteData;
			ELSIF Address = "00000000000000000000000000000010" THEN
			 Rent2 <= WriteData;
			ELSIF Address = "00000000000000000000000000000011" THEN
			 Rent3 <= WriteData;
			ELSIF Address = "00000000000000000000000000000100" THEN
			 Rent4 <= WriteData;
			ELSIF Address = "00000000000000000000000000000101" THEN
			 Rent5 <= WriteData;
			ELSIF Address = "00000000000000000000000000000110" THEN
			 Rent6 <= WriteData;
			ELSIF Address = "00000000000000000000000000000111" THEN
			 Rent7 <= WriteData;
		END IF;
   END IF; 
 END PROCESS;
END Behavior;