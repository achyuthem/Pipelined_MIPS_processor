module Mem_Wb_Reg (RegWrite, MemtoReg,ALUresult,clk,readdata,writereg,RegWriteoutput,MemtoRegoutput,readdataoutput,ALUresultoutput,writeRegoutput);
  
/* This module is used for modelling the register present between MEM and WB stages of the pipelined processor, whose purpose is to store the values required for 
   the WB stage */  
  
input clk;
input RegWrite, MemtoReg;
input [4:0] writereg;
input [31:0] ALUresult, readdata;
output reg RegWriteoutput, MemtoRegoutput;
output reg [31:0] readdataoutput,ALUresultoutput;
output reg [4:0] writeRegoutput;

always@(posedge clk)
begin
  RegWriteoutput<=RegWrite;
  MemtoRegoutput<=MemtoReg;
  readdataoutput<=readdata;
  ALUresultoutput<=ALUresult;
  writeRegoutput<=writereg;
end
  
  
endmodule