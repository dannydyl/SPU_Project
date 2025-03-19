module br(
  input [0:15] imme16,
  input [0:9] in_PC,

  output reg [0:9] PC_result
);

assign PC_result = in_PC + imme16;

endmodule