module brnz(
  input [0:15] imme16,
  input [0:127] rt,
  input [0:9] in_PC,

  output reg [0:9] PC_result
);
always @(*) begin
  if (rt[0:31] != 0) begin
    PC_result = in_PC + $signed(imme16);
  end else begin
    PC_result = in_PC + 2;
  end
end

endmodule