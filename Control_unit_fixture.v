module Control_unit_fixture;
    reg [15:12] opcode;
    wire [23:0] out;
	

initial
    $monitor($time, " ns, opcode=%b, out=%b, opcode, out);

Control_unit Main_control (.opcode(opcode), .out(out));
	
initial begin
        //Initialize values to zero
		opcode = 4'h0;
        	
#10;	opcode = 4'hF;
#10;	opcode = 4'h1;
#10;	opcode = 4'h2;
#10;	opcode = 4'hA;
#10;	opcode = 4'hB;
#10;	opcode = 4'hC;
#10;	opcode = 4'hD;
#10;	opcode = 4'h5;
#10;	opcode = 4'h4;
#10;	opcode = 4'h6;
#10;	opcode = 4'h7;
#10;	opcode = 4'hF;
#10;	opcode = 4'h0;

#10 $finish;
end
endmodule