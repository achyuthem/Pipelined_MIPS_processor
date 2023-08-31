module ShiftLeftby2(shift_out, shift_in);

//This module is used for shifting the input by 2 bits

input [31:0] shift_in;
output [31:0] shift_out;

assign shift_out = shift_in << 2;

endmodule
