module roti(
  input [0:127] ra,
  input [0:6] imme7,

  output reg [0:127] result
);
integer j, b;
reg [0:4] s;
reg [0:31] t, r;

always @(*) begin
  s = {{10{imme7[0]}}, imme7} & 5'h1F;
  for (j=0 ; j<16 ; j=j+4) begin
    t = ra[8*j +: 32];
    for (b=0 ; b<32 ; b=b+1) begin
      if (b+s < 32) begin
        r[b] = t[b+s];
      end
      else begin
        r[b] = t[b+s-32];
      end
    end
    result[8*j +: 32] = r;
  end
  
end

endmodule