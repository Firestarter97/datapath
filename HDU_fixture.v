`include "HDU.v"
module HDU_fixture;
reg [3:0] Opcode;
reg [3:0] ID_EX_RT, ID_EX_RS, IF_ID_RS, IF_ID_RT, EX_MEM_RT;
reg signed [15:0] ALU_Result, R0, Op1, Op2;
reg ID_EX_MemRead, equal, EX_MEM_RegWrite, ID_EX_RegWrite;

wire IF_ID_Write, stall, Exception_Caught, PC_Enable, Cause;
wire [1:0] WhichFlush;
wire [31:0] ALU_FullResult, Op1_32, Op2_32;

initial
    $monitor($time, " ns, ID_EX_MemRead=%b,ID_EX_RegWrite=%b equal=%b, IF_ID_Write=%b, stall=%b, Exception_Caught=%b, PC_Enable=%b, Cause=%b \n, Opcode=%b, ID_EX_RT=%h, ID_EX_RS=%h, IF_ID_RS=%h, IF_ID_RT=%h EX_MEM_RT = %h EX_MEM_RegWrite=%h\n , R0=%h ALU_Result=%h Op1 = %h Op2 = %h, WhichFlush=%b" , ID_EX_MemRead,ID_EX_RegWrite, equal, IF_ID_Write, stall, Exception_Caught, PC_Enable, Cause, Opcode, ID_EX_RT, ID_EX_RS, IF_ID_RS, IF_ID_RT, EX_MEM_RT, EX_MEM_RegWrite,R0, ALU_Result, Op1, Op2, WhichFlush);
	
HDU HDU_Unit (.Opcode(Opcode),.ID_EX_MemRead(ID_EX_MemRead),.equal(equal),.ID_EX_RT(ID_EX_RT),.ID_EX_RS(ID_EX_RS),.IF_ID_RS(IF_ID_RS),.IF_ID_RT(IF_ID_RT),.ALU_Result(ALU_Result),.R0(R0),.IF_ID_Write(IF_ID_Write),.stall(stall),.Exception_Caught(Exception_Caught),.PC_Enable(PC_Enable),.Cause(Cause),.WhichFlush(WhichFlush), .Op1(Op1), .Op2(Op2), .EX_MEM_RT(EX_MEM_RT), .EX_MEM_RegWrite(EX_MEM_RegWrite),.ID_EX_RegWrite(ID_EX_RegWrite));
	
initial begin
        //Initialize values to zero
        Opcode = 4'b0000; ID_EX_MemRead = 1'b0; equal = 1'b0; ID_EX_RT = 4'b0000; ID_EX_RS = 4'b0000; IF_ID_RS = 4'b0000; IF_ID_RT = 4'b0000; ALU_Result = 16'h0000; R0 = 16'h0000;
        

	#10;	Opcode = 4'b1001; ID_EX_MemRead = 1'b1; equal = 1'b0; ID_EX_RT = 4'b0010; ID_EX_RS = 4'b0001; IF_ID_RS = 4'b0001; IF_ID_RT = 4'b0001; ALU_Result = 16'h8000; R0 = 16'h8000; Op1 = 16'h0010; Op2 = 16'h0010;
	#10;	Opcode = 4'b1001; ID_EX_MemRead = 1'b1; equal = 1'b0; ID_EX_RT = 4'b0010; ID_EX_RS = 4'b0001; IF_ID_RS = 4'b0001; IF_ID_RT = 4'b0001; ALU_Result = 16'h8000; R0 = 16'h8000; Op1 = 16'h0010; Op2 = 16'h0010;
	#10;	Opcode = 4'b1111; ID_EX_MemRead = 1'b1; equal = 1'b0; ID_EX_RT = 4'b0010; ID_EX_RS = 4'b0001; IF_ID_RS = 4'b0001; IF_ID_RT = 4'b0001; ALU_Result = 16'h8000; R0 = 16'h8000; Op1 = 16'h0010; Op2 = 16'h0010;
	#10;	Opcode = 4'b1111; ID_EX_MemRead = 1'b1; equal = 1'b0; ID_EX_RT = 4'b0010; ID_EX_RS = 4'b0001; IF_ID_RS = 4'b0001; IF_ID_RT = 4'b0001; ALU_Result = 16'h8000; R0 = 16'h8000; Op1 = 16'h0010; Op2 = 16'h0010;

	#10;	Opcode = 4'b1111; ID_EX_MemRead = 1'b1; equal = 1'b0; ID_EX_RT = 4'b0010; ID_EX_RS = 4'b0001; IF_ID_RS = 4'b0001; IF_ID_RT = 4'b0001; ALU_Result = 16'h8000; R0 = 16'h8000; Op1 = 16'h8010; Op2 = 16'h8010;
	#10;	Opcode = 4'b1111; ID_EX_MemRead = 1'b1; equal = 1'b0; ID_EX_RT = 4'b0010; ID_EX_RS = 4'b0001; IF_ID_RS = 4'b0001; IF_ID_RT = 4'b0001; ALU_Result = 16'h8000; R0 = 16'h8000; Op1 = 16'h0010; Op2 = 16'h0010;


	#10 $finish;
        end
endmodule
