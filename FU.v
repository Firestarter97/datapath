module FU(
input EX_MEM_RegWrite, 
input [3:0] EX_MEM_RegisterRT,
input [3:0] ID_EX_RegisterRT,
input [3:0] ID_EX_RegisterRS, 
input [3:0] MEM_WB_RegisterRT, 
input MEM_WB_RegWrite, 
input SwapOp, 
output reg [1:0] ForwardA, 
output reg [1:0] ForwardB);

always @(*) begin
if (SwapOp == 1'b0 && EX_MEM_RegWrite == 1'b1 && (EX_MEM_RegisterRT == ID_EX_RegisterRS)) begin
	ForwardA = 2'b11;
	ForwardB = 2'b11;
	end
else if (SwapOp == 1'b0 && (MEM_WB_RegWrite == 1'b1) && (MEM_WB_RegisterRT != 4'h0) && !(EX_MEM_RegWrite && (EX_MEM_RegisterRT != 4'h0) && (EX_MEM_RegisterRT != ID_EX_RegisterRS) ) && (MEM_WB_RegisterRT == ID_EX_RegisterRS))
	begin
	ForwardA = 2'b10;
	ForwardB = 2'b10;
	end
else if (SwapOp == 1'b1) begin
	ForwardA = 2'b00;
	ForwardB = 2'b01;
	end
else if (EX_MEM_RegWrite == 1'b1 && (EX_MEM_RegisterRT == ID_EX_RegisterRS)) begin
	ForwardA = 2'b11;
	ForwardB = 2'b11;
	end
else if (MEM_WB_RegWrite && (MEM_WB_RegisterRT != 4'h0) && !(EX_MEM_RegWrite && (EX_MEM_RegisterRT != 4'h0) && EX_MEM_RegisterRT != ID_EX_RegisterRT) && (MEM_WB_RegisterRT == ID_EX_RegisterRT)) 
	begin
	ForwardB = 2'b10;
	ForwardA = 2'b10;
	end
else begin
	ForwardB = 2'b01;
	ForwardA = 2'b01;
	end
end
endmodule