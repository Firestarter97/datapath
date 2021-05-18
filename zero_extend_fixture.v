`include "zero_extend.v"

module zero_extend_fixture;
    reg [7:0] before_zero_extend;
    wire [15:0] after_zero_extend;

initial
    $monitor($time, " ns, before_zero_extend=%b, after_zero_extend=%b\n", before_zero_extend, after_zero_extend);

zero_extend zeroextend_instance (.before_zero_extend(before_zero_extend), .after_zero_extend(after_zero_extend));
	
initial begin
        //Initialize values to zero
		before_zero_extend = 8'h00;
        	
#10;	before_zero_extend = 8'h01;
#10;	before_zero_extend = 8'h11;
#10;	before_zero_extend = 8'h10;
#10 $finish;
end
endmodule

