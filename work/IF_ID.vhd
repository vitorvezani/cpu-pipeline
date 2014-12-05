LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.components.all;


ENTITY IF_ID IS
    GENERIC(N : INTEGER := 32);
    PORT (
   	 EndProxInst           :IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
   	 Inst                  :IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	 Clock                 :IN STD_LOGIC;
	 SaidaEndProxInst      :OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	 SaidaInst             :OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
    );
END IF_ID;

ARCHITECTURE Behavior OF IF_ID IS
BEGIN
			RegistradorEndProxInst: Registrador1 PORT MAP (EndProxInst,'1', Clock, SaidaEndProxInst);
			RegistradorInst: Registrador1 PORT MAP (Inst,'1', Clock, SaidaInst);

END Behavior;
