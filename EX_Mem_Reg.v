module EX_Mem_Reg (clk,RegWrite, MemtoReg,MemWrite, MemRead,ALUresult,writedata,writeReg,RegWriteoutput, MemtoRegoutput,MemWriteoutput
			,MemReadoutput,ALUresultoutput,writedataoutput,writeRegoutput);
			
//This module is used for modelling the register present between EX and MEM stages, used to store the data which is used in further stages.
  
input clk;
input RegWrite, MemtoReg;
input MemWrite, MemRead; 
input [31:0] ALUresult,writedata;
input [4:0] writeReg;
output reg RegWriteoutput, MemtoRegoutput ,MemWriteoutput, MemReadoutput;
output reg [31:0] ALUresultoutput,writedataoutput;
output reg [4:0] writeRegoutput;

always@(posedge clk)
begin
  RegWriteoutput <= RegWrite;
  MemtoRegoutput <= MemtoReg;
  MemWriteoutput <= MemWrite;
  MemReadoutput <= MemRead;
  ALUresultoutput<=ALUresult;
  writedataoutput<=writedata;
  writeRegoutput<=writeReg; 
end
  
  
endmodule