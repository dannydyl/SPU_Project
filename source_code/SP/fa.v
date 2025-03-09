module fa(
  input [0:127] ra,
  input [0:127] rb,

  output reg [0:127] result
);
integer j;

real sum;
reg [31:0] Smax = 32'h7F7FFFFF; // Max normalized float (largest finite positive value in IEEE 754)
reg [31:0] Smin = 32'h00800000; // Min normalized float (smallest positive normalized value in IEEE 754)

always @(*) begin
  for (j = 0; j < 16; j = j + 4) begin
    // Perform floating-point addition
    sum = $bitstoshortreal(ra[j*8 +: 32]) + $bitstoshortreal(rb[j*8 +: 32]);

    // Handle Smax and Smin clamping
    if (sum > $bitstoshortreal(Smax))
      result[j*8 +: 32] = Smax;
    else if (sum < $bitstoshortreal(Smin))
      result[j*8 +: 32] = 32'h00000000; // Set to zero if below Smin
    else
      result[j*8 +: 32] = $shortrealtobits(sum);
  end
end

// always @(*) begin
//   for(j=0 ; j<4 ; j=j+1) begin
//     result[32*j +: 32] = ra[32*j +: 32] + rb[32*j +: 32];
//   end
// end

endmodule