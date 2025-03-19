module brsl(
  input [0:15] imme16,
  input [0:9] in_PC,

  output reg [0:127] rt_result,
  output reg [0:9] PC_result
);

assign rt_result[0:31] = {22'b0, (in_PC + 1)};
assign rt_result[32:127] = 96'b0;
assign PC_result = in_PC + imme16;

endmodule