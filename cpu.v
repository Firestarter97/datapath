`include "signextend.v"
`include "zero_extend.v"
`include "myand.v"
`include "myor.v"
`include "pc.v"
`include "instruction_mem.v"
`include "ALU_Control.v"
`include "Comparator.v"
`include "FU.v"
`include "HDU.v"
`include "ALU.v"
`include "Add_2.v"
`include "Adder.v"
`include "shiftleft1.v"
`include "Register_File.v"
`include "Buffer.v"
`include "CAUSE_EPC.v"
`include "data_memory.v"
`include "mux_2param.v"
`include "Control_unit.v"

module cpu(
input clock,reset
);

reg bubble = 1'b0;
wire [15:0] pcAddtwo, branchjumpaddr;
//wires for Main ALU
wire signed [15:0] imdd,Op1,Op2,result,R0;
wire [2:0] alu_control_out;
wire Zero, Pos, Neg;
//wires for ALU Control
wire [1:0] ALUOP;
wire [2:0] ALU_Control;

//wires for IF_ID_BUFFER
wire IF_ID_Write;
wire [15:0] PC_PLUS2;
wire [15:0] Current_Instruction;
wire [584:0] IF_ID_buffer_in;
wire [584:0] IF_ID_buffer_out;
wire [15:0] PC_PLUS2_out;
wire IF_Flush;

//wires for ID_EX_BUFFER
wire [15:0] ADDER2_result, ADDER2_result_out, ADD_result_1;
wire [3:0] Function_code;
wire [15:0] Current_Instruction_out;
wire [15:0] ALU_result;
wire [136:0] ID_EX_buffer_in;
wire [136:0] ID_EX_buffer_out;
wire [15:0] ALU_result_out;
wire [15:0] JumpAddress;
wire [24:0] WB_Control_Signals;

//wires for EX_MEM_BUFFER
wire [15:0] WB_MUX_OUT;
wire [120:0] EX_MEM_buffer_in;
wire [120:0] EX_MEM_buffer_out;
wire signed [15:0]  Result;
wire [1:0] ForwardA,ForwardB;

//wires for MEM_WB_BUFFER
wire [15:0] ADD_result;
wire [40:0] MEM_WB_buffer_in;
wire [40:0] MEM_WB_buffer_out;
wire [15:0] ReadData, ReadData_wb;

wire w_en = 1'b1; // Enable for all Buffers besides IF_ID

//MUX WIRES
wire [15:0] PC; //MUX 2
wire [15:0] MUX1_out;
wire [24:0] MUX3_out ,MUX5_out, MUX6_out;
wire [15:0] MUX4_out, MUX7_out, MUX8_out, MUX9_out, MUX10_out, MUX11_out, MUX12_out;
wire MUX13_out;

//And wire
wire PC_source;

//wires for Control Unit
wire [15:12] Opcode;
wire [24:0] Control_unit_out;
wire [1:0] WhichFlush;
wire ID_Flush, EX_Flush;
//wires for shiftleft1 in second stage
wire [11:0] shift_left1_input_second_stage;
wire [15:0] shift_left1_out_second_stage;
wire [15:0] shift_left1_out_third_stage;


wire signed [15:0] Read_Data_1_out, Read_Data_2_out;
wire [15:0] ALU_result_1_out, Sign_Extend_Immed_out;
wire [3:0] Register_RS_out, Register_RT_out;


wire [24:0] MUX5_IDEX_out,  MUX6_IDEX_out, WBCS, MCS;
wire [15:0] Adder2_result_exmem; 

wire [15:0] Result_exmem, MUX7_out_exmem;
wire [3:0] Register_RT_out_exmem, Register_RT_wb; 

wire [15:0]  Mem_address_wb, Memory_output_WB;
wire WB_RegWrite,WB_MemtoReg;

wire Jump;
wire [24:0] WBCS_exmem, MCS_exmem;
wire signed [15:0] R0_out;
wire instr_mem_wr_enable = 1'b1;

wire [15:0] se4_16_out, se12_16_out, se8_16_out;
wire [15:0] ZeroExtend1;

wire Cause;
wire [15:0] EPC;

wire [15:0] Memory_output_WB_ZE;

wire [15:0] MUX4_out_ID_EX;
wire Exception_Type;

wire [24:0] All_Control_Signals;

wire [15:0] Read_Data_1, Read_Data_2, shift_left1_out_ID_EX;
wire [1:0] Exception_Caught;
wire decodeflush_sel;
wire stall, PC_EN;
wire [15:0] instruction_IF_ID_IN, instruction_IF_ID_OUT;
//so we take the 2 most significant bits, truncate them on the right side and then we take the least one significant bit and truncate them on the left side.



//First stage -----Instruction Fetch//////////////////////////////////////////////////////////////////////

//MUX1
mux_2param #(.N(2), .X(16)) mux1(.A(MUX11_out), .B(16'h8000), .C(16'hxxxx), .D(16'hxxxx), .s(Exception_Caught), .out(MUX1_out));
//MUX2 DEMUX
//mux_2param #(.N(1), .X(16)) mux2(.A(instruction), .B(16'hxxxx), .C(16'hxxxx), .D(16'hxxxx), .s({{1'b0,All_Control_Signals[24]}}), .out(PC));


//Program Counter
pc Program_Counter(.clk(clock),.reset(reset),.pcsignal(!PC_EN), .pcin(MUX1_out), .pcout(instruction_IF_ID_IN));

//Instruction Memory
instruction_mem #(.WIDTH(16)) instructionmem_instant (.in(instruction_IF_ID_OUT), .wr_enable(instr_mem_wr_enable),.clock(clock),.reset(reset),.out(Current_Instruction));

//Add2_to_PC
Add_2 Add_2_PC(.A(instruction_IF_ID_IN), .R(PC_PLUS2));

/////////////////////////////////////////////////////////////
//Second Stage ------ Instruction Decode///////////////////////

//Registers
Register_File Register_File_instance (.clock (clock), .reset(reset),.Reg1(Current_Instruction_out[11:8]),.Reg2(Current_Instruction_out[7:4]),.WriteData(MUX12_out),.ReadData1(Read_Data_1),.ReadData2(Read_Data_2), .regwrite(WBCS_exmem[10]));


// Comparator
Comparator #(.BIT_WIDTH(16)) compareOps(.dataIn({Read_Data_1,Read_Data_2}), .equal(equal));

//Control Unit
Control_unit Main_control(.opcode(Current_Instruction_out[15:12]), .out(All_Control_Signals), .WhichFlush(WhichFlush), .IF_FLUSH(IF_Flush), .ID_FLUSH(ID_Flush), .EX_FLUSH(EX_Flush));

//OR gate
myor myor1(.A(stall), .B(ID_Flush), .C(decodeflush_sel));
myor myor2(.A(PC_Enable), .B(!All_Control_Signals[23]), .C(PC_EN));

//mux3
mux_2param #(.N(2), .X(25)) mux3(.A(All_Control_Signals),.B({{25{1'b0}}}),.C({{25{1'bx}}}),.D({{25{1'bx}}}),.s({{1'b0,decodeflush_sel}}),.out(MUX3_out));

//mux4
mux_2param #(.N(2), .X(16)) mux4(.A(se12_16_out),.B(se8_16_out),.C({16{1'bx}}),.D({16{1'bx}}),.s({{1'b0, All_Control_Signals[7]}}),.out(MUX4_out));

//shift-left1
shiftleft1 #(.sizeof_input(15),.sizeof_output(16)) shiftleft1(.shift_left1({{Current_Instruction_out[15:13],Current_Instruction_out[11:0]}}), .out(shift_left1_out_second_stage));

//shift-left1_MUX4_out_ID_EX
shiftleft1 #(.sizeof_input(16),.sizeof_output(16)) shiftleft1_2(.shift_left1(MUX4_out),.out(shift_left1_out_ID_EX));


//Hazard Detection Unit///////////////////////
HDU HDU_Unit(.Opcode(Current_Instruction_out[15:12]),.ID_EX_MemRead(WB_Control_Signals[18]),.equal(equal),.ID_EX_RT(Current_Instruction[11:8]),.ID_EX_RS(Current_Instruction[7:4]),.IF_ID_RS(Current_Instruction_out[7:4]),.IF_ID_RT(Current_Instruction_out[11:8]),.ALU_Result(Result),.R0(R0),.IF_ID_Write(IF_ID_Write),.stall(stall),.Exception_Caught(Exception_Caught),.PC_Enable(PC_Enable),.Cause(Cause),.WhichFlush(WhichFlush), .Op1(Op1), .Op2(Op2), .EX_MEM_RT(Register_RT_out_exmem), .EX_MEM_RegWrite(WBCS_exmem[10]),.ID_EX_RegWrite(WB_Control_Signals[10]));
//Sign Extensions
signextend #(.N(4)) signextend_4_16 (.A(Current_Instruction_out[3:0]), .B(se4_16_out));
signextend #(.N(12)) signextend_12_16 (.A(Current_Instruction_out[11:0]), .B(se12_16_out));
signextend #(.N(8)) signextend_8_16 (.A(Current_Instruction_out[7:0]), .B(se8_16_out));
//Adder2_result
Adder Adder2 (.A(PC_PLUS2_out),.B(shift_left1_out_ID_EX), .R(ADDER2_result));
//MUX5
mux_2param #(.N(2), .X(25)) mux5(.A(MUX3_out),.B({25{1'b0}}),.C({25{1'b0}}),.D({25{1'b0}}),.s({1'b0,EX_Flush}),.out(MUX5_out));
//MUX6
mux_2param #(.N(2), .X(25)) mux6(.A(MUX3_out),.B({25{1'b0}}),.C({25{1'b0}}),.D({25{1'b0}}),.s({1'b0, All_Control_Signals[6]}),.out(MUX6_out));
	



//////////////////////////////////////////
///Third Stage - Instruction Execute/////

//Main ALU
ALU ALU_MAIN(.alu_control_out(ALU_Control),.immd(MUX9_out),.Op1(MUX7_out),.Op2(MUX9_out),.Pos(Pos),.Neg(Neg),.Result(Result), .R0(R0));
//ALU Control
ALU_Control ALUCONTROL(.ALUOP(WB_Control_Signals[12:11]), .function_code(Function_code), .ALU_Control(ALU_Control));

//MUX7
mux_2param #(.N(4),.X(16)) mux7(.A(Read_Data_2_out),.B(Read_Data_1_out),.C(MUX12_out),.D(MUX7_out_exmem),.s(ForwardA),.out(MUX7_out));

//MUX8///////////////////////////changed B from Read_Data_1_out to Sign_Extend_Immed_out, changed C from se4_16_out to MUX4_out_ID_EX////HEEEEEEEEEEEEEEEERRRRRRRRRREEEEEEEE///////////////
mux_2param #(.N(4),.X(16)) mux8(.A(Read_Data_2_out),.B(Sign_Extend_Immed_out),.C(MUX4_out_ID_EX),.D(ZeroExtend1),.s(WB_Control_Signals[14:13]),.out(MUX8_out));

//MUX9
mux_2param #(.N(4),.X(16)) mux9(.A(16'hxxxx),.B(MUX8_out),.C(MUX12_out),.D(MUX7_out_exmem),.s(ForwardB),.out(MUX9_out));


//ZeroExtend1
zero_extend zeroextend_instance1(.before_zero_extend(Read_Data_2_out[7:0]), .after_zero_extend(ZeroExtend1));

//Forwarding Unit
FU FORWARDING_UNIT(.EX_MEM_RegWrite(WBCS_exmem[10]), .MEM_WB_RegWrite(WB_RegWrite), .SwapOp(WB_Control_Signals[24]), .EX_MEM_RegisterRT(Register_RT_out_exmem), .ID_EX_RegisterRS(Current_Instruction_out[7:4]), .MEM_WB_RegisterRT(Register_RT_wb), .ForwardA(ForwardA), .ForwardB(ForwardB), .ID_EX_RegisterRT(Current_Instruction_out[11:8]));

//myand
myand a1(.A(WB_Control_Signals[20]), .B(MUX13_out), .C(PC_source));

//MUX10
mux_2param #(.N(2), .X(16)) mux10(.A(ADDER2_result_out),.B(ADD_result_1),.C({16{1'bx}}),.D({16{1'bx}}),.s({{1'b0, PC_source}}),.out(MUX10_out));
//MUX11
mux_2param #(.N(2), .X(16)) mux11(.A(MUX10_out),.B(JumpAddress),.C({16{1'bx}}),.D({16{1'bx}}),.s({{1'b0,WB_Control_Signals[20]}}),.out(MUX11_out));
//MUX13
mux_2param #(.N(3), .X(1)) mux13(.A(equal),.B(Pos),.C(Neg),.D(1'bx),.s(WB_Control_Signals[23:22]),.out(MUX13_out));

//Cause_EPC
CauseEpc CAUSE_EPC (.ALU_result1(ADD_result_1),.Exception_Type(Exception_Type),.EPC(EPC),.Cause(Cause));

//////////////////////////////////////////
///Fourth Stage - Data Memory
data_memory data_memory_instant (.MemWrite(WBCS_exmem[17]),.MemRead(WBCS_exmem[18]),.ReadAddr(MUX7_out_exmem),.WriteAddr(Result_exmem),.clk(clock),.rst(reset),.writeData(MUX7_out_exmem),.readData(ReadData),.MemSize(WBCS_exmem[16]),.MemD(WBCS_exmem[15]));


///Fifth Stage - Write back///////////////
zero_extend zeroextend_instance2(.before_zero_extend(ReadData[7:0]), .after_zero_extend(Memory_output_WB_ZE));

//MUX12
mux_2param #(.N(3),.X(16)) mux12(.A(Mem_address_wb),.B(ReadData_wb),.C(Memory_output_WB_ZE),.D(16'hxxxx),.s({1'b0,WB_MemtoReg}),.out(MUX12_out));



//Buffer Instances//////////////////////
//If_ID_Buffer
Buffer #(.N(48)) IF_ID_BUFFER(
		.clk(clock),
		.reset(!IF_Flush),
		.w_en(IF_ID_Write),
		.bubble(bubble),
        .buffer_in({PC_PLUS2 , instruction_IF_ID_IN,Current_Instruction }),
        .buffer_out({PC_PLUS2_out, instruction_IF_ID_OUT, Current_Instruction_out})    
        );
//ID_EX_Buffer
Buffer #(.N(199)) ID_EX_BUFFER(
		.clk(clock),
		.reset(reset),
		.w_en(w_en),
		.bubble(bubble),
        .buffer_in({MUX5_out, MUX6_out, shift_left1_out_second_stage, PC_PLUS2_out, MUX3_out, ADDER2_result, Read_Data_1, Read_Data_2,se4_16_out ,Current_Instruction_out[7:4], Current_Instruction_out[11:8], Current_Instruction_out[3:0],MUX4_out}),
        .buffer_out({MUX5_IDEX_out, MUX6_IDEX_out, JumpAddress,ADD_result_1, WB_Control_Signals, ADDER2_result_out, Read_Data_1_out, Read_Data_2_out, Sign_Extend_Immed_out, Register_RS_out, Register_RT_out, Function_code,MUX4_out_ID_EX})    
        );
//EX_MEM_Buffer
Buffer #(.N(102)) EX_MEM_BUFFER(
		.clk(clock),
		.reset(reset),
		.w_en(w_en),
		.bubble(bubble),
        .buffer_in({MUX5_IDEX_out, MUX6_IDEX_out, Result, R0, MUX7_out, Register_RT_out}),
        .buffer_out({WBCS_exmem, MCS_exmem, Result_exmem, R0_out, MUX7_out_exmem, Register_RT_out_exmem})    
        );
//MEM_WB_Buffer
Buffer #(.N(38)) MEM_WB_BUFFER(
		.clk(clock),
		.reset(reset),
		.w_en(w_en),
		.bubble(bubble),
        .buffer_in({WBCS_exmem[10],WBCS_exmem[9],ReadData, MUX7_out_exmem, Register_RT_out_exmem}),
        .buffer_out({WB_RegWrite,WB_MemtoReg,ReadData_wb, Mem_address_wb, Register_RT_wb})    
        );
		
endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



 
 
 
 
 
 













