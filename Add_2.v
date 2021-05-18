module Add_2(
    input [15:0] A,
    output reg [15:0] R
    );
    
always @(*) begin
	R = A + 4'h2;
end
endmodule