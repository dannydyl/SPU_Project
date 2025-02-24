module addx(
  input [127:0] ra,
  input [127:0] rb,
  input [127:0] rt,

  output [127:0] result
);
  always @(*) begin
    // Compute the result for each 32-bit slot
    result[31:0]   = ra[31:0]   + rb[31:0]   + rt[31];
    result[63:32]  = ra[63:32]  + rb[63:32]  + rt[63];
    result[95:64]  = ra[95:64]  + rb[95:64]  + rt[95];
    result[127:96] = ra[127:96] + rb[127:96] + rt[127];

end
endmodule