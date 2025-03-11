module bra(
  input [0:15] imme16,

  output [0:9] PC_result
);

assign PC_result = rt[0:9] + imme16;


endmodule