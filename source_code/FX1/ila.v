module ila(
  input [0:17] imme,

  output reg [0:127] result
);
integer j;
reg [0:31] t;
always @(*) begin
  t = {14'b0, imme};
  for(j = 0 ; j < 4 ; j = j + 1) begin
    result[j*32 +:32] = t;
  end
end
endmodule