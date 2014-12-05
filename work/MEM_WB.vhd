LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.components.all;

ENTITY MEM_WB IS
    GENERIC(N : INTEGER := 32);
    PORT (
		WB				:IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		ReadData		:IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		ALUResult 		:IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		EndRTorRD		:IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		Clock           :IN STD_LOGIC;
		RegWrite		:OUT STD_LOGIC;
		MemToReg		:OUT STD_LOGIC;
		SaidaReadData	:OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		SaidaALUResult 	:OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		SaidaEndRTorRD	:OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
    	);
END MEM_WB;

ARCHITECTURE Behavior OF MEM_WB IS
BEGIN

			RegistradorMemToReg: reg1b PORT MAP (WB(1),'1',Clock , RegWrite);
			RegistradorPCSrc: reg1b PORT MAP (WB(0),'1',Clock, MemToReg);
			
			RegistradorReadData:  Registrador1 PORT MAP (ReadData,'1', Clock, SaidaReadData);
			RegistradorALUResult: Registrador1 PORT MAP (ALUResult,'1', Clock, SaidaALUResult);
			RegistradorEndRTorRD: Registrador1 GENERIC MAP (N => 5) PORT MAP (EndRTorRD,'1', Clock, SaidaEndRTorRD);

END Behavior;
