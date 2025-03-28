module brsl(
  input [0:15] imme16,
  input [0:9] in_PC,

  output reg [0:127] rt_result,
  output reg [0:9] PC_result
);

always @(*) begin
  rt_result[0:31] = {22'b0, (in_PC + 1)};
  rt_result[32:127] = 96'b0;
  PC_result = in_PC + $signed(imme16);
end

endmodule