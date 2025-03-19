module andi(
  input  [0:127] ra,
  input  [0:9]   imme,
  output reg [0:127] result
);

reg  [0:31] t;

always @(*) begin 
  t = {{22{imme[0]}}, imme};

  result[0:31]   = ra[0:31]   & t;
  result[32:63]  = ra[32:63]  & t;
  result[64:95]  = ra[64:95]  & t;
  result[96:127] = ra[96:127] & t; 
end

endmodule