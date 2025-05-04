module br(
  input [0:15] imme16,
  input [0:8] in_PC,

  output reg [0:8] PC_result,
  output reg branch_taken
);
wire [0:8] temp_imme = imme16[7:15];
always @(*) begin
  PC_result = in_PC + $signed(temp_imme);
  branch_taken = 1'b1;
end

endmodule