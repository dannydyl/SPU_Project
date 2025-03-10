module rotqbyi(
  input [0:127] ra,
  input [0:6] imme7,

  output reg [0:127] result
);
integer b;
reg [0:3] s;
reg [0:127] r;

always @(*) begin
  s = imme7[3:6];
  if(s == 0) begin
    result = ra;
  end else begin
    for(b=0 ; b<16 ; b=b+1) begin
      if(b+s < 16) begin
        r[8*b +: 8] = ra[8*(b+s) +: 8];
      end else begin
        r[8*b +: 8] = ra[8*(b+s-16) +: 8];
      end
    end
    result = r;
  end
end


endmodule