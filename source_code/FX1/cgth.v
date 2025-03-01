module cgth(
  input [0:127] ra,
  input [0:127] rb,
 
  output [0:127] result
);
integer j;

always @(*) begin
  for(j = 0 ; j < 16 ; j = j + 2) begin
    if(ra[j*8 +:16] > rb[j*8 +:16]) 
      result[j*8 +:16] = 32'hFFFFFFFFF;
    else
      result[j*8 +:16] = 32'h000000000;
  end
end
endmodule
