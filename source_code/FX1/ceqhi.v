module ceqhi(
  input [0:127] ra,
  input [0:9] imme,
  output reg [0:127] result
);

integer j;
reg [0:16] t;
always @(*) begin
  t = {{6{imme[0]}}, imme};
  for(j = 0 ; j < 16 ; j = j + 2) begin
    if(ra[j*8 +:16] == t) 
      result[j*8 +:16] = 16'hFFFF;
    else
      result[j*8 +:16] = 16'h0000;
  end
end
endmodule