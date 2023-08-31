module Mux_2x1_5 (mux_out, input1, input2, mux_control);

//This module is used for selecting one of the 5 bit inputs to the output

input [4:0] input1, input2;
input mux_control;
output [4:0] mux_out;

assign mux_out = (mux_control == 1'b0) ? input1 : (mux_control == 1'b1) ? input2 : 5'bx;

endmodule
