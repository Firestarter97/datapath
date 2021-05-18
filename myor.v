module myor(
input A,B,
output reg C
);

always@(*) begin
	C = A || B;
end
endmodule