LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.components.all;


ENTITY EX_MEM IS
	GENERIC ( N : INTEGER := 32 ) ;
	PORT (	
			WB			:IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			M			:IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			ADDResult 	:IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			Zero		:IN STD_LOGIC;
			ALUResult 	:IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			RT			:IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			EndRTorRD	:IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			Clock 		:IN STD_LOGIC;
			SaidaWB		:OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			Branch		:OUT STD_LOGIC;
			MemRead		:OUT STD_LOGIC;
			MemWrite	:OUT STD_LOGIC;
			SaidaADDResult 	:OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			SaidaZero	:OUT STD_LOGIC;
			SaidaALUResult 	:OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			SaidaRT		:OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			SaidaEndRTorRD	:OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END EX_MEM ;

ARCHITECTURE Behavior OF EX_MEM IS
BEGIN
			RegistradorWB: Registrador1 GENERIC MAP (N => 2) PORT MAP (WB,'1', Clock, SaidaWB);
			
			RegistradorBranch: reg1b PORT MAP (M(2),'1', Clock, Branch);
			RegistradorMemRead: reg1b PORT MAP (M(1),'1', Clock, MemRead);
			RegistradorMemWrite: reg1b PORT MAP (M(0),'1', Clock, MemWrite);

			RegistradorADDResult: Registrador1 PORT MAP (ADDResult,'1', Clock, SaidaADDResult);
			RegistradorZero: reg1b PORT MAP (Zero,'1', Clock, SaidaZero);
			RegistradorALUResult: Registrador1 PORT MAP (ALUResult,'1', Clock, SaidaALUResult);
			RegistradorRT: Registrador1 PORT MAP (RT,'1',Clock, SaidaRT);
			RegistradorEndRTorRD: Registrador1 GENERIC MAP (N => 5) PORT MAP (EndRTorRD,'1', Clock, SaidaEndRTorRD);

END Behavior;
