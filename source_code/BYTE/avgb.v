module avgb(
  input [0:127] ra,
  input [0:127] rb,

  output reg [0:127] result
);
integer j;
reg [0:15] sum;

always @(*) begin
  for (j = 0; j < 16; j = j + 1) begin
    sum = {8'h00, ra[8*j +: 8]} + {8'h00, rb[8*j +: 8]} + 1;
    result[8*j +: 8] = sum[7:14];
  end
end

endmodule