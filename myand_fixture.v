`include "myand.v"
module myand_fixture;
    reg A;
	reg B;
    wire C;

initial
    $monitor($time, " ns, A=%b, B=%b, C=%b", A, B, C);

myand a1 (.A(A), .B(B), .C(C));
	
initial begin
        //Initialize values to zero
		A = 1'b0; B = 1'b0;
#10;	A = 1'b0; B = 1'b1;
#10;	A = 1'b1; B = 1'b0;
#10;	A = 1'b1; B = 1'b1;


#10 $finish;
end
endmodule