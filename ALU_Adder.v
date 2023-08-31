module ALU_Adder (add_out ,input1, input2);

//This module is used for adding two 32 bit inputs 

input signed [31:0] input1, input2;
output [31:0] add_out;

assign add_out = input1 + input2;

endmodule
