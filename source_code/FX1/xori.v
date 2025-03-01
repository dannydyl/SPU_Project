module xori(
  input [0:127] ra,
  input [0:9] imme,
  output [0:127] result
);

integer j;
reg [0:31] t;

always @(*) begin
  t = {{22{imme[0]}}, imme};
  for(j = 0 ; j < 4 ; j = j + 1) begin
    result[j*32 +:32] = ra[j*32 +:32] ^ t;
  end
end

endmodule