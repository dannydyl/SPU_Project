module stqd(
  input [0:127] ra,
  input [0:9] imme10,

  output [0:14] addr_result
);

assign addr_result = {imme10[0], imme10[0:9], 4'b0000} + ra[0:14];

endmodule