module cgti(
  input [0:127] ra,
  input [0:9] imme,
  output [0:127] result
);

integer j;
reg [0:31] t;

always(*) begin
  t = {{22{imme[0]}}, imme};
  for(j = 0 ; j < 16 ; j = j + 4) begin
    if(ra[j*8 +:32] > t) 
      result[j*8 +:32] = 32'hFFFFFFFF;
    else
      result[j*8 +:32] = 32'h00000000;
  end
end
endmodule