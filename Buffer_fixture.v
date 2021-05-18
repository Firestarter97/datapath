`include "Buffer.v"
module Buffer_fixture;

reg clk, reset, w_en,bubble;

reg [15:0] ALU_result;
reg [15:0] PC;
reg [15:0] Current_Instruction;

reg [47:0] buffer_in;
wire [47:0] buffer_out;

wire [15:0] ALU_result_out;
wire [15:0] PC_out;
wire [15:0] Current_Instruction_out;

initial
	$vcdpluson;

initial 
	$monitor ($time, "\nALU_result =%h PC = %h Current_Instruction = %h\n ALU_result_out=%h PC_out=%h Current_Instruction_out=%h \n w_en = %b rst = %b clk = %b bubble=%b" , ALU_result, PC, Current_Instruction,ALU_result_out, PC_out, Current_Instruction_out, w_en, reset, clk, bubble);
	

Buffer #(.N(48)) IF_ID_BUF (
		.clk(clk),
		.reset(reset),
		.w_en(w_en),
		.bubble(bubble),
        .buffer_in({ALU_result, PC, Current_Instruction}),
        .buffer_out({ALU_result_out, PC_out, Current_Instruction_out})    
        );

initial
begin
	clk = 1'b0;
	forever #10 clk = ! clk;
end

initial
begin
	 	reset = 1'b1;
       #2	reset = 1'b0;
end
initial begin

	#10 ALU_result = 16'h0000; PC = 16'h0000; Current_Instruction = 16'b0000; w_en = 1'b0; reset = 1'b1;
	
	@(posedge clk); ALU_result = 16'h0000; PC = 16'h0000; Current_Instruction = 16'h0000; w_en = 1'b1; reset = 1'b1;
	@(posedge clk); ALU_result = 16'hFFFF; PC = 16'h0000; Current_Instruction = 16'h0000; w_en = 1'b1; reset = 1'b1;
	@(posedge clk); ALU_result = 16'h0110; PC = 16'h0000; Current_Instruction = 16'h0880; w_en = 1'b1; reset = 1'b0;
	@(posedge clk); ALU_result = 16'hCDD0; PC = 16'h0220; Current_Instruction = 16'h0000; w_en = 1'b1; reset = 1'b1;
	@(posedge clk); ALU_result = 16'hCBF0; PC = 16'hCBD0; Current_Instruction = 16'h8800; w_en = 1'b0; reset = 1'b1;
	@(posedge clk); ALU_result = 16'hCBF0; PC = 16'hCBD0; Current_Instruction = 16'h8800; w_en = 1'b1; reset = 1'b1;


        #10     $finish;

end
endmodule

