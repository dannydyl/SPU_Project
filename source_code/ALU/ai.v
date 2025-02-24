module ai(
  input [127:0] ra,
  input [9:0] imme,

  output [127:0] result
);
reg [31:0] s; // Extended immediate value
always(*) begin
  // Replicate and sign-extend the immediate value
  s = {{22{imme[9]}}, imme}; // Sign-extend 10-bit immediate to 32-bit
  // 32 - 10 22
  // Compute the result for each 32-bit slot
  result[31:0]   = ra[31:0]   + s;
  result[63:32]  = ra[63:32]  + s;
  result[95:64]  = ra[95:64]  + s;
  result[127:96] = ra[127:96] + s;
end
endmodule