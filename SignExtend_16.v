module SignExtend_16 (sign_out, sign_in);

// This module is used for sign extending 16-bit input to a 32-bit input

input  [15:0] sign_in;
output [31:0] sign_out;

assign sign_out = (sign_in[15] == 1)? {16'hffff , sign_in} : (sign_in[15] == 0) ? {16'h0000 ,sign_in} : 16'hxxxx;

endmodule
