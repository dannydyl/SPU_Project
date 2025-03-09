module fms(
  input [0:127] ra,
  input [0:127] rb,
  input [0:127] rc,

  output reg [0:127] result
);
integer j;
real product, difference;
reg [31:0] Smax = 32'h7F7FFFFF; // Max normalized IEEE 754 float
reg [31:0] Smin = 32'h00800000; // Min normalized IEEE 754 float

always @(*) begin
  for (j = 0; j < 4; j = j + 1) begin
    // Perform floating-point multiplication
    product = $bitstoshortreal(ra[j*32 +: 32]) * $bitstoshortreal(rb[j*32 +: 32]);
    
    // Subtract RC
    difference = product - $bitstoshortreal(rc[j*32 +: 32]);

    // Handle Smax and Smin clamping
    if (difference > $bitstoshortreal(Smax))
      result[j*32 +: 32] = Smax;
    else if (difference < $bitstoshortreal(Smin))
      result[j*32 +: 32] = 32'h00000000; // Set to zero if below Smin
    else
      result[j*32 +: 32] = $shortrealtobits(difference);
  end
end

endmodule