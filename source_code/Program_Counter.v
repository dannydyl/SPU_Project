module Program_Counter(
  input clk,
  input rst,  
  input [0:2] unit_id,
  input [0:9] PC_in,
  output reg [0:9] PC_out
);
`include "opcode_package.vh"

reg [0:9] PC;
reg [0:9] next_PC;

always @(*) begin
  if (unit_id == 3'd7) begin
    next_PC = PC_in;  // Immediate branch
  end else begin
    next_PC = PC + 2;  // Normal increment
  end
end

always @(posedge clk or posedge rst) begin
  if (rst) begin
    PC <= 10'b0;
  end else begin
    PC <= next_PC;  // Update PC with the computed value
  end
end

always @(*) begin
  PC_out = PC;  // Combinational output always reflects the latest PC
end

endmodule
