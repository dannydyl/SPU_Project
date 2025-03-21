module addx(
  input [0:127] ra,
  input [0:127] rb,
  input [0:127] rt,

  output reg [0:127] result
);
  always @(*) begin
    // Compute the result for each 32-bit slot
    result[0:31]   = ra[0:31]   + rb[0:31]   + rt[31];
    result[32:63]  = ra[32:63]  + rb[32:63]  + rt[63];
    result[64:95]  = ra[64:95]  + rb[64:95]  + rt[95];
    result[96:127] = ra[96:127] + rb[96:127] + rt[127];

  end
endmodule