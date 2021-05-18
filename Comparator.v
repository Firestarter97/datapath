/*
DESCRIPTION:
Comparator For Branching in the ID stage
Checks if the inputs are equal and sets the "equal" flag */

module Comparator #(
	parameter BIT_WIDTH = 16
)(
	input [2*BIT_WIDTH - 1:0] dataIn,
	output reg equal
);


always @(*) begin
		if(dataIn[2*BIT_WIDTH - 1:BIT_WIDTH] == dataIn[BIT_WIDTH - 1:0])
			equal = 1'b1;
		else
			equal = 1'b0;
	end
endmodule