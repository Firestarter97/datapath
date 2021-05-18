module HDU(
input [3:0] Opcode, 
input ID_EX_MemRead, equal, ID_EX_RegWrite, EX_MEM_RegWrite,
input [3:0] ID_EX_RT, ID_EX_RS, IF_ID_RS, IF_ID_RT, EX_MEM_RT,
input signed [15:0] ALU_Result, R0, Op1, Op2,
output reg IF_ID_Write, stall, PC_Enable, Cause,
output reg [1:0] WhichFlush, Exception_Caught
);

reg [31:0] ALU_FullResult;
reg [31:0] Op1_32;
reg [31:0] Op2_32;

localparam j = 4'h7;
localparam beq = 4'h6;
localparam blt = 4'h5;
localparam bgt = 4'h4;

always@(*)
begin
if((Opcode == 4'b1001) || (Opcode == 4'b0011) || (Opcode == 4'b1000) || (Opcode == 4'b1110))
        Cause = 1'b0; //INVALID OPCODE
end

always@(*)
begin
ALU_FullResult = {R0, ALU_Result};
Op1_32 = {{16{Op1[15]}},Op1[15:0]};
Op2_32 = {{16{Op2[15]}},Op2[15:0]};


if(ID_EX_MemRead && ((ID_EX_RT == IF_ID_RS) || (ID_EX_RT == IF_ID_RT))) begin
	stall = 1'b1;
	PC_Enable = 1'b0;
    Exception_Caught = 2'b01;
    IF_ID_Write = 1'b0;
	WhichFlush = 2'b01;
	end
else if(((Opcode == beq) || (Opcode == blt) || (Opcode == bgt)) && (((ID_EX_RT == IF_ID_RS || ID_EX_RT == IF_ID_RT) && (ID_EX_RegWrite == 1'b1)) || ((EX_MEM_RT == IF_ID_RS || EX_MEM_RT == IF_ID_RT) && (EX_MEM_RegWrite == 1'b1)))) 
	begin
	stall = 1'b1;
	PC_Enable = 1'b0;
    Exception_Caught = 2'b01;
    IF_ID_Write = 1'b0;
	WhichFlush = 2'b00;
	end
else if((Opcode == j) || (Opcode == beq && (equal == 1'b1)) || (Opcode == blt && (equal == 1'b0)) || (Opcode == bgt && (equal == 1'b0))) begin
	stall = 1'b0;
	PC_Enable = 1'b1;
    Exception_Caught = 2'b00;
    IF_ID_Write = 1'b1;
	WhichFlush = 2'b00;
	end

else if((((Op1_32 ^ ALU_FullResult)&(Op2_32 ^ ALU_FullResult)) & 32'h80000000) == 32'h80000000) begin
	Cause = 1'b1;
	WhichFlush = 2'b10;
	end
else begin
        stall = 1'b0;
        PC_Enable = 1'b1;
        Exception_Caught = 2'b00;
        IF_ID_Write = 1'b1;
        WhichFlush = 2'b11;			                                								
     end
end
endmodule
