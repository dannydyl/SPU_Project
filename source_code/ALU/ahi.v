module ahi(
  input [127:0] ra,
  input [9:0] imme,

  output [127:0] result
);
  reg [15:0] s; // Extended immediate value
always(*) begin
  // Replicate and sign-extend the immediate value
  s = {{6{imme[9]}}, imme}; // Sign-extend 10-bit immediate to 16-bit

  // Compute the result for each 16-bit halfword slot
  result[15:0]   = ra[15:0]   + s;
  result[31:16]  = ra[31:16]  + s;
  result[47:32]  = ra[47:32]  + s;
  result[63:48]  = ra[63:48]  + s;
  result[79:64]  = ra[79:64]  + s;
  result[95:80]  = ra[95:80]  + s;
  result[111:96] = ra[111:96] + s;
  result[127:112] = ra[127:112] + s;
end
endmodule