module Instruction_Memory (readData,clk,pc);

//This module is used for modelling the instruction memory of a pipelined processor  

input clk;
input [31:0] pc;
reg [31:0] Imem [0:1023];
output reg [31:0] readData;

initial 
	begin
		$readmemh("code.txt",Imem);  //reading in the instructions from the textfile into memory
	end


always @ (pc)
	begin	 
		readData <= Imem[pc>>2];
	end			
		
endmodule	
