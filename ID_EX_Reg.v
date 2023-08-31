module ID_EX_Reg (RegWrite, MemtoReg, MemWrite, MemRead,ALUSrc, ALUOp, RegDst, PCplus4 ,ReadData1_in ,ReadData2_in,SignExtendResult_in 
		,regAddress_in ,PCplus4out ,ReadData1_out ,ReadData2_out ,SignExtendResult_out ,rsoutput ,rtoutput ,rdoutput, RegWriteoutput
		,MemtoRegoutput,MemWriteoutput, MemReadoutput,ALUSrcoutput, ALUOpoutput, RegDstoutput,clk);
		
// This module is used for modelling the register present between ID and EX stages, it stores various data that is required for further stages.
  
input RegWrite, MemtoReg;
input MemWrite, MemRead; 
input ALUSrc, RegDst;
input [3:0] ALUOp;
output reg RegWriteoutput, MemtoRegoutput;
output reg MemWriteoutput, MemReadoutput;
output reg ALUSrcoutput, RegDstoutput;
output reg [3:0] ALUOpoutput;

input [31:0] PCplus4 ,ReadData1_in ,ReadData2_in ,SignExtendResult_in;
input [14:0] regAddress_in;
input clk;

output reg [31:0] PCplus4out ,ReadData1_out ,ReadData2_out ,SignExtendResult_out;
output reg [4:0] rsoutput ,rtoutput ,rdoutput;


always @(posedge clk)
begin
  PCplus4out <= PCplus4;
  ReadData1_out <= ReadData1_in;
  ReadData2_out <= ReadData2_in;
  SignExtendResult_out <= SignExtendResult_in;
  rsoutput <= regAddress_in[14:10];
  rtoutput <= regAddress_in[9:5];
  rdoutput <= regAddress_in[4:0];
  RegWriteoutput <= RegWrite;
  MemtoRegoutput <= MemtoReg;
  MemWriteoutput <= MemWrite;
  MemReadoutput <= MemRead;
  ALUSrcoutput <= ALUSrc;
  ALUOpoutput <= ALUOp;
  RegDstoutput <= RegDst;
end
  
endmodule
