module Program_Counter(
  input clk,
  input rst,
  output reg [0:9] PC_out
);

always @(posedge clk or posedge rst) begin
  if (rst) begin
    PC_out <= 10'b0;
  end else begin
    PC_out <= PC_out + 2;
  end
end

endmodule