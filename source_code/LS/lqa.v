module lqa(
  input [0:15] imme16,

  output reg [0:14] addr_result
);
wire [0:14] temp;
assign temp = imme16[1:15] << 4;
always @(*) begin
  addr_result = temp & 15'h7FF0;
end

endmodule