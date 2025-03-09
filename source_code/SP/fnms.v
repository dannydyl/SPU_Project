module fnms(
  input [0:127] ra,
  input [0:127] rb,
  input [0:127] rc,

  output reg [0:127] result
);
integer j;
real product, difference;
reg [31:0] Smax = 32'h7F7FFFFF; 
reg [31:0] Smin = 32'h00800000; 

always @(*) begin
  for (j = 0; j < 4; j = j + 1) begin
    product = -($bitstoshortreal(ra[j*32 +: 32]) * $bitstoshortreal(rb[j*32 +: 32]));
    
    difference = $bitstoshortreal(rc[j*32 +: 32]) - product;

    if (difference > $bitstoshortreal(Smax))
      result[j*32 +: 32] = Smax;
    else if (difference < $bitstoshortreal(Smin))
      result[j*32 +: 32] = 32'h00000000;
    else
      result[j*32 +: 32] = $shortrealtobits(difference);
  end
end

endmodule