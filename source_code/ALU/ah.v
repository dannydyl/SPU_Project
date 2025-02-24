module ah(
  input [127:0] ra,
  input [127:0] rb,

  output [127:0] result
);
  always(*) begin
    result[15:0]   = ra[15:0]   + rb[15:0];
    result[31:16]  = ra[31:16]  + rb[31:16];
    result[47:32]  = ra[47:32]  + rb[47:32];
    result[63:48]  = ra[63:48]  + rb[63:48];
    result[79:64]  = ra[79:64]  + rb[79:64];
    result[95:80]  = ra[95:80]  + rb[95:80];
    result[111:96] = ra[111:96] + rb[111:96];
    result[127:112] = ra[127:112] + rb[127:112];
  end
endmodule