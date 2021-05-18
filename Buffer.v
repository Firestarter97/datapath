module Buffer #(parameter N=40) (
	input clk, reset, bubble, w_en,
	input 		[N-1:0] buffer_in,
	output reg	[N-1:0] buffer_out
	);
	
	integer i;
	reg insert_bubble_next;
	
	
	always@(posedge clk, negedge reset) begin 
		//Initialize buffer to zero on reset
		if (reset == 1'b0 || insert_bubble_next == 1'b1) begin
			insert_bubble_next <= 1'b0;
			for (i = 0; i < N; i = i + 1)
				buffer_out[i] <= 1'b0;
		end
		
		else if (w_en == 1'b0)
			buffer_out <= buffer_out;
		else
			buffer_out <= buffer_in;
			
		if (bubble == 1'b1)
			insert_bubble_next <= 1'b1;
	
	end
endmodule

		