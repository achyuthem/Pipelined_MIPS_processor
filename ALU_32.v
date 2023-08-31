module ALU_32 (ALUout, input1, input2, ALUControl, shamt, overFlow, zero, reset);

/* This module is used for modelling the ALU in the pipelined processor, which carries out arithmetic operations like add,subtract,and,or etc according to the
   control input specified */

input reset;
input signed [31:0] input1,input2;
input [3:0] ALUControl;
input [4:0] shamt;
output reg overFlow, zero;
output reg signed [31:0] ALUout;

wire [31:0] neg_input2;
assign neg_input2 = -input2;

parameter ADD = 4'b0000;
parameter SUB = 4'b0001;
parameter AND = 4'b0010;
parameter OR = 4'b0011;
parameter NOR = 4'b1001;
parameter SHIFT_L = 4'b0100;
parameter SHIFT_R = 4'b0101;
parameter SHIFT_R_A = 4'b0110;
parameter GREATER = 4'b0111;
parameter LESSER = 4'b1000;


always @(posedge reset) zero <= 1'b0;

always @(ALUControl, input1, input2)
begin

	if(input1 == input2)
		zero <= 1'b1;
	else
		zero <= 1'b0;

case (ALUControl)

ADD: 
	begin	
		ALUout <= input1 + input2;
		if((input1[31] == input2[31]) && (ALUout[31] == ~input1[31]))
			overFlow <= 1'b1;
		else
			overFlow <= 1'b0;
	end

SUB:
	begin
		ALUout <= input1 + neg_input2;
		if(input1[31] == neg_input2[31] && ALUout[31] == ~input1[31])
			overFlow <= 1'b1;
		else
			overFlow <= 1'b0;
		end
	
AND:
	ALUout <= input1 & input2;

OR:
	ALUout <= input1 | input2;
	
NOR:
	begin
		ALUout <= ~(input1 | input2);
	end

SHIFT_L:
	ALUout <= input1 << shamt;

SHIFT_R:
	ALUout <= input1 >> shamt;

SHIFT_R_A:
	ALUout <= input1 >>> shamt;

GREATER:
	begin
		if(input1 > input2)
			ALUout <= 1;
		else
			ALUout <= 0;
	end

LESSER:
	begin
		if(input1 < input2)
			ALUout <= 1;
		else
			ALUout <= 0;
	end

endcase

end

endmodule
