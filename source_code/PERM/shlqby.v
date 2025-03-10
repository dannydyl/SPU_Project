module shlqby(
  input [0:127] ra,
  input [0:127] rb,

  output reg [0:127] result
);
integer b;
reg [0:4] s;

always @(*) begin
  s = rb[27:31];
  if (s == 0) begin
    result = ra; // No shift needed, directly assign RA to result
  end else if (s > 15) begin
    result = 128'h0; // If shift is greater than 15, result is zero
  end else begin
    for (b = 0; b < 16; b = b + 1) begin
      if (b + s < 16) 
        temp[b*8 +: 8] = ra[(b+s)*8 +: 8]; // Shift left by bytes
      else
        temp[b*8 +: 8] = 8'h00; // Fill right with zero bytes
    end
    result = temp;
  end
end

endmodule