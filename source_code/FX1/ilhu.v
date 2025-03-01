module ilhu(
  input [0:15] imme,

  output [0:127] result
);
integer j;
reg [0:31] t;
always @(*) begin
  t = {imme, 16'b0};
  for(j = 0 ; j < 4 ; j = j + 1) begin
    result[j*32 +:32] = t;
  end
end