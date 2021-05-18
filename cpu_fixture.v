`include "cpu.v"

module cpu_fixture;

reg clk, rst;
integer total_clk_cycles;

initial
	$vcdpluson;
	
cpu CPU(.clock(clk),.reset(rst));


always@(negedge clk) begin
	$display ("\n\n\n Total Clock cycles=%d rst=%h", total_clk_cycles, rst);
	$display ("////////////////Instruction Fetch Stage/////////////////");
	$display ("////////////////IF_ID_BUFFER INPUTS/////////////////////");
	$display ("Current_Instruction                   =%h", CPU.Current_Instruction);
	$display ("ID/ID Enable signal:                  =%h", CPU.IF_ID_Write);
	$display ("PC_PLUS2                              =%h", CPU.PC_PLUS2);
	$display ("IF_Flush                              =%h", CPU.IF_Flush);
	$display ("/////////IF_ID_BUFFER OUTPUTS//////");
	$display ("Current_Instruction_out               =%h", CPU.Current_Instruction_out);
	$display ("PC_PLUS2_out                          =%h", CPU.PC_PLUS2_out);
	$display ("MUX11_out                          	=%h", CPU.MUX11_out);
	$display ("MUX1_OUT                         	=%h", CPU.MUX1_out);
	$display ("////////////////Instruction Decode Stage////////////////////////////////////////////");
	$display ("////////////////ID_EX_BUFFER INPUTS/////////////////////////////////////////////////");
	$display ("MUX5_out=%h, MUX6_out=%h, shift_left1_out_second_stage=%h, PC_PLUS2_out=%h", CPU.MUX5_out, CPU.MUX6_out, CPU.shift_left1_out_second_stage, CPU.PC_PLUS2_out);
	$display ("MUX3_out=%h, ADDER2_result=%h, Read_Data_1=%h, Read_Data_2=%h, Sign_Extend_Immed=%h", CPU.MUX3_out, CPU.ADDER2_result,CPU.Read_Data_1, CPU.Read_Data_2, CPU.se4_16_out);
	$display ("Current_Instruction_out[7:4]=%h, Current_Instruction_out[11:8]=%h", CPU.Current_Instruction_out[7:4], CPU.Current_Instruction_out[11:8]);
	$display ("Current_Instruction_out[3:0]=%h,MUX4_out=%h",CPU.Current_Instruction_out[3:0],CPU.MUX4_out);
	$display ("All_Control_Signals=%h",CPU.All_Control_Signals);
	$display ("WhichFlush=%b Opcode=%b",CPU.WhichFlush, CPU.Current_Instruction_out[15:12]);
	$display ("////////////////ID_EX_BUFFER OUTPUTS/////////////////////////////////////////////////");
	$display ("MUX5_IDEX_out=%h, MUX6_IDEX_out=%h, JumpAddress=%h,ADD_result_1=%h, WB_Control_Signals=%h, ADDER2_result_out=%h, Read_Data_1_out=%h, Read_Data_2_out=%h", CPU.MUX5_IDEX_out, CPU.MUX6_IDEX_out, CPU.JumpAddress,CPU.ADD_result_1, CPU.WB_Control_Signals, CPU.ADDER2_result_out, CPU.Read_Data_1_out, CPU.Read_Data_2_out);
	$display ("Sign_Extend_Immed_out=%h, Register_RS_out=%h, Register_RT_out=%h, Function_code=%b,MUX4_out_ID_EX=%h", CPU.Sign_Extend_Immed_out,CPU.Register_RS_out, CPU.Register_RT_out, CPU.Function_code,CPU.MUX4_out_ID_EX);
	
	
	$display ("//////////////////Execute Stage//////////////////////////////////////////////////////");
	
	$display ("MUX7_out=%h, MUX8_out=%h, MUX9_out=%h", CPU.MUX7_out,CPU.MUX8_out, CPU.MUX9_out);
	$display ("////////////////EX_MEM_BUFFER INPUTS/////////////////////////////////////////////////");
	$display ("ALU_Control=%h ALUOP=%b", CPU.ALU_Control,CPU.WB_Control_Signals[12:11]);
	$display ("MUX5_IDEX_out=%h, MUX6_IDEX_out=%h, Result=%h, R0=%h, Register_RT_out=%h", CPU.MUX5_IDEX_out, CPU.MUX6_IDEX_out, CPU.Result, CPU.R0, CPU.Register_RT_out);
	$display ("////////////////EX_MEM_BUFFER OUTPUTS////////////////////////////////////////////////");
	$display ("WBCS_exmem=%h, MCS_exmem=%h, Result_exmem=%h, R0_out=%h, MUX7_out_exmem=%h, Register_RT_out_exmem=%h", CPU.WBCS_exmem, CPU.MCS_exmem, CPU.Result_exmem, CPU.R0_out, CPU.MUX7_out_exmem, CPU.Register_RT_out_exmem);

	$display ("////////////////Memory Access Stage///////////////////////////////////////////////////");
	$display ("////////////////MEM_WB_BUFFER INPUTS//////////////////////////////////////////////////");
	$display ("WBCS_exmem[10]=%h,WBCS_exmem[9]=%h,ReadData=%h", CPU.WBCS_exmem[10], CPU.WBCS_exmem[9],CPU.ReadData);
	$display ("MUX7_out_exmem=%h, Register_RT_out_exmem=%h", CPU.MUX7_out_exmem, CPU.Register_RT_out_exmem);
	$display ("////////////////MEM_WB_BUFFER OUTPUTS//////////////////////////////////////////////////");
	$display ("WB_RegWrite=%h,WB_MemtoReg=%h,ReadData_wb=%h", CPU.WB_RegWrite,CPU.WB_MemtoReg,CPU.ReadData_wb);
	$display ("Mem_address_wb=%h, Register_RT_wb=%h", CPU.Mem_address_wb, CPU.Register_RT_wb);
	$display ("///////////////Error Code Signals///////////////////////////////////////////////////");
	$display ("Exception PC (EPC)=%h, Cause=%b, Halt=%b", CPU.Exception_Type, CPU.Cause, CPU.All_Control_Signals[24]);
	$display ("////////////////////////////////////////////////////////////////////////////////////");
	$display ("////////////////////////////////////////////////////////////////////////////////////");
	$monitor ("Reset = %b /////////////////////", CPU.reset);
end

initial
begin
	clk = 1'b0;
	forever begin
		#10 clk = !clk;
		end
end

initial begin
forever begin
			if (rst == 1'b1 && clk == 1'b1)
			total_clk_cycles = total_clk_cycles + 1;
			end
end

initial
begin
	 	rst = 1'b1;
       #5	rst = 1'b0;
end

initial begin
//Turn reset off (ACTIVE LOW)
		#10   rst = 1'b1;


#1000 $finish;

end
endmodule

