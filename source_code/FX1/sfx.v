module sfx(
  input [0:127] ra,
  input [0:127] rb,
  input [0:127] rt,

  output reg [0:127] result
);
integer j;
always @(*) begin
  for(j = 0 ; j < 4 ; j = j + 1) begin
    result[j*32 +:32] = rb[j*32 +:32] - ~(ra[j*32 +:32]) + rt[(j*32)+31];
  end
end
endmodule