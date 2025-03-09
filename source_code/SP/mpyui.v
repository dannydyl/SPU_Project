module mpyui(
  input [0:127] ra,
  input [0:9] imme10,

  output reg [0:127] result
);
integer j;
reg [0:15] t;

assign t = {{6{imme10[0]}}, imme10[0:9]};

always @(*) begin
  for(j=0 ; j<4 ; j=j+1) begin
    result[32*j +: 32] = ra[32*j+16 +: 16] * t;
  end
end

endmodule