module br(
  input [0:15] imme16,
  input [0:9] in_PC,

  output reg [0:9] PC_result
);

always @(*) begin
  PC_result = in_PC + $signed(imme16);
end

endmodule