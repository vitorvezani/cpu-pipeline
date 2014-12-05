LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.components.all;

ENTITY Registers IS
    GENERIC(N : INTEGER := 32);
    PORT (
     ReadRegister1              :IN STD_LOGIC_VECTOR(4 DOWNTO 0);
     ReadRegister2              :IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	 WriteRegister      	    :IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	 WriteData        			:IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	 RegWrite        			:IN STD_LOGIC;
	 Clock                      :IN STD_LOGIC;
	 ReadData1                  :OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	 ReadData2                  :OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
    );
END Registers;

ARCHITECTURE Behavior OF Registers IS
 SIGNAL Rout0,Rout1,Rout2,Rout3,Rout4,Rout5,Rout6,Rout7  :STD_LOGIC_VECTOR(31 DOWNTO 0);
 SIGNAL Rent0,Rent1,Rent2,Rent3,Rent4,Rent5,Rent6,Rent7  :STD_LOGIC_VECTOR(31 DOWNTO 0);
 
BEGIN
  Registrador00: Registrador0 PORT MAP (Rent0,RegWrite,Clock,Rout0);
  Registrador01: Registrador0 PORT MAP (Rent1,RegWrite,Clock,Rout1);
  Registrador02: Registrador0 PORT MAP (Rent2,RegWrite,Clock,Rout2);
  Registrador03: Registrador0 PORT MAP (Rent3,RegWrite,Clock,Rout3);
  Registrador04: Registrador0 PORT MAP (Rent4,RegWrite,Clock,Rout4);
  Registrador05: Registrador0 PORT MAP (Rent5,RegWrite,Clock,Rout5);
  Registrador06: Registrador0 PORT MAP (Rent6,RegWrite,Clock,Rout6);
  Registrador07: Registrador0 PORT MAP (Rent7,RegWrite,Clock,Rout7);
  
  PROCESS
  BEGIN
   WAIT UNTIL Clock'EVENT AND Clock = '1';
   IF RegWrite = '1' THEN
    CASE WriteRegister IS
     WHEN "00000" =>
      Rent0 <= WriteData;
     WHEN "00001" =>
      Rent1 <= WriteData;
     WHEN "00010" =>
      Rent2 <= WriteData;
     WHEN "00011" =>
      Rent3 <= WriteData;
     WHEN "00100" =>
      Rent4 <= WriteData;
     WHEN "00101" =>
      Rent5 <= WriteData;
     WHEN "00110" =>
      Rent6 <= WriteData;
     WHEN "00111" =>
      Rent7 <= WriteData;
     WHEN OTHERS =>
    END CASE ;
   END IF;
  END PROCESS;
  
  PROCESS(ReadRegister1,ReadRegister2,Rout0,Rout1,Rout2,Rout3,Rout4,Rout5,Rout6,Rout7)
  BEGIN
    CASE ReadRegister1 IS
     WHEN "00000" =>
      ReadData1 <= Rout0;
     WHEN "00001" =>
      ReadData1 <= Rout1;
     WHEN "00010" =>
      ReadData1 <= Rout2;
     WHEN "00011" =>
      ReadData1 <= Rout3;
     WHEN "00100" =>
      ReadData1 <= Rout4;
     WHEN "00101" =>
      ReadData1 <= Rout5;
     WHEN "00110" =>
      ReadData1 <= Rout6;
     WHEN "00111" =>
      ReadData1 <= Rout7;
     WHEN OTHERS =>
    END CASE ;
    
    CASE ReadRegister2 IS
     WHEN "00000" =>
      ReadData2 <= Rout0;
     WHEN "00001" =>
      ReadData2 <= Rout1;
     WHEN "00010" =>
      ReadData2 <= Rout2;
     WHEN "00011" =>
      ReadData2 <= Rout3;
     WHEN "00100" =>
      ReadData2 <= Rout4;
     WHEN "00101" =>
      ReadData2 <= Rout5;
     WHEN "00110" =>
      ReadData2 <= Rout6;
     WHEN "00111" =>
      ReadData2 <= Rout7;
     WHEN OTHERS =>
    END CASE ;
  END PROCESS;
END Behavior;