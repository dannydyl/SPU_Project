module rothi(
  input [0:127] ra,
  input [0:6] imme7,

  output [0:127] result
);
integer j, b;
reg [0:3] s;
reg [0:15] t, r;

assign s = {{9{imme[0]}}, imme[0:6]};

always @(*) begin
  for(j=0 ; j<16 ; j=j+2) begin
    t = ra[8*j +: 16];
    for(b=0 ; b<16 ; b=b+1) begin
      if(b+s < 16) begin
        r[b] = t[b+s];
      else begin
        r[b] = t[b+s-16];
      end
    end
    result[8*j +: 16] = r;
  end
end

endmodule