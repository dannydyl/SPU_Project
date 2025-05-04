module brasl(
  input [0:8] in_PC,
  input [0:15] imme16,

  output reg [0:8] PC_result,
  output reg [0:127] rt_result,
  output reg branch_taken
);
wire [0:8] temp_imme = imme16[7:15];
always @(*) begin
  rt_result[0:31] = {23'b0, (in_PC)};
  rt_result[32:127] = 96'b0;
  PC_result = temp_imme;
  branch_taken = 1'b1;
end

endmodule