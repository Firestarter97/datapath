`include "shiftleft1.v"

module shiftleft1_fixture;
    reg [11:0]  shift_left1;
    wire [12:0] out;

initial
    $monitor($time, " ns, shift_left1=%b, out=%b\n", shift_left1, out);

shiftleft1 #(.sizeof_input(12)) shift_left1_instance (.shift_left1(shift_left1), .out(out));
	
	integer i;
initial begin
        //Initialize values to zero
		shift_left1 = 12'h000;

        for(i=0;i<128; i=i+1) begin
		#10 	shift_left1 = i;
		end

#10 $finish;
end
endmodule