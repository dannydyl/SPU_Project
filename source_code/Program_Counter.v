module Program_Counter(
  input clk,
  input rst,  
  // input [0:2] unit_id, // will be removed later
  input branch_taken,
  input is_branch,
  input stall,
  input [0:9] PC_in,
  output reg [0:9] PC_out
);
`include "opcode_package.vh"

reg [0:9] PC;
// reg [0:9] next_PC;

// always @(*) begin
//   if (branch_taken) begin
//     next_PC = PC_in;  // Immediate branch
//   end else begin
//     next_PC = PC + 2;  // Normal increment
//   end
// end

always @(posedge clk or posedge rst) begin
  if (rst) begin
    PC <= 10'b0;
  end 
  else if (stall) begin
    PC <= PC;
  end
  else if (is_branch && branch_taken) begin
    if (PC_in[9] == 1'b1) begin // misalligned target
      
    end
    PC <= PC_in;  // Update PC with the branch target
  end
  else begin
    PC <= PC + 2;  // Update PC with the computed value
  end
end

always @(*) begin
  PC_out = PC;  // Combinational output always reflects the latest PC
end

endmodule
