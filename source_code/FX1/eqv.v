module eqv(
  input [0:127] ra,
  input [0:127] rb,

  output reg [0:127] result
);
integer j;

always @(*) begin
  for (j = 0; j < 4; j = j + 1) begin
    // Perform bitwise XOR with bitwise NOT of RB
    result[j*32 +: 32] = ra[j*32 +: 32] ^ ~rb[j*32 +: 32];
  end
end
  

endmodule