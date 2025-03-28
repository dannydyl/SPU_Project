module lqd(
  input [0:127] ra,
  input [0:9] imme10,

  output reg [0:14] addr_result
);

always @(*) begin
  addr_result = {imme10[0], imme10[0:9], 4'b0000} + ra[17:31];
end

endmodule