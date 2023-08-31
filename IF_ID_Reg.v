module IF_ID_Reg(instrOut,PCplus4Out,PCplus4,instrIn,clk,hold,IF_flush);

/* This module is used for modelling the register present between IF and ID stages, used to store data that is passed on to next stages. Flush is used for resolving 
   control hazards where all instructions in the pipeline are made 0 or nop */

input [31:0] instrIn,PCplus4;
input clk ,hold,IF_flush;
output reg [31:0] instrOut, PCplus4Out;

always @(posedge clk)
begin
  if (hold==1'b0) 
	begin
		PCplus4Out<=PCplus4;
		instrOut <= instrIn;
	end
  else if (IF_flush==1'b1)
	begin
		PCplus4Out<=PCplus4; 
		instrOut<=32'b0;
	end
end
  
endmodule
