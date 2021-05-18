 

  module pc (input [15:0]pcin,
             input reset, clk,pcsignal, 
             output reg [15:0]pcout );

  initial 
  begin
     pcout <= 16'h0000;
  end

  always@(posedge clk)
  begin
     if (!reset)
      begin
         pcout <= 16'h0000;
      end
     else if (pcsignal== 1'b1)
           begin
             pcout <=pcin;
           end
     else 
       begin
         pcout <= pcout;
       end
  end
endmodule
