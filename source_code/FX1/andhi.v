module andhi(
  input [0:127] ra,
  input [0:9] imme,

  output reg [0:127] result
);

reg [0:15] t; // Extended immediate value
always @(*) begin
  t = {{6{imme[0]}}, imme}; // Sign-extend 10-bit immediate to 16-bit

  // Perform bitwise AND operation for each 16-bit halfword slot
  result[0:15]   = ra[0:15]   & t;
  result[16:31]  = ra[16:31]  & t;
  result[32:47]  = ra[32:47]  & t;
  result[48:63]  = ra[48:63]  & t;
  result[64:79]  = ra[64:79]  & t;
  result[80:95]  = ra[80:95]  & t;
  result[96:111] = ra[96:111] & t;
  result[112:127] = ra[112:127] & t;
end
endmodule