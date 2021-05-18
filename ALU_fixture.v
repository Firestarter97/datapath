`include "ALU.v"
module ALU_fixture;
    reg [2:0] alu_control_out;
	reg [15:0] immd,Op1,Op2;
	wire Pos, Neg;
    wire [15:0] Result, R0;

initial
    $monitor($time, " ns, alu_control_out=%b immd=%h Op1=%h Op2=%h Pos=%b Neg=%b R0=%h Result=%h", alu_control_out,immd,Op1,Op2,Pos,Neg,R0,Result);

ALU ALU_MAIN (.alu_control_out(alu_control_out),.immd(immd),.Op1(Op1),.Op2(Op2),.Pos(Pos),.Neg(Neg),.Result(Result), .R0(R0));
	
initial begin
        //Initialize values to zero
		alu_control_out = 3'b000; immd = 16'h0000; Op1 = 16'h0000; Op2=16'h0000;
		
#10;	alu_control_out = 3'b001; immd = 16'h0002; Op1 = 16'h0001; Op2=16'h0001;
#10;	alu_control_out = 3'b001; immd = 16'h0110; Op1 = 16'hF111; Op2=16'h0111;
#10;	alu_control_out = 3'b001; immd = 16'h0100; Op1 = 16'h0BFF; Op2=16'hFFF0;
#10;	alu_control_out = 3'b001; immd = 16'h0110; Op1 = 16'h0006; Op2=16'h0009;
#10;	alu_control_out = 3'b101; immd = 16'h0DD0; Op1 = 16'h04bD; Op2=16'h0222;
#10;	alu_control_out = 3'b110; immd = 16'h0BB0; Op1 = 16'hFFF0; Op2=16'h0BCD;
#10;	alu_control_out = 3'b111; immd = 16'h1100; Op1 = 16'hFFFF; Op2=16'h0FFF;




#10 $finish;
end
endmodule