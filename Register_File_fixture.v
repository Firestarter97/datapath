`include "Register_File.v"
module Register_File_fixture;

reg clock, reset, regwrite;
reg [3:0] Reg1, Reg2;
reg  [15:0] WriteData;
wire [15:0] ReadData1, ReadData2;

initial
	$vcdpluson;

initial 
begin
	$monitor($time, " Reset = %h regwrite = %h dataout = %h  datain = %h ReadData1 = %h ReadData2 = %h WriteData = %h", reset, regwrite,  Reg1, Reg2, ReadData1, ReadData2, WriteData);

end
Register_File Register_File_instance (
        .clock (clock), 
        .reset(reset),        
        .Reg1(Reg1),
        .Reg2(Reg2),
        .WriteData(WriteData),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)		
        );

initial
begin
	clock = 1'b0;
	forever #10 clock =! clock;
end

initial
begin
	 	reset = 1'b1;
       #2	reset = 1'b0;
end
initial begin

	#10 Reg1 = 4'h0; Reg2 = 4'h0; WriteData = 16'h0000; regwrite = 1'b0; reset = 1'b1;
	
	@(posedge clock); Reg1 = 4'h1; Reg2 = 4'h0; WriteData = 16'h0000; regwrite = 1'b1;
	@(posedge clock); Reg1 = 4'h0; Reg2 = 4'h1; WriteData = 16'h0001; regwrite = 1'b1;
	@(posedge clock); Reg1 = 4'h1; Reg2 = 4'h1; WriteData = 16'h0010; regwrite = 1'b1;
	@(posedge clock); Reg1 = 4'h1; Reg2 = 4'h1; WriteData = 16'h0F00; regwrite = 1'b1;
	@(posedge clock); Reg1 = 4'h0; Reg2 = 4'h0; WriteData = 16'h00F0; regwrite = 1'b1;
	@(posedge clock); Reg1 = 4'h0; Reg2 = 4'h1; WriteData = 16'h2222; regwrite = 1'b1;
	@(posedge clock); Reg1 = 4'h1; Reg2 = 4'h0; WriteData = 16'hFFFF; regwrite = 1'b1;
	@(posedge clock); Reg1 = 4'h1; Reg2 = 4'h1; WriteData = 16'h1111; regwrite = 1'b1;


        #10     $finish;

end
endmodule

