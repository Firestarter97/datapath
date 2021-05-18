`include "FU.v"
module FU_fixture;
	reg EX_MEM_RegWrite,MEM_WB_RegWrite, SwapOp;
    reg [3:0] EX_MEM_RegisterRT;
	reg [3:0] ID_EX_RegisterRT;
	reg [3:0] ID_EX_RegisterRS;
	reg [3:0] MEM_WB_RegisterRT;
	
    wire [1:0] ForwardA;
	wire [1:0] ForwardB;

initial
begin
	$monitor ($time, "ns, ForwardA = %b; ForwardB = %b \n", ForwardA, ForwardB);
	
	$monitor($time, " ns, EX_MEM_RegWrite=%b, MEM_WB_RegWrite=%b, SwapOp=%b \n, EX_MEM_RegisterRT=%h, ID_EX_RegisterRS=%h, MEM_WB_RegisterRT=%h, ID_EX_RegisterRT = %h,\n ForwardA = %b, ForwardB = %b\n", EX_MEM_RegWrite, MEM_WB_RegWrite, SwapOp, EX_MEM_RegisterRT, ID_EX_RegisterRS, MEM_WB_RegisterRT, ID_EX_RegisterRT, ForwardA, ForwardB);
end

FU FORWARDING_UNIT (.EX_MEM_RegWrite(EX_MEM_RegWrite), .MEM_WB_RegWrite(MEM_WB_RegWrite), .SwapOp(SwapOp), .EX_MEM_RegisterRT(EX_MEM_RegisterRT), .ID_EX_RegisterRS(ID_EX_RegisterRS), .MEM_WB_RegisterRT(MEM_WB_RegisterRT), .ForwardA(ForwardA), .ForwardB(ForwardB), .ID_EX_RegisterRT(ID_EX_RegisterRT));

initial begin
        //Initialize values to zero
		EX_MEM_RegWrite = 1'b0; MEM_WB_RegWrite = 1'b0; SwapOp = 1'b0; ID_EX_RegisterRT = 1'b0;
		EX_MEM_RegisterRT = 4'h0; ID_EX_RegisterRS = 4'h0; MEM_WB_RegisterRT = 4'h0;
		
#10;	EX_MEM_RegWrite = 1'b1; MEM_WB_RegWrite = 1'b1; SwapOp = 1'b0; ID_EX_RegisterRT = 1'b0;
		EX_MEM_RegisterRT = 4'h1; ID_EX_RegisterRS = 4'h2; MEM_WB_RegisterRT = 4'h2;
	
#10;	EX_MEM_RegWrite = 1'b1; MEM_WB_RegWrite = 1'b1; SwapOp = 1'b0; ID_EX_RegisterRT = 1'b0;
		EX_MEM_RegisterRT = 4'h1; ID_EX_RegisterRS = 4'h2; MEM_WB_RegisterRT = 4'h1;

#10;	EX_MEM_RegWrite = 1'b1; MEM_WB_RegWrite = 1'b1; SwapOp = 1'b1; ID_EX_RegisterRT = 1'b0;
		EX_MEM_RegisterRT = 4'h1; ID_EX_RegisterRS = 4'h2; MEM_WB_RegisterRT = 4'h1;

#10;	EX_MEM_RegWrite = 1'b1; MEM_WB_RegWrite = 1'b1; SwapOp = 1'b0; ID_EX_RegisterRT = 1'b0;
		EX_MEM_RegisterRT = 4'h1; ID_EX_RegisterRS = 4'h2; MEM_WB_RegisterRT = 4'h2;	
		
#10;    EX_MEM_RegWrite = 1'b1; MEM_WB_RegWrite = 1'b1; SwapOp = 1'b0; ID_EX_RegisterRT = 1'b0;
        EX_MEM_RegisterRT = 4'h1; ID_EX_RegisterRS = 4'h1; MEM_WB_RegisterRT = 4'h0;
		
#10;	EX_MEM_RegWrite = 1'b1; MEM_WB_RegWrite = 1'b1; SwapOp = 1'b1; ID_EX_RegisterRT = 1'b0;
		EX_MEM_RegisterRT = 4'h1; ID_EX_RegisterRS = 4'h2; MEM_WB_RegisterRT = 4'h1;	
		
#10;    EX_MEM_RegWrite = 1'b1; MEM_WB_RegWrite = 1'b1; SwapOp = 1'b1; ID_EX_RegisterRT = 1'b0;
        EX_MEM_RegisterRT = 4'h1; ID_EX_RegisterRS = 4'h1; MEM_WB_RegisterRT = 4'h0;


		
		

#10 $finish;
end
endmodule