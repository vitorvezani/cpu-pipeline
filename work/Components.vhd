LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.components.all;

PACKAGE components IS

COMPONENT Registrador1
    GENERIC ( N : INTEGER := 32 ) ;
	PORT(	R       :IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			Rin	  :IN  STD_LOGIC;
			Clock	  :IN  STD_LOGIC;
	     	Q       :OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
	);
END COMPONENT ;

COMPONENT ALU
    GENERIC(N : INTEGER := 32);
    PORT (
   	 A,B         :IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	 ALUControl  :IN STD_LOGIC_VECTOR(2 DOWNTO 0);
   	 ALUResult   :OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	 Zero        :OUT STD_LOGIC
    );
END COMPONENT ;

COMPONENT ALUControlComp
    PORT (
   	 ALUOp       :IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	 FunctionOP  :IN STD_LOGIC_VECTOR(5 DOWNTO 0);
   	 ALUControl  :OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END COMPONENT ;

COMPONENT Control
    PORT (
   	 OPCode      :IN STD_LOGIC_VECTOR(5 DOWNTO 0);
	 WB          :OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	 M           :OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
   	 EX          :OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
    );
END COMPONENT ;

COMPONENT EX_MEM
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
END COMPONENT;

COMPONENT ID_EX
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
END COMPONENT;

COMPONENT IF_ID
    GENERIC(N : INTEGER := 32);
    PORT (
   	 EndProxInst           :IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
   	 Inst                  :IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	 Clock                 :IN STD_LOGIC;
	 SaidaEndProxInst      :OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	 SaidaInst             :OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
    );
END COMPONENT;

COMPONENT MEM_WB
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
END COMPONENT;

COMPONENT Mux2to1
    GENERIC(N : INTEGER := 32);
    PORT (
   	 A,B         :IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	 Controle    :IN STD_LOGIC;
   	 Result      :OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
    	);
END COMPONENT;

COMPONENT ShiftLeft2
    GENERIC(N : INTEGER := 32);
    PORT (
	 A 	          :IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
     Aext	      :OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
    );
END COMPONENT;

COMPONENT SignExtend
    GENERIC(N : INTEGER := 16);
    PORT (
   	 A           :IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
   	 Aext      :OUT STD_LOGIC_VECTOR((N*2)-1 DOWNTO 0)
    );
END COMPONENT;

COMPONENT ADD
    GENERIC(N : INTEGER := 32);
    PORT (
   	 A,B         :IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
   	 ADDResult   :OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
    );
END COMPONENT;

COMPONENT InstructionMemory
    GENERIC(N : INTEGER := 32);
	PORT(
		Address				:IN STD_LOGIC_VECTOR ((N-1) DOWNTO 0);
		Instruction			:OUT STD_LOGIC_VECTOR ((N-1) DOWNTO 0)
		);
END COMPONENT;

COMPONENT Registers
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
END COMPONENT;

COMPONENT DataMemory IS
	GENERIC(N : INTEGER := 32);
	PORT(
		Address 		:IN STD_LOGIC_VECTOR (N-1 DOWNTO 0);
		WriteData		:IN STD_LOGIC_VECTOR (N-1 DOWNTO 0);
		MemWrite		:IN STD_LOGIC;
		MemRead			:IN STD_LOGIC;
		Clock			:IN STD_LOGIC;	
		ReadData		:OUT STD_LOGIC_VECTOR (N-1 DOWNTO 0)
		);
END COMPONENT;

COMPONENT Registrador0
	GENERIC(N : INTEGER := 32);
	PORT(	R       :IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			Rin 	:IN  STD_LOGIC;
			Clock	:IN  STD_LOGIC;
	     	Q       :OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
	);
END COMPONENT;

COMPONENT Reg1b
	PORT(	R       :IN  STD_LOGIC;
			Rin		:IN  STD_LOGIC;
			Clock	:IN  STD_LOGIC;
	    	Q       :OUT STD_LOGIC
	);
END COMPONENT;

END components;
