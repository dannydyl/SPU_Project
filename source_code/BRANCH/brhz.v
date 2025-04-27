module brhz(
  input [0:127] rt,
  input [0:15] imme16,
  input [0:9] in_PC,

  output reg [0:9] PC_result,
  output reg branch_taken
);

always @(*) begin
  if (rt[16:31] == 0) begin
    PC_result = in_PC + $signed(imme16);
    branch_taken = 1'b1;
  end else begin
    PC_result = in_PC + 2;
    branch_taken = 1'b0;
  end
end
s
endmodule