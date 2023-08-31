module Pipelined_mainprocessor(clk,reset);

input clk,reset;

wire [31:0] nextPC, readPC, PCPlus4IF, PCPlus4ID, PCPlus4EX;
wire [31:0] branchAddress;
wire [31:0] instructionIF, instructionID;
wire [31:0] registerData1ID, registerData2ID, registerData1EX, registerData2EX;
wire [31:0] signExtendOutID, signExtendOutEX;
wire [31:0] shiftOut;
wire [3:0] ALUOpID, ALUOpEX;
wire [9:0] controlSignalsID;
wire [4:0] rsEX ,rtEX ,rdEX;
wire [31:0] ALUData1, ALUData2;
wire [31:0] ALUData2Mux_1Out;
wire [4:0] regDstMuxOut;
wire [31:0] ALUResultEX, ALUResultMEM, ALUResultWB;
wire [31:0] memoryWriteDataMEM;
wire [4:0] writeRegMEM, writeRegWB;
wire [1:0] upperMux_sel, lowerMux_sel;
wire [1:0] comparatorMux1Selector,comparatorMux2Selector;
wire [31:0] comparatorMux1Out, comparatorMux2Out;
wire [31:0] memoryReadDataMEM, memoryReadDataWB;
wire [31:0] regWriteDataMEM;
wire [3:0] ALUControl;


//modules instances

//IF_Stage

Programcounter u1 (readPC, nextPC, reset, clk, holdPC);
Instruction_Memory u2 (instructionIF, clk, readPC);
ALU_Adder u3 (PCPlus4IF ,readPC, 32'h00000004);
Mux_2x1_32 u4 (nextPC, PCPlus4IF, branchAddress, PCMuxSel);
and u5 (PCMuxSel, equalFlag, branchID);
IF_ID_Reg u6 (instructionID, PCPlus4ID, PCPlus4IF, instructionIF, clk, holdIF_ID,PCMuxSel);


//ID_Stage

MainControl u7 (RegDstID,branchID,MemReadID,MemtoRegID,ALUOpID,MemWriteID,ALUSrcID,RegWriteID,instructionID[31:26],reset);
Register_file u8 (registerData1ID, registerData2ID, instructionID[25:21], instructionID[20:16], writeRegWB, regWriteDataMEM, RegWriteWB, clk, reset);
Mux_3x1_32 u9 (comparatorMux1Out, registerData1ID, ALUResultMEM, regWriteDataMEM, comparatorMux1Selector);
Mux_3x1_32 u10 (comparatorMux2Out, registerData2ID, ALUResultMEM, regWriteDataMEM, comparatorMux2Selector);
Comparator u11 (equalFlag, comparatorMux1Out, comparatorMux2Out);
SignExtend_16 u12 (signExtendOutID, instructionID[15:0]);
ShiftLeftby2 u13 (shiftOut, signExtendOutID);
ALU_Adder u14 (branchAddress, shiftOut, PCPlus4ID);
HazardDetection_Unit u15 (MemReadEX, MemReadMEM, rtEX, instructionID, holdPC, holdIF_ID, hazardMuxSelector);
Mux_2x1_10 u16 (controlSignalsID, {RegWriteID, MemtoRegID, MemWriteID, MemReadID, ALUSrcID, ALUOpID, RegDstID}
			,10'b0000000000, hazardMuxSelector);
ID_EX_Reg u17 (RegWriteID, MemtoRegID, MemWriteID, MemReadID, ALUSrcID, ALUOpID, RegDstID, PCPlus4ID,registerData1ID ,registerData2ID
		,signExtendOutID,instructionID[25:11],PCPlus4EX ,registerData1EX ,registerData2EX ,signExtendOutEX ,rsEX ,rtEX ,rdEX
		,RegWriteEX,MemtoRegEX,MemWriteEX, MemReadEX,ALUSrcEX, ALUOpEX, RegDstEX,clk);


//EX_Stage

Mux_3x1_32 u18 (ALUData1, registerData1EX, regWriteDataMEM, ALUResultMEM, upperMux_sel);
Mux_3x1_32 u19 (ALUData2Mux_1Out, registerData2EX, regWriteDataMEM, ALUResultMEM, lowerMux_sel);
Mux_2x1_32 u20 (ALUData2, ALUData2Mux_1Out, signExtendOutEX, ALUSrcEX);
ALUControl u21 (ALUControl, ALUOpEX, clk, signExtendOutEX[5:0]);
ALU_32 u22 (ALUResultEX, ALUData1, ALUData2, ALUControl, signExtendOutEX[10:6], overFlow, zero, reset);
Mux_2x1_5 u23 (regDstMuxOut, rtEX, rdEX, RegDstEX);
EX_Mem_Reg u24 (clk, RegWriteEX, MemtoRegEX, MemWriteEX, MemReadEX, ALUResultEX, ALUData2Mux_1Out
		,regDstMuxOut, RegWriteMEM, MemtoRegMEM, MemWriteMEM, MemReadMEM, ALUResultMEM, memoryWriteDataMEM, writeRegMEM);
Forwarding_Unit u25 (RegWriteMEM, writeRegMEM, RegWriteWB, writeRegWB, rsEX, rtEX
				,upperMux_sel,lowerMux_sel, comparatorMux1Selector,comparatorMux2Selector);


//MEM_Stage

DataMemory u26 (memoryReadDataMEM, ALUResultMEM, MemWriteMEM, MemReadMEM, memoryWriteDataMEM, clk);
Mem_Wb_Reg u27 (RegWriteMEM, MemtoRegMEM, ALUResultMEM, clk, memoryReadDataMEM, writeRegMEM, RegWriteWB, MemtoRegWB,memoryReadDataWB
		,ALUResultWB, writeRegWB);


//WB_Stage
Mux_2x1_32 u28 (regWriteDataMEM, ALUResultWB, memoryReadDataWB, MemtoRegWB);


endmodule
