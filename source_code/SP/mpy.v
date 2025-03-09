module mpy(
  input [0:127] ra,
  input [0:127] rb,

  output reg [0:127] result
);
integer j;
reg [0:31] product;

always @(*) begin
  for (j = 0; j < 4; j = j + 1) begin
    product = $signed(ra[j*32+16 +: 16]) * $signed(rb[j*32+16 +: 16]);
    result[j*32 +: 32] = product;
  end
end

endmodule