module andhi(
  input [127:0] ra,
  input [9:0] imme,

  output [127:0] result
);

reg [15:0] t; // Extended immediate value
always(*) begin
  t = {{6{imme[9]}}, imme}; // Sign-extend 10-bit immediate to 16-bit

  // Perform bitwise AND operation for each 16-bit halfword slot
  result[15:0]   = ra[15:0]   & t;
  result[31:16]  = ra[31:16]  & t;
  result[47:32]  = ra[47:32]  & t;
  result[63:48]  = ra[63:48]  & t;
  result[79:64]  = ra[79:64]  & t;
  result[95:80]  = ra[95:80]  & t;
  result[111:96] = ra[111:96] & t;
  result[127:112] = ra[127:112] & t;
end
endmodule