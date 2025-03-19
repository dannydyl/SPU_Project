module cgth(
  input [0:127] ra,
  input [0:127] rb,
 
  output reg [0:127] result
);
integer j;

always @(*) begin
  for(j = 0 ; j < 16 ; j = j + 2) begin
    if(ra[j*8 +:16] > rb[j*8 +:16]) 
      result[j*8 +:16] = 32'hFFFFFFFF;
    else
      result[j*8 +:16] = 32'h00000000;
  end
end
endmodule
