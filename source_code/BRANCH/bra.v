module bra(
  input [0:15] imme16,

  output reg [0:9] PC_result,
  output reg branch_taken
);

always @(*) begin
  PC_result = imme16[6:15];
  branch_taken = 1'b1;
end

endmodule