module zero_extend(
input [7:0] before_zero_extend, output reg [15:0] after_zero_extend);

always@(*) begin
	after_zero_extend = {8'h00, before_zero_extend};
end
endmodule
