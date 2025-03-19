module xorhi(
  input [0:127] ra,
  input [0:9] imme,

  output reg [0:127] result
);
integer j;
reg [0:15] t;
always @(*) begin
  t = {{6{imme[0]}}, imme};
  for(j = 0 ; j < 8 ; j = j + 1) begin
    result[j*16 +:16] = ra[j*16 +:16] ^ t;
  end
end

endmodule