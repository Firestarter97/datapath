module instruction_mem #(parameter WIDTH = 16) (
	input [WIDTH-1:0] in,
	input wr_enable,  
	output reg [WIDTH-1:0] out,
	input clock,
	input reset 
	);
	reg [(WIDTH/2)-1:0] mem [0:63];

	always@(posedge clock, negedge reset)
	begin
		if (!reset)
		begin
			mem[0] <= 8'hFE; mem[1] <= 8'h21;
			mem[2] <= 8'hFB; mem[3] <= 8'h22;
			mem[4] <= 8'h23; mem[5] <= 8'h88;
			mem[6] <= 8'h14; mem[7] <= 8'h9A;
			mem[8] <= 8'hF5; mem[9] <= 8'h64;
			mem[10] <= 8'hF1;mem[11] <= 8'h68;
			mem[12] <= 8'h75;mem[13] <= 8'h9A;
			mem[14] <= 8'h28;mem[15] <= 8'h02;
			mem[16] <= 8'hCE;mem[17] <= 8'h9A;
			mem[18] <= 8'hF0;mem[19] <= 8'h02;
			mem[20] <= 8'hF1;mem[21] <= 8'h21;
			mem[22] <= 8'hF1;mem[23] <= 8'h22;
			mem[24] <= 8'h18;mem[25] <= 8'h02;
			mem[26] <= 8'hA6;mem[27] <= 8'h94;
			mem[28] <= 8'hB6;mem[29] <= 8'h96;
			mem[30] <= 8'hC6;mem[31] <= 8'h96;
			mem[32] <= 8'hF7;mem[33] <= 8'hD2;
			mem[34] <= 8'h97;mem[35] <= 8'h02;
			mem[36] <= 8'hFB;mem[37] <= 8'h21;
			mem[38] <= 8'h57;mem[39] <= 8'h05;
			mem[40] <= 8'hFB;mem[41] <= 8'h21;
			mem[42] <= 8'h47;mem[43] <= 8'h02;
			mem[44] <= 8'hF1;mem[45] <= 8'h11;
			mem[46] <= 8'hF1;mem[47] <= 8'h11;
			mem[48] <= 8'hC8;mem[49] <= 8'h90;
			mem[50] <= 8'hF8;mem[51] <= 8'h81;
			mem[52] <= 8'hD8;mem[53] <= 8'h92;
			mem[54] <= 8'hEA;mem[55] <= 8'h92;
			mem[56] <= 8'hFC;mem[57] <= 8'hC1;
			mem[58] <= 8'hFD;mem[59] <= 8'hD2;
			mem[60] <= 8'hFC;mem[61] <= 8'hD1;
			mem[62] <= 8'h00;mem[63] <= 8'h00;
		end
		else
		begin
			if (wr_enable)
			begin
				out[7:0] <= mem[in+1];
				out[15:8] <= mem[in];
			end
		end
	end
endmodule