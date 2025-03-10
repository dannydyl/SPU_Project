module rotqbii(
  input [0:127] ra,
  input [0:6] imme7,

  output reg [0:127] result
);
integer b;
reg [0:2] s;
reg [0:127] r;

always @(*) begin
  s = imme7[4:6];
  if (s == 0) begin
    result = ra; // No rotation needed, directly assign RA to result
  end else begin
    for (b = 0; b < 128; b = b + 1) begin
      if (b + s < 128) 
        r[b] = ra[b+s];
      else
        r[b] = ra[b+s-128];
    end
    result = r;
  end
end

endmodule