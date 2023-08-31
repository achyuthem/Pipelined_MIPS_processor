module HazardDetection_Unit (ID_ExMemRead,EX_MemMemRead,ID_Ex_Rt,IF_ID_Instr,holdPC,holdIF_ID,muxSelector);

/* This module is used for detection of data hazards in the pipelined processor which cannot be forwarded. Control signals are generated that are used for introducing stalls in the pipeline 
   The conditions are in accordance with that specified in the TB */ 
 
input ID_ExMemRead,EX_MemMemRead;
input [4:0] ID_Ex_Rt;
input [31:0] IF_ID_Instr;
output reg holdPC, holdIF_ID, muxSelector;
parameter beq=6'b000100;

initial
begin
	holdPC <= 0;
	holdIF_ID <= 0;
	muxSelector <= 0;
end

always@(ID_ExMemRead or ID_Ex_Rt or IF_ID_Instr)
begin
  if (ID_ExMemRead && (holdPC == 1'b0) && (holdIF_ID == 1'b0))
	begin
	  if(ID_Ex_Rt==IF_ID_Instr[25:21] || ID_Ex_Rt==IF_ID_Instr[20:15] )
		begin
		  holdPC<=1;
		  holdIF_ID<=1;
		  muxSelector<=1;
		end
	end
  else if((IF_ID_Instr [31:26]==beq) && (holdPC == 1'b0) && (holdIF_ID == 1'b0))
	begin
	  holdPC<=1;
	  holdIF_ID<=1;
	  muxSelector<=1;
	end
	  
  else
	begin
	  holdPC<=0;
	  holdIF_ID<=0;
	  muxSelector<=0;     
	end    
  
end
  
  
endmodule