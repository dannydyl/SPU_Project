module selb(
  input [0:127] ra,
  input [0:127] rb,
  input [0:127] rc,

  output reg [0:127] result
);

always @(*) begin
  result = (rc & rb) | (~rc & ra);
end
endmodule