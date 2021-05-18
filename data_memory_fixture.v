  `include "data_memory.v"

module data_memory_fixture;

reg clk, rst, MemWrite, MemRead, MemSize, MemD;
reg  [15:0] ReadAddr, WriteAddr; 
reg  [15:0] writeData;
wire [15:0] readData;


initial
	$vcdpluson;

initial 
	$monitor ($time, "ns \n ReadAddr = %h WriteAddr = %h\n writeData = %h MemWrite= %b MemRead = %b readData = %h MemSize=%h MemD=%h",ReadAddr,WriteAddr, writeData, MemWrite,MemRead,readData, MemSize, MemD);
	

data_memory data_memory_instant (
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .ReadAddr(ReadAddr),
        .WriteAddr(WriteAddr),        
        .clk(clk),
        .rst(rst),
        .writeData(writeData),
        .readData(readData),
		.MemSize(MemSize),
		.MemD(MemD)
        );

initial
begin
	clk = 1'b0;
	forever #10 clk = !clk;
end

initial
begin
	 	rst = 1'b1;
       #2	rst = 1'b0;
end

initial begin
//Set value for first read
  #10   rst = 1'b1;

	@(posedge clk); ReadAddr = 16'h0000; WriteAddr = 16'h0000; MemWrite=1'b1; writeData = 16'hABCD; MemRead = 1'b0; MemSize = 1'b0; MemD=1'b0;
	#10;
	@(negedge clk); ReadAddr = 16'h0000; WriteAddr = 16'h0000; MemWrite=1'b0; writeData = 16'h0000; MemRead = 1'b1; MemSize = 1'b0; MemD=1'b0;
	#10;
	@(posedge clk); ReadAddr = 16'h0000; WriteAddr = 16'h0000; MemWrite=1'b1; writeData = 16'hCFCF; MemRead = 1'b0; MemSize = 1'b0; MemD=1'b0;
	#10;
	@(negedge clk); ReadAddr = 16'h0000; WriteAddr = 16'h0000; MemWrite=1'b0; writeData = 16'h0000; MemRead = 1'b1; MemSize = 1'b0; MemD=1'b0;
	#10;


	@(posedge clk); ReadAddr = 16'h0000; WriteAddr = 16'h0000; MemWrite=1'b1; writeData = 16'hABCD; MemRead = 1'b0; MemSize = 1'b1; MemD=1'b1;
	#10;
	@(negedge clk); ReadAddr = 16'h0000; WriteAddr = 16'h0000; MemWrite=1'b0; writeData = 16'h0000; MemRead = 1'b1; MemSize = 1'b1; MemD=1'b1;
	#10;
	@(posedge clk); ReadAddr = 16'h0000; WriteAddr = 16'h0000; MemWrite=1'b1; writeData = 16'hCFCF; MemRead = 1'b0; MemSize = 1'b1; MemD=1'b1;
	#10;
	@(negedge clk); ReadAddr = 16'h0000; WriteAddr = 16'h0000; MemWrite=1'b0; writeData = 16'h0000; MemRead = 1'b1; MemSize = 1'b1; MemD=1'b1;
	#10;
	

        #10     $finish;

end
endmodule

