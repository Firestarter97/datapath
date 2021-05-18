module mux_2param #(parameter N=2, X = 16)
(
    input [X-1:0] A,B,C,D,
	input [1:0] s,
    output reg [X-1:0] out
    );
    
always @(*) begin
      case(N)
		3'b001 : begin
					if( s == 2'b00 )
						out = out;
					else
						out = A;
				end
	  
        3'b010 : begin
					if( s == 2'b00 )
						out = A;
					else
						out = B;
				end
				
		3'b011 :	begin
					if ( s == 2'b01 )
						out = B;
					else if (s == 2'b10)
						out = C;
					else if (s == 2'b11)
						out = D;
				end
				
		3'b100 :	begin
					if (s == 2'b00)
						out = A;
					else if (s == 2'b01)
						out = B;
					else if (s == 2'b10)
						out = C;
					else if (s == 2'b11)
						out = D;
				end
      endcase 
end
endmodule
