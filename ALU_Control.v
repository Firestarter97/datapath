module ALU_Control
(
    input [1:0] ALUOP,
	input [3:0] function_code,
    output reg [2:0] ALU_Control
    );
always @(*) begin

	if (ALUOP == 2'b00) begin
		case(function_code)
			4'b0001: ALU_Control = 3'b000;
			4'b0010: ALU_Control = 3'b001;
			4'b0100: ALU_Control = 3'b010;
			4'b1000: ALU_Control = 3'b100;
			default: ALU_Control = 3'bxxx;
		endcase
	end
	else if ((ALUOP == 2'b01 | ALUOP == 2'b10 | ALUOP == 2'b11)) begin
		casex(ALUOP)
			2'b01: ALU_Control = 3'b101;
			2'b10: ALU_Control = 3'b110;
			2'b11: ALU_Control = 3'b111;
		endcase
	end
	else ALU_Control = 3'bxxx;
end
endmodule
