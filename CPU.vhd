LIBRARY ieee ;
USE ieee.std_logic_1164.all;
LIBRARY work;
USE work.Components.all;

ENTITY CPU IS
    GENERIC (N : INTEGER := 32 );
PORT (
        Clock                      	:IN STD_LOGIC;
		sWB 						:OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		sM 							:OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		sEX 						:OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		sALUSrc     				:OUT STD_LOGIC;
		sALUOp       				:OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		sRegDst       				:OUT STD_LOGIC;
		sZeroSaida   				:OUT STD_LOGIC;
		sRegWrite 					:OUT STD_LOGIC;
		sBranch 					:OUT STD_LOGIC;
		sMemRead 					:OUT STD_LOGIC;
		sMemWrite 					:OUT STD_LOGIC;
		sMemtoReg 					:OUT STD_LOGIC;
		sReadData2Saida2			:OUT STD_LOGIC_VECTOR((N-1) DOWNTO 0);
		sReadData					:OUT STD_LOGIC_VECTOR((N-1) DOWNTO 0);
		sPCSrc 						:OUT STD_LOGIC;
		sWriteData			 		:OUT STD_LOGIC_VECTOR((N-1) DOWNTO 0);
		sWriteRegister				:OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		sInstSaida	     			:OUT STD_LOGIC_VECTOR((N-1) DOWNTO 0);
		sMux3Result1    			:OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		sReadData1Saida      		:OUT STD_LOGIC_VECTOR((N-1) DOWNTO 0);
		sMux2Result     			:OUT STD_LOGIC_VECTOR((N-1) DOWNTO 0);
		sEnderecoPC	    			:OUT STD_LOGIC_VECTOR((N-1) DOWNTO 0);
		sImedExtSaidaSL 			:OUT STD_LOGIC_VECTOR((N-1) DOWNTO 0);
		sALUResult      			:OUT STD_LOGIC_VECTOR((N-1) DOWNTO 0)
    );
END CPU;

ARCHITECTURE Behavior OF CPU IS

	SIGNAL EnderecoPC 			: STD_LOGIC_VECTOR((N-1) DOWNTO 0);
	SIGNAL EnderecoPC2  	 	: STD_LOGIC_VECTOR((N-1) DOWNTO 0);
	SIGNAL Inst  	    		: STD_LOGIC_VECTOR((N-1) DOWNTO 0);
	SIGNAL EndProxInst  		: STD_LOGIC_VECTOR((N-1) DOWNTO 0);
	SIGNAL EndInstBranch2 		: STD_LOGIC_VECTOR((N-1) DOWNTO 0);
	SIGNAL InstSaida 			: STD_LOGIC_VECTOR((N-1) DOWNTO 0);
	SIGNAL EndProxInstSaida 	: STD_LOGIC_VECTOR((N-1) DOWNTO 0);
	SIGNAL WB 					: STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL M 					: STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL EX 					: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL WriteRegister 		: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL WriteData			: STD_LOGIC_VECTOR((N-1) DOWNTO 0);
	SIGNAL ReadData        		: STD_LOGIC_VECTOR((N-1) DOWNTO 0);
 	SIGNAL ReadData1        	: STD_LOGIC_VECTOR((N-1) DOWNTO 0);
	SIGNAL ReadData2        	: STD_LOGIC_VECTOR((N-1) DOWNTO 0);
	SIGNAL ImedExt				: STD_LOGIC_VECTOR((N-1) DOWNTO 0);
	SIGNAL WBSaida1				: STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL WBSaida2				: STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL MSaida				: STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL EndProxInstSaida2 	: STD_LOGIC_VECTOR((N-1) DOWNTO 0);
	SIGNAL ReadDataSaida  		: STD_LOGIC_VECTOR((N-1) DOWNTO 0);
	SIGNAL ReadData1Saida  		: STD_LOGIC_VECTOR((N-1) DOWNTO 0);
	SIGNAL ReadData2Saida1  	: STD_LOGIC_VECTOR((N-1) DOWNTO 0);
	SIGNAL ReadData2Saida2  	: STD_LOGIC_VECTOR((N-1) DOWNTO 0);
	SIGNAL EndRT   	        	: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL EndRD	       		: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL ImedExtSaida    		: STD_LOGIC_VECTOR((N-1) DOWNTO 0);
	SIGNAL ImedExtSaidaSL    	: STD_LOGIC_VECTOR((N-1) DOWNTO 0);
	SIGNAL Mux2Result    		: STD_LOGIC_VECTOR((N-1) DOWNTO 0);
	SIGNAL Mux3Result1    		: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL Mux3ResultSaida    	: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL ALUResult    		: STD_LOGIC_VECTOR((N-1) DOWNTO 0);
	SIGNAL ALUResultSaida    	: STD_LOGIC_VECTOR((N-1) DOWNTO 0);
	SIGNAL ALUResultSaida2    	: STD_LOGIC_VECTOR((N-1) DOWNTO 0);
	SIGNAL EndInstBranch1 		: STD_LOGIC_VECTOR((N-1) DOWNTO 0);
	SIGNAL ALUControl 			: STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL ALUOp 				: STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL PCSrc 				: STD_LOGIC;
	SIGNAL RegWrite 			: STD_LOGIC;
	SIGNAL RegDst	 			: STD_LOGIC;
	SIGNAL AluSrc	        	: STD_LOGIC;
	SIGNAL Zero 				: STD_LOGIC := '0';
	SIGNAL Branch 				: STD_LOGIC;
 	SIGNAL MemRead				: STD_LOGIC;
	SIGNAL MemWrite				: STD_LOGIC;
	SIGNAL MemToReg				: STD_LOGIC;
	SIGNAL ZeroSaida			: STD_LOGIC;
	
BEGIN

	PC: Registrador0 PORT MAP (EnderecoPC,'1',Clock,EnderecoPC2);

	IM: InstructionMemory PORT MAP (EnderecoPC2,Inst);

	ADD1: ADD PORT MAP (EnderecoPC2,"00000000000000000000000000000100",EndProxInst);

	Mux1: Mux2to1 PORT MAP (EndProxInst,EndInstBranch2,PCSrc,EnderecoPC);

	IFID: IF_ID PORT MAP (EndProxInst,Inst,Clock,EndProxInstSaida,InstSaida);

	UniControl: Control PORT MAP (InstSaida(31 DOWNTO 26),WB,M,EX);

	BancoRegisters: Registers PORT MAP (InstSaida(25 DOWNTO 21),InstSaida(20 DOWNTO 16),WriteRegister,WriteData,RegWrite,Clock,ReadData1,ReadData2);

	SignalExt1: SignExtend PORT MAP (InstSaida(15 DOWNTO 0),ImedExt);

	IDEX: ID_EX PORT MAP (WB,M,EX,EndProxInstSaida,ReadData1,ReadData2,ImedExt,InstSaida(20 DOWNTO 16),InstSaida(15 DOWNTO 11),Clock,WBSaida1,MSaida,RegDst,ALUOp,ALUSrc,EndProxInstSaida2,ReadData1Saida,ReadData2Saida1,ImedExtSaida,EndRT,EndRD);

	SL : ShiftLeft2 PORT MAP (ImedExtSaida,ImedExtSaidaSL);

	ADD2: ADD PORT MAP (EndProxInstSaida2,ImedExtSaidaSL,EndInstBranch1);

	Mux2: Mux2to1 PORT MAP (ReadData2Saida1,ImedExtSaida,ALUSrc,Mux2Result);

	Mux3: Mux2to1 GENERIC MAP (N => 5) PORT MAP (EndRT,EndRD,RegDst,Mux3Result1);

	ALU1 : ALU PORT MAP (ReadData1Saida,Mux2Result,ALUControl,ALUResult,Zero);

	Control1: ALUControlComp PORT MAP (ALUOp,ImedExtSaida(5 DOWNTO 0),ALUControl);

	EXMEM : EX_MEM PORT MAP (WBSaida1,MSaida,EndInstBranch1,Zero,ALUResult,ReadData2Saida1,Mux3Result1,Clock,WBSaida2,Branch,MemRead,MemWrite,EndInstBranch2,ZeroSaida,ALUResultSaida,ReadData2Saida2,Mux3ResultSaida);

	PCSrc <= Branch AND ZeroSaida; 

	DataMem: DataMemory PORT MAP (ALUResultSaida,ReadData2Saida2,MemWrite,MemRead,Clock,ReadData);

	MEMWB: MEM_WB PORT MAP (WBSaida2,ReadData,ALUResultSaida,Mux3ResultSaida,Clock,RegWrite,MemToReg,ReadDataSaida,ALUResultSaida2,WriteRegister);

	Mux4: Mux2to1 PORT MAP (ALUResultSaida2,ReadDataSaida,MemToReg,WriteData);
	 
  sEnderecoPC <= EnderecoPC;
  sInstSaida <= InstSaida;
  sReadData1Saida <= ReadData1Saida;
  sMux2Result <= Mux2Result;
  sImedExtSaidaSL <= ImedExtSaidaSL;
  sMux3Result1 <= Mux3Result1;
  sALUResult <= ALUResult;
  sALUSrc <= ALUSrc;
  sALUOp <= ALUOp;
  sRegDst <= RegDst;
  sZeroSaida <= ZeroSaida;
  sBranch <= Branch;
  sMemRead <= MemRead;
  sMemWrite <= MemWrite;
  sMemtoReg <= MemtoReg;
  sReadData2Saida2 <= ReadData2Saida2;
  sReadData <= ReadData;
  sPCSrc <= PCSrc;
  sWriteData <= WriteData;
  sWriteRegister <= WriteRegister;
  sRegWrite <= RegWrite;
  sWB <= WB;
  sM  <= M;
  sEX <= EX;

END Behavior;