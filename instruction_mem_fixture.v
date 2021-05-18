`include "instruction_mem.v"
module instruction_mem_fixture;

reg clk, rst, w_en;
reg  [15:0] datain;
wire [7:0] dataout;


initial
	$vcdpluson;

initial 
	$monitor ($time, " datain = %h w_enable %b dataout = %h", datain, w_en,  dataout);
	

instruction_mem #(.WIDTH(16)) instructionmem_instant (
        .in (datain),
        .wr_enable(w_en),        
        .clock(clk),
        .reset(rst),
        .out(dataout)       
        );

initial
begin
	clk = 1'b0;
	forever #10 clk = ! clk;
end

initial
begin
	 	rst = 1'b1;
       #2	rst = 1'b0;
end
initial begin

	#10 datain = 8'h00; w_en = 1'b0; rst = 1'b1;
	
	@(posedge clk); datain = 8'h00; w_en = 1'b0;
	@(posedge clk); datain = 8'h00; w_en = 1'b0;
	@(posedge clk); datain = 8'h00; w_en = 1'b1;
	@(posedge clk); datain = 8'h01; w_en = 1'b1;
	@(posedge clk); datain = 8'h02; w_en = 1'b1;
	@(posedge clk); datain = 8'h03; w_en = 1'b1;
	@(posedge clk); datain = 8'h04; w_en = 1'b1;
	@(posedge clk); datain = 8'h05; w_en = 1'b1;
	@(posedge clk); datain = 8'h06; w_en = 1'b1;
	@(posedge clk); datain = 8'h07; w_en = 1'b1;
	@(posedge clk); datain = 8'h08; w_en = 1'b1;
	@(posedge clk); datain = 8'h09; w_en = 1'b1;
	@(posedge clk); datain = 8'h0A; w_en = 1'b1;
	@(posedge clk); datain = 8'h0B; w_en = 1'b1;
	@(posedge clk); datain = 8'h0C; w_en = 1'b1;
	@(posedge clk); datain = 8'h0D; w_en = 1'b1;
	@(posedge clk); datain = 8'h0E; w_en = 1'b1;
	@(posedge clk); datain = 8'h0F; w_en = 1'b1;
	
	@(posedge clk); datain = 8'h10; w_en = 1'b1; 
	
	@(posedge clk) rst = 1'b0; datain = 8'h11; w_en = 1'b1;
	@(posedge clk) rst = 1'b1; datain = 8'h11; w_en = 1'b1;
	@(posedge clk) rst = 1'b1; datain = 8'h00; w_en = 1'b1;


        #10     $finish;

end
endmodule

