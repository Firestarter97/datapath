module data_memory ( 
input MemWrite, MemRead, clk, rst, MemSize, MemD,
input [15:0]ReadAddr, WriteAddr,
input [15:0] writeData,
output reg [15:0] readData
);
					   
reg [7:0] data [9:0];
integer raddr, waddr;
 
always @(posedge clk, negedge rst)
 begin
	if (!rst) 
	begin
		data[0] <= 8'h38; data[1] <= 8'h56;
		data[2] <= 8'h00; data[3] <= 8'h00;
		data[4] <= 8'h43; data[5] <= 8'h12;
		data[6] <= 8'hBE; data[7] <= 8'hDE;
		data[8] <= 8'hAD; data[9] <= 8'hEF;
    end
end

always @(posedge clk) begin
	if(MemSize == 1'b1 && MemD == 1'b1) 
	begin
              raddr <= ReadAddr;
              waddr <= WriteAddr;
	end
	else if (MemSize == 1'b0 && MemD == 1'b0)
	begin
			raddr <= ReadAddr[7:0];
            waddr <= WriteAddr[7:0];
	end
end
	
always @(negedge clk) begin	
    if(MemRead) 
	begin
		if (MemSize == 1'b1 && MemD == 1'b1)
			readData <= {data[raddr[15:8]+1],data[raddr[7:0]]};
		else if (MemSize == 1'b0 && MemD == 1'b0)
			readData <= {8'h00,data[raddr]};
	end
end

always @(posedge clk) begin
    if(MemWrite) begin
		data[waddr] <= writeData[7:0];
		data[waddr+1] <= writeData[15:8];
	end
end
endmodule

