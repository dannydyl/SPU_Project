module stqa(
  input [0:15] imme16,

  output reg [0:14] addr_result
);

always @(*) begin
  addr_result = imme16 & 15'h7FF0;
end

endmodule