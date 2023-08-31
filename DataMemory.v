module DataMemory (readData,address,MemWrite,MemRead,writeData,clk);

/* This module is used for modelling the data memory of the mips pipelined processor, where writes and reads take place at the specified address according to the
   control signals that are active */

reg[31:0] dmem [0:31];
input MemWrite,MemRead,clk;
input [31:0] address,writeData;
output reg [31:0] readData;
  
always@(posedge clk) begin
    if(MemWrite==1)
        dmem[address]<=writeData;
end
  
always@(address or MemRead) begin
    if(MemRead==1)
        readData=dmem[address];
      
end

endmodule
