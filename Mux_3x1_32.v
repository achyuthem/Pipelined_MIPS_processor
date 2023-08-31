module Mux_3x1_32 (mux_out, input1, input2, input3, mux_control);

//This module is used for selecting one of the three 32-bit inputs to the output depending on the mux_control signal

input [31:0] input1, input2, input3;
input [1:0] mux_control;
output [31:0] mux_out;

assign mux_out = (mux_control == 2'b00) ? input1 : (mux_control == 2'b01) ? input2 : (mux_control == 2'b10) ? input3 : 32'bx;

endmodule
