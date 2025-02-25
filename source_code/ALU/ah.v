module ah(
  input [0:127] ra,
  input [0:127] rb,

  output [0:127] result
);
  always(*) begin
    result[0:15]   = ra[0:15]   + rb[0:15];
    result[16:31]  = ra[16:31]  + rb[16:31];
    result[32:47]  = ra[32:47]  + rb[32:47];
    result[48:63]  = ra[48:63]  + rb[48:63];
    result[64:79]  = ra[64:79]  + rb[64:79];
    result[80:95]  = ra[80:95]  + rb[80:95];
    result[96:111] = ra[96:111] + rb[96:111];
    result[112:127] = ra[112:127] + rb[112:127];
  end
endmodule
