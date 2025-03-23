module clz(
  input [0:127] ra,
  output reg [0:127] result
);
integer j, m;
reg [0:31] t;
reg [0:31] u;

always @(*) begin
  for(j = 0 ; j < 16 ; j = j + 4) begin
    t = 32'h00000000;
    u = ra[j*8 +:32];
    for(m = 0 ; m < 32 ; m = m + 1) begin
      if(u[m] == 1) begin
        m = 32;
      end else begin
        t = t + 1;
      end
    end
    result[j*8 +:32] = t;
  end
end
endmodule