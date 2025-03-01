module sfh(
  input [0:127] ra,
  input [0:127] rb,

  output [0:127] result
);
integer j;
always @(*) begin
  for(j = 0 ; j < 8 ; j = j + 1) begin
    result[j*16 +:16] = rb[j*16 +:16] + ~(ra[j*16 +:16]) + 1;
  end
end
endmodule