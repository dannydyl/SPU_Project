module ahi(
  input [0:127] ra,
  input [0:9] imme,

  output reg [0:127] result
);
  reg [0:15] s; // Extended immediate value
always @(*) begin
  // Replicate and sign-extend the immediate value
  s = {{6{imme[0]}}, imme}; // Sign-extend 10-bit immediate to 16-bit

  // Compute the result for each 16-bit halfword slot
  result[0:15]   = ra[0:15]   + s;
  result[16:31]  = ra[16:31]  + s;
  result[32:47]  = ra[32:47]  + s;
  result[48:63]  = ra[48:63]  + s;
  result[64:79]  = ra[64:79]  + s;
  result[80:95]  = ra[80:95]  + s;
  result[96:111] = ra[96:111] + s;
  result[112:127] = ra[112:127] + s;
end
endmodule
