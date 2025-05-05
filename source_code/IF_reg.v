module IF_reg(
  input clk,
  input rst,
  input [0:8] PC_in,
  input [0:31] instr1_in,
  input [0:31] instr2_in,
  input find_nop_in,
  input stall,

  output reg [0:8] PC_out,
  output reg [0:31] instr1_out,
  output reg [0:31] instr2_out,
  output reg find_nop_out
);

always @(posedge clk or posedge rst) begin
  if (rst) begin
    PC_out        <= 9'd0;
    instr1_out    <= 32'd0;
    instr2_out    <= 32'd0;
    find_nop_out  <= 1'b0;
  end else if (stall) begin
    // Hold the values
    PC_out        <= PC_out;
    instr1_out    <= instr1_out;
    instr2_out    <= instr2_out;
    find_nop_out  <= find_nop_out;
  end else begin
    // Update the values
    PC_out        <= PC_in;
    instr1_out    <= instr1_in;
    instr2_out    <= instr2_in;
    find_nop_out  <= find_nop_in;
  end
end

endmodule
