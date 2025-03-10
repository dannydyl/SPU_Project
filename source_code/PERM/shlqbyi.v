module shlqbyi(
  input [0:127] ra,
  input [0:6] imme7,

  output reg [0:127] result
);
integer b;
reg [0:4] s;
reg [0:127] r;

always @(*) begin
  s = imme7[2:6];
  if (s == 0) begin
    result = ra; // No shift needed, directly assign RA to result
  end else if (s > 15) begin
    result = 128'h0; // If shift is greater than 15, result is zero
  end else begin
    for (b = 0; b < 16; b = b + 1) begin
      if (b + s < 16) 
        r[b*8 +: 8] = ra[(b+s)*8 +: 8]; // Shift left by bytes
      else
        r[b*8 +: 8] = 8'h00; // Fill right with zero bytes
    end
    result = r;
  end
end
endmodule