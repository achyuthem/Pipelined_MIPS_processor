module Register_file(readata1, readata2, readreg1, readreg2, writereg, writedata, RegWrite, clk, reset);

/* This module is used for modelling the register file present in the pipelined processor, with reads happening at anytime while writes occurring at posedge
   of the clock and when the control signal is active */

input [4:0] readreg1 ,readreg2 ,writereg;
input [31:0] writedata;
input RegWrite ,clk, reset;
output reg [31:0] readata1 ,readata2;

reg [31:0] regfile[0:31];

always @ (posedge reset) 
begin
	regfile[0] <= 32'h00000000;
	regfile[1] <= 32'h00000034;
	regfile[2] <= 32'h00000087;
	regfile[3] <= 32'h00000045;
	regfile[4] <= 32'h00000004;
	regfile[5] <= 32'h00000536;
	regfile[6] <= 32'h000000a9;
	regfile[7] <= 32'h000003d8;
	regfile[8] <= 32'h00000002;
	regfile[9] <= 32'h00000005;
	regfile[10] <= 32'h00000000;
	regfile[11] <= 32'h00000000;
	regfile[12] <= 32'h00000000;
	regfile[13] <= 32'h00000000;
	regfile[14] <= 32'h00000000;
	regfile[15] <= 32'h00000000;
	regfile[16] <= 32'h00000000;
	regfile[17] <= 32'h00000000;
	regfile[18] <= 32'h00000003;
	regfile[19] <= 32'h00000003;
	regfile[20] <= 32'h00000004;
	regfile[21] <= 32'h00000000;
	regfile[22] <= 32'h00000008;
	regfile[23] <= 32'h00000000;
	regfile[24] <= 32'h00000000;
	regfile[25] <= 32'h00000000;
	regfile[26] <= 32'h00000034;
	regfile[27] <= 32'h00340000;
	regfile[28] <= 32'h00092000;
	regfile[29] <= 32'h00000900;
	regfile[30] <= 32'h34000000;
	regfile[31] <= 32'h00000000;
end

always @(readreg1, readreg2)
begin
	readata1 <= regfile[readreg1];
	readata2 <= regfile[readreg2];
end

always @(posedge clk)
begin
	if (RegWrite == 1)
	begin
		 regfile[writereg] <= writedata;
	end
end



endmodule
