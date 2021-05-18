`include "mux_2param.v"
module mux_2param_fixture;
    reg [15:0] A,B,C,D;
	reg [1:0] s;
	
    wire [15:0] out;

initial
    $monitor($time, " ns, A=%h,B=%h,C=%h,D=%h, s=%b, out=%h", A,B,C,D,s,out );

mux_2param #(.N(1), .X(16)) mux_instance (
.A(A),
.B(B),
.C(C),
.D(D),
.s(s),
.out(out)
 );
	
initial begin

	
		A = 16'h0000; B = 16'h0000; C = 16'h0000; D = 16'h0000; s= 2'b00;
		
//Test N(1) case for DEMUX 
#10;	A = 16'hBBBB; s=2'b01;

#10;	A = 16'h0000; s=2'b00;

#10;	A = 16'hCCCC; s=2'b01;

#10;	A = 16'hFFFF; s=2'b00;
		
		
	
		
// Test N(2) case for 2_MUX 
//#10;	A = 16'hAAAA; B = 16'hBBBB; C = 16'h0000; D = 16'h0000; s= 2'b00;
//#10;	A = 16'hAAAA; B = 16'hBBBB; C = 16'h0000; D = 16'h0000; s= 2'b01;		
		
		
		
// Test 3-input case (D is picked when (S=00 || S=11)
/*
#10; 	B = 16'hBBBB; C = 16'hCCCC; D = 16'hDDDD; s= 2'b00;
#10; 	s= 2'b01;
#10; 	s= 2'b10;
#10; 	s= 2'b11;	
		
*/
	
// Test 4-input case 
/*
#10; 	A = 16'hAAAA; B = 16'hBBBB; C = 16'hCCCC; D = 16'hDDDD; s= 2'b00;
#10; 	s= 2'b01;
#10; 	s= 2'b10;
#10; 	s= 2'b11;	
		
*/
		

#10 $finish;
end
endmodule