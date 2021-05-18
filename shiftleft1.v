module shiftleft1 #(parameter sizeof_input = 12, sizeof_output = 12) (
input [sizeof_input - 1: 0] shift_left1,
output reg [sizeof_output - 1: 0] out
);

always @(*) 
begin
	out = shift_left1 << 1;
end
endmodule
