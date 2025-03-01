module ilh(
  input [0:15] imme,

  output [0:127] result
);
integer j;
always @(*) begin
  for(j = 0 ; j < 8 ; j = j + 1) begin
    result[j*16 +:16] = imme;
  end
end
endmodule