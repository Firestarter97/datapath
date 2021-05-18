 `include "pc.v"

 module pc_fixture;
  reg clk, reset,pcsignal;
  reg [15:0]pcin;
  wire[15:0]pcout;

 initial 
   $vcdpluson;
 initial
     $monitor($time, "ns, clk=%b, reset=%b, pcsignal=%b, pcin=%h, pcout=%h",clk, reset,pcsignal,pcin,pcout);
   

     pc u1 (.clk(clk), .reset(reset),.pcsignal(pcsignal), .pcin(pcin), .pcout(pcout));
 initial
 begin
   clk = 1'b0;
   forever #5 clk= !clk;
 end
 initial
 begin
       reset = 1'b0;
   #10 reset = 1'b1;
   #5  reset= 1'b0; 
 end
 initial
 begin
 // #15 reset =1'b0;
  pcin= 1'b0; pcsignal = 1'b0;
  @(posedge clk); pcin = 16'h1212; pcsignal = 1'b1;
  @(posedge clk); pcin = 16'h2222; pcsignal = 1'b0;
  @(posedge clk); pcin = 16'haaaa; pcsignal = 1'b1;
  @(posedge clk); pcin = 16'h2345; pcsignal = 1'b0;
  @(posedge clk); pcin = 16'hafaf; pcsignal = 1'b1;
  reset = 1'b1;
  #10 $finish;
 end
 endmodule
  
