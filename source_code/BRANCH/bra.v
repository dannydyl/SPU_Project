module bra(
  input [0:15] imme16,

  output reg [0:9] PC_result
);

always @(*) begin
  PC_result = imme16[6:15];
end

endmodule