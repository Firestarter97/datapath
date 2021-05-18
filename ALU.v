module ALU(
input [2:0] alu_control_out, 
input [15:0] immd, 
input signed [15:0] Op1, 
input signed [15:0] Op2, 
output reg Pos, Neg, 
output reg signed [15:0] R0, Result);

always@(*)
begin
case(alu_control_out)

	3'b000: begin 
			Result = Op1 + Op2;
			Pos = 1'b0; 
			Neg = 1'b0;
			end
	3'b001: begin
			Result = Op1 - Op2;
			if(Result > 0) begin
				Pos = 1'b1; 
				Neg = 1'b0;
				end
			else if(Result < 0) begin
				Pos = 1'b0;
				Neg = 1'b1;
				end
			end
	3'b010: begin
			{R0,Result} = Op1 * Op2;
			Pos = 1'b0;
			Neg = 1'b0;			
			end
	3'b100: begin
			{R0,Result} = Op1 / Op2;
			Pos = 1'b0;
			Neg = 1'b0;			
			end
	3'b101: begin
			Result = Op1 & Op2; 
			Pos = 1'b0;
			Neg = 1'b0;				
			end
	3'b110: begin
			Result = Op1 | Op2;
			Pos = 1'b0;
			Neg = 1'b0;					
			end
	3'b111: begin
			Result = immd + Op2; //load byte unsigned, store byte,
			Pos = 1'b0;
			Neg = 1'b0;			
			end
endcase
end
endmodule
