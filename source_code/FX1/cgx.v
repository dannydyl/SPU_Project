module cgx(
  input [0:127] ra,
  input [0:127] rb,
  input [0:127] rt,
  output [0:127] result
);

integer j;
reg [0:32] t;
always(*) begin
  for(j = 0 ; j < 16 ; j = j + 4) begin
    t = ({1'b0, ra[j*8 +:32]} + {1'b0, rb[j*8 +:32]} + {32'b0, rt[j*8 + 31]});
    result[j*8 +:32] = {31'b0, t[0]};
  end
end
 
endmodule