module Comparator (isequal, input1 ,input2);

//This module is used for comparing two inputs and set output to 1 if the two inputs are equal 

input [31:0]  input1;
input [31:0]  input2;
output isequal;

assign isequal = (input1 == input2) ? 1'b1 : 1'b0;

endmodule
