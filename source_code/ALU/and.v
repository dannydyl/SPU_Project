module and(
  input [127:0] ra,
  input [127:0] rb,

  output [127:0] result
);

always(*) begin
  result[31:0]  = ra[31:0]   & rb[31:0];
  result[63:32] = ra[63:32]  & rb[63:32];
  result[95:64] = ra[95:64]  & rb[95:64];
  result[127:96] = ra[127:96] & rb[127:96];
end

endmodule