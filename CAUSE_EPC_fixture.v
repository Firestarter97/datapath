`include "CAUSE_EPC.v"
module CauseEpc_fixture;

reg [15:0] ALU_result1;
reg Exception_Type;

wire [15:0] EPC;
wire Cause;


initial
    $monitor($time, " ns, ALU_result1=%h Exception_Type=%b EPC=%h Cause=%b", ALU_result1, Exception_Type, EPC, Cause);

CauseEpc INSTANE (
 .ALU_result1(ALU_result1),
 .Exception_Type(Exception_Type),
 .EPC(EPC),
 .Cause(Cause)
 );
	
initial begin
        //Initialize values to zero
		ALU_result1= 16'h0000; Exception_Type=1'b0;
#10;	ALU_result1= 16'hAB00; Exception_Type=1'b1;
#10;	ALU_result1= 16'h00CD; Exception_Type=1'b1;
#10;	ALU_result1= 16'hFFFF; Exception_Type=1'b0;


#10 $finish;
end
endmodule