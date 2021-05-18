module Control_unit
(
    input [15:12] opcode,
	input [1:0] WhichFlush,
	output reg IF_FLUSH, ID_FLUSH, EX_FLUSH,
    output reg [24:0] out
    );

always @(*) begin
	  case(WhichFlush)
		2'b00 : begin IF_FLUSH = 1'b1; ID_FLUSH = 1'b0; EX_FLUSH = 1'b0;
				end
		2'b01 : begin IF_FLUSH = 1'b0; ID_FLUSH = 1'b1; EX_FLUSH = 1'b0;
				end
		2'b10 : begin IF_FLUSH = 1'b0; ID_FLUSH = 1'b0; EX_FLUSH = 1'b1;
				end
				
		default : begin IF_FLUSH = 1'b0; ID_FLUSH = 1'b0; EX_FLUSH = 1'b0;
				end
		endcase
end

always @(*) begin
      case(opcode)
		4'b1111 : out = 25'b0xxx00000000001000xxx1111;	
		4'b0001 : out = 25'b0xxx000000xx011000xxx0001;	
		4'b0010 : out = 25'b0xxx00000000001000xxx0010;	
		4'b1010 : out = 25'b1xxx00101001111100xxx1010;	
		4'b1011 : out = 25'b1xxx0001001011000xxxx1011;	
		4'b1100 : out = 25'b1xxx0010110011101xxxx1100;	  
		4'b1101 : out = 25'b1xxx0001110111000xxxx1101;
		4'b0101 : out = 25'b0x100100xx10110001xxx0101;
		4'b0100 : out = 25'b0x010100xx10110001xxx0100;
		4'b0110 : out = 25'b0x000100xx10110001xxx0110;	
		4'b0111 : out = 25'b0xxx1000xxxx11000xxxx0111;	
		4'b0000 : out = 25'b01xxxxxxxxxxxxxxxxxxx0000;	
      endcase 
	end
endmodule
