module CauseEpc(
input [15:0] ALU_result1, 
input Cause,
output reg [15:0] EPC,
output reg Exception_Type
);

always@(*) begin
	Exception_Type = Cause;
	EPC = ALU_result1;
end
endmodule