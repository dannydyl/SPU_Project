module bgx(
  input [0:127] ra,
  input [0:127] rb,
  input [0:127] rt,
  output [0:127] result
);
integer j;
  always @(*) begin
    for (j = 0; j < 16; j = j + 4) begin
      if (rt[j*8 + 31]) begin // 31, 63, 95, 127 
        // Perform unsigned greater than or equal comparison
        if ($unsigned(rb[j*8 +: 32]) >= $unsigned(ra[j*8 +: 32])) 
          result[j*8 +: 32] = 32'b1; 
        else 
          result[j*8 +: 32] = 32'b0;
      end else begin
        // Perform unsigned greater than comparison
        if ($unsigned(rb[j*8 +: 32]) > $unsigned(ra[j*8 +: 32])) 
          result[j*8 +: 32] = 32'b1; 
        else 
          result[j*8 +: 32] = 32'b0;
      end
    end
  end

endmodule