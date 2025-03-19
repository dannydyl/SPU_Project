module cntb(
  input [0:127] ra,

  output reg [0:127] result
);
integer j, m;
reg [0:7] data_byte;
reg [0:7] count;

always @(*) begin
  for(j=0 ; j<16 ; j=j+1) begin
    count = 0;
    data_byte = ra[8*j +: 8];
    for(m=0 ; m<8 ; m=m+1) begin
      if(data_byte[m] == 1'b1) begin
        count = count + 1;
      end
    end
    result[8*j +: 8] = count;
  end
end
endmodule