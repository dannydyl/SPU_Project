module stqa(
  input [0:15] imme16,

  output [0:14] addr_result
);

assign addr_result = imme16 & 15'h7FF0;

endmodule