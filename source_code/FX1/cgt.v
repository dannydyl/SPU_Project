module cgt(
  input [0:127] ra,
  input [0:127] rb,
  output reg [0:127] result
);
integer j;
always @(*) begin
  for(j = 0 ; j < 16 ; j = j + 4) begin
    if(ra[j*8 +:32] > rb[j*8 +:32]) 
      result[j*8 +:32] = 32'hFFFFFFFF;
    else
      result[j*8 +:32] = 32'h00000000;
  end
end
endmodule