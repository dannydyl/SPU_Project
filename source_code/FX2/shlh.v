module shlh(
  input [0:127] ra,
  input [0:127] rb,

  output reg [0:127] result
);
integer j, b;
reg [0:15] s;
reg [0:15] t, r;

always @(*) begin
  for(j=0 ; j<16 ; j=j+2) begin
    s = rb[8*j +: 16] & 16'h001F;
    t = ra[8*j +: 16];
    for(b=0 ; b<16 ; b=b+1) begin
      if(b+s < 16) begin
        r[b] = t[b+s];
      end else begin
        r[b] = 0;
      end
    end
    result[8*j +: 16] = r;
  end
end

endmodule