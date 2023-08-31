module Pipelined_proc_testbench();

reg clk, reset;

Pipelined_mainprocessor m1(clk,reset);

always @(clk)
#50 clk <= ~clk;

initial begin

clk <= 0; reset <= 1;
#50 reset <= 0;

end

endmodule
