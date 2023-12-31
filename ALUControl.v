module ALUControl (ALUout, ALUOp, clk, funct);

/* This module is used for generating control signals to the ALU to perform various operations such as add, subtract, and etc. Generation of the control signals
   is in accordance with the truth table provided in TB */   

input clk;
input [3:0] ALUOp;
input [5:0] funct;
output [3:0] ALUout;

assign ALUout = 	(ALUOp == 4'b0000) ? 4'b0000:
			(ALUOp == 4'b0001) ? 4'b0001:
			(ALUOp == 4'b0011) ? 4'b0010:
			(ALUOp == 4'b0100) ? 4'b0011:
			(ALUOp == 4'b0101) ? 4'b1000:
			(ALUOp == 4'b0010) ? 
				((funct == 6'b100000) ? 4'b0000:
				 (funct == 6'b100010) ? 4'b0001:
				 (funct == 6'b100100) ? 4'b0010:
				 (funct == 6'b100101) ? 4'b0011:
				 (funct == 6'b100111) ? 4'b1001:
				 (funct == 6'b101010) ? 4'b1000:
				 (funct == 6'b000000) ? 4'b0100:
				 (funct == 6'b000010) ? 4'b0101 : 4'bxxxx): 4'bxxxx;

endmodule
