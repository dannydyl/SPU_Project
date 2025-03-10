module sumb(
  input [0:127] ra,
  input [0:127] rb,

  output reg [0:127] result
);
integer j;
reg [15:0] sum_ra, sum_rb;

always @(*) begin
  for (j = 0; j < 4; j = j + 1) begin
    sum_rb = rb[j*32 +: 8] + rb[j*32+8 +: 8] + rb[j*32+16 +: 8] + rb[j*32+24 +: 8];
    sum_ra = ra[j*32 +: 8] + ra[j*32+8 +: 8] + ra[j*32+16 +: 8] + ra[j*32+24 +: 8];

    result[j*32 +: 16] = sum_rb;
    result[j*32+16 +: 16] = sum_ra;
  end
end

endmodule