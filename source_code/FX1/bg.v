module bg(
  input [0:127] ra,
  input [0:127] rb,
  output [0:127] result
);
  integer j;
  always @(*) begin
    for (j = 0; j < 128; j = j + 32) begin // increament by 4 bytes
      // Unsigned comparison for each 32-bit word slot
      result[j+:32] = ($unsigned(rb[j+:32]) >= $unsigned(ra[j+:32])) ? 32'hFFFFFFFF : 32'h00000000;
    end
  end
endmodule