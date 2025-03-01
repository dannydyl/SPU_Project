module a(
  input [0:127] ra,
  input [0:127] rb,

  output [0:127] result
);
always @(*) begin
  result[0:31]  = ra[0:31]   + rb[0:31];
  result[32:63] = ra[32:63]  + rb[32:63];
  result[64:95] = ra[64:95]  + rb[64:95];
  result[96:127]= ra[96:127] + rb[96:127];
end
endmodule