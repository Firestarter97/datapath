module Register_File (
	input [3:0] Reg1,Reg2,
	input [15:0] WriteData,
	input regwrite, clock, reset, 
	output reg [15:0] ReadData1, ReadData2
	);
	reg [15:0] Register [15:0];
	
	integer i;
	
	always@(posedge clock, negedge reset) begin
		if (!reset) begin
				Register[0] <= 16'h0000;
				Register[1] <= 16'h7B18;
				Register[2] <= 16'h246B;
				Register[3] <= 16'hFF0F;
				Register[4] <= 16'hF0FF;
				Register[5] <= 16'h0051;
				Register[6] <= 16'h6666;
				Register[7] <= 16'h00FF;
				Register[8] <= 16'hFF88;
				Register[9] <= 16'h0000;
				Register[10] <= 16'h0000;
				Register[11] <= 16'h3099;
				Register[12] <= 16'hCCCC;
				Register[13] <= 16'h0002;
				Register[14] <= 16'h0011;
				Register[15] <= 16'h0000;
		end
		else if (regwrite)
				Register[Reg1] <= WriteData;
	end
	
	
	always@(negedge clock)
	begin
		ReadData1 <= Register[Reg1];
		ReadData2 <= Register[Reg2];
	end
	
	
	
endmodule