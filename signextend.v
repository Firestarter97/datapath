module signextend #(parameter N=4)(
    input signed [N-1:0] A,
    output reg [15:0] B
    );

always @(*) begin
        B = {{16-N{A[N-1]}},A[N-1:0]};
end
endmodule