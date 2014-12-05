LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.components.all;

ENTITY ID_EX IS
    GENERIC(N : INTEGER := 32);
    PORT (
		WB                         :IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	 	M                          :IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	 	EX                         :IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	 	EndProxInst                :IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
   	 	RS   					   :IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
   	 	RT                         :IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	 	Extendido                  :IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	 	EndRT					   :IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	 	EndRD                      :IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	 	Clock                      :IN STD_LOGIC;
		SaidaWB                    :OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	 	SaidaM                     :OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		RegDst			   		   :OUT STD_LOGIC;
		AluOp			   	       :OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		AluSrc	          	       :OUT STD_LOGIC;
	 	SaidaProxInst              :OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
   	 	SaidaRS				   	   :OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		SaidaRT          		   :OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);  
	 	SaidaExtendido             :OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	 	SaidaEndRT				   :OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		SaidaEndRD      		   :OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END ID_EX;

ARCHITECTURE Behavior OF ID_EX IS
BEGIN
			RegistradorWB: Registrador1 GENERIC MAP (N => 2) PORT MAP (WB,'1', Clock, SaidaWB);
			RegistradorM: Registrador1 GENERIC MAP (N => 3) PORT MAP (M,'1', Clock, SaidaM);
			
			RegistradorRegDst: reg1b PORT MAP (EX(4), '1',Clock, RegDst);
			RegistradorAluOp: Registrador1 GENERIC MAP (N => 3) PORT MAP (EX(3 DOWNTO 1),'1', Clock, AluOp);
			RegistradorAluSrc: reg1b PORT MAP (EX(0),'1', Clock, AluSrc);
			
			RegistradorProxInst: Registrador1 PORT MAP (EndProxInst,'1',Clock, SaidaProxInst);
			RegistradorRS: Registrador1 PORT MAP (RS,'1', Clock, SaidaRS);
			RegistradorRT: Registrador1 PORT MAP (RT,'1', Clock, SaidaRT);
			RegistradorExtendido: Registrador1 PORT MAP (Extendido,'1', Clock, SaidaExtendido);
			RegistradorEndRT: Registrador1 GENERIC MAP (N => 5) PORT MAP (EndRT,'1', Clock, SaidaEndRT);
			RegistradorEndRD: Registrador1 GENERIC MAP (N => 5) PORT MAP (EndRD,'1', Clock, SaidaEndRD);
			
END Behavior;
