module Adder (
    input [15:0] A,B,
    output reg [15:0] R
    );
    
always @(*) begin
	R = A + B;
end
endmodule