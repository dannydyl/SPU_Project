module shlhi(
  input [0:127] ra,
  input [0:6] imme7,

  output [0:127] result
);
integer j, b;
reg [0:15] s;
reg [0:15] t, r;

assign s = {{9{imme7[0]}}, imme7[0:6]} & 16'h001F;

always @(*) begin
  for(j=0 ; j<16 ; j=j+2) begin
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