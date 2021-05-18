`include "signextend.v"

module signextend_fixture;
    reg [7:0] A,B;
    wire [15:0] out;

initial
    $monitor($time, " ns, A=%b, output=%b, A, output);

signextend #(.N(8)) signextend_instance (.A(A), .B(out));
	
initial begin
        //Initialize values to zero
		A = 8'h00; output = 16'h0000;
        	
#10;	A = 8'h0F;
#10;	A = 8'hFF;

#10 $finish;
end
endmodule

