LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY Mux2to1 IS
    GENERIC(N : INTEGER := 32);
    PORT (
   	 A,B         :IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	 Controle    :IN STD_LOGIC;
   	 Result      :OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
    	);
END Mux2to1;

ARCHITECTURE Behavior OF Mux2to1 IS
BEGIN
    PROCESS(A, B, Controle)
   	BEGIN
   		CASE Controle IS
   			WHEN '0' =>
      				Result <= A;
   		        WHEN OTHERS=>
       				Result <= B;
   		END CASE;
   END PROCESS;
END Behavior;
