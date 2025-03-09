module rot(
  input [0:127] ra,
  input [0:127] rb,

  output reg [0:127] result
);
integer j, b;
reg [0:15] s;
reg [0:31] t, r;

always @(*) begin
  for(j=0 ; j<16 ; j=j+4) begin
    s = rb[8*j +: 32] & 32'h1F;
    t = ra[8*j +: 32];
    for(b=0 ; b<32 ; b=b+1) begin
      if(b+s < 32) begin
        r[b] = t[b+s];
      else begin
        r[b] = t[b+s-32];
      end
    end
    result[8*j +: 32] = r;
  end
end
end

endmodule