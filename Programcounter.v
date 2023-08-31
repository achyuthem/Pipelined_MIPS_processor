module Programcounter (outputPC,inputPC,reset,clk,holdPC);

//This module is used for updating the value to the program counter 

input [31:0] inputPC;
input reset , clk, holdPC;
output reg [31:0] outputPC;

always @(posedge reset) outputPC <= -4;
  

always @(posedge clk)
  begin
	  if (holdPC==0) //to support stalls from hazard detection unit
		  begin
                   outputPC <= inputPC;
		  end
  end

endmodule
