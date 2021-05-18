`include "ALU_Control.v"
module ALU_Control_fixture;
    reg [1:0] ALUOP;
	reg [3:0] function_code;
    wire [2:0] ALU_Control;

initial
    $monitor($time, " ns, ALUOP=%b, function_code=%b, ALU_Control=%b", ALUOP, function_code, ALU_Control);

ALU_Control ALUCONTROL (.ALUOP(ALUOP), .function_code(function_code), .ALU_Control(ALU_Control));
	
initial begin
        //Initialize values to zero
		ALUOP = 2'b00; function_code = 4'b0000;
#10;	function_code = 4'b0001;
#10;	function_code = 4'b0010;
#10;	function_code = 4'b0100;
#10;	function_code = 4'b1000;

#10; 	function_code = 4'b0000; ALUOP = 2'b01;
#10; 	function_code = 4'b0000; ALUOP = 2'b10;
#10; 	function_code = 4'b0000; ALUOP = 2'b11;
#10; 	function_code = 4'bxxxx; ALUOP = 2'bxx;
#10; 	function_code = 4'bzzzz; ALUOP = 2'bzz;

#10 $finish;
end
endmodule