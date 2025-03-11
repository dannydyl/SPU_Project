module brz(
  input [0:15] imme16,
  input [0:9] in_PC,

  output [0:9] PC_result
);

always @(*) begin
  if (rt[0:31] == 0) begin
    PC_result = in_PC + imme16;
  end else begin
    PC_result = in_PC + 1;
  end
end

endmodule