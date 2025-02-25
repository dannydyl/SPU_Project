module addx(
  input [0:127] ra,
  input [0:127] rb,
  input [0:127] rt,

  output [0:127] result
);
  always @(*) begin
    // Compute the result for each 32-bit slot
    result[0:31]   = ra[0:31]   + rb[0:31]   + rt[0];
    result[32:63]  = ra[32:63]  + rb[32:63]  + rt[32];
    result[64:95]  = ra[64:95]  + rb[64:95]  + rt[64];
    result[96:127] = ra[96:127] + rb[96:127] + rt[96];

  end
endmodule