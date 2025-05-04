module Odd_Pipe(
  input clk,
  input rst,
  input flush,

  input [0:6] instr_id,
  input [0:6] reg_dst,
  input [0:2] unit_id,
  input [0:3] latency,
  input reg_wr,

  input [0:127] ra_data,
  input [0:127] rb_data,
  input [0:127] rc_data, // rc port is also used for instructions that need rt data as an operand
  input [0:6] imme7,
  input [0:9] imme10,
  input [0:15] imme16,
  input [0:17] imme18,

  input [0:9] current_PC,
  input instr1_branch,

  // output for forwarding unit
  output reg [0:142] packed_2stage,
  output reg [0:142] packed_3stage,
  output reg [0:142] packed_4stage,
  output reg [0:142] packed_5stage,
  output reg [0:142] packed_6stage,
  output reg [0:142] packed_7stage,

  // Write back stage also used for load instruction
  output reg [0:6] WB_reg_write_addr,
  output reg [0:127] WB_reg_write_data,
  output reg WB_reg_write_en,

  // branch new PC
  output reg [0:9] new_PC,
  output reg branch_taken,
  output reg is_branch,
  output reg flush_instr2_even, // goes to Even pipe

  // preload signals
  input preload_LS_en,
  input [0:14] preload_LS_addr,
  input [0:127] preload_LS_data
);

`include "opcode_package.vh"

// [0:2] unit ID, [3:130] 128-bit result, [131:137] reg_dst, [138:141] latency, [142] RegWr
reg [0:142] packed_1stage;
wire [0:9] new_PC_result; // new PC from branch unit
reg [0:127] result; // used for permute or branch 

wire [0:127] PERM_result, branch_rt_result, LS_data_result;
wire [0:14] addr_result;

reg LS_write_en;
wire branch_taken_1stage;

// Permute 
PERM_ALU PERM_inst(
  .instr_id(instr_id),
  .ra_data(ra_data),
  .rb_data(rb_data),
  .rc_data(rc_data),
  .imme7(imme7),
  .imme10(imme10),
  .imme16(imme16),
  .imme18(imme18),
  .result(PERM_result)
);

// Branch
BRANCH_ALU BRANCH_inst(
  .instr_id(instr_id),
  .rc_data(rc_data),
  .imme16(imme16),
  .in_PC(current_PC),
  .PC_result(new_PC_result),
  .rt_result(branch_rt_result),
  .branch_taken(branch_taken_1stage)
);

// LS
LS_ALU LS_inst(
  .instr_id(instr_id),
  .ra_data(ra_data),
  .imme10(imme10),
  .imme16(imme16),
  .addr_result(addr_result)
);

always @(*) begin 
  case (instr_id)
    `instr_ID_stqa: LS_write_en = 1'b1;
    `instr_ID_stqd: LS_write_en = 1'b1;
    default: LS_write_en = 1'b0;
  endcase
end

// LocalStore
LocalStore LSmem_inst(
  .clk(clk),
  .rst(rst),
  .LS_write_en(LS_write_en),
  .LS_addr(addr_result),
  .LS_data_in(rc_data), // from ID stage, it should place rt data here
  .LS_data_out(LS_data_result),
  // preload
  .preload_LS_en(preload_LS_en),
  .preload_LS_addr(preload_LS_addr),
  .preload_LS_data(preload_LS_data)
);

always @(*) begin
  if (instr_id == 7'd85 | instr_id == 7'd87) begin
    packed_1stage = 143'b0;
  end else begin
    case (unit_id)
      3'b101: result = PERM_result; // permute result
      3'b110: result = LS_data_result;  // load result (from ls)
      3'b111: result = branch_rt_result; 
      default: result = 128'd0;
    endcase
    packed_1stage = {unit_id, result, reg_dst, latency, reg_wr};
  end
end

always @(posedge clk or posedge rst) begin
  if (rst) begin
    packed_1stage <= 0;
    packed_2stage <= 0;
    packed_3stage <= 0;
    packed_4stage <= 0;
    packed_5stage <= 0;
    packed_6stage <= 0;
    packed_7stage <= 0;
  end
  else if (flush) begin
    is_branch <= 1'b0;
    branch_taken <= 1'b0;
    
    packed_2stage <= 0;
    packed_3stage <= 0;
    packed_4stage <= packed_3stage;
    packed_5stage <= packed_4stage;
    packed_6stage <= packed_5stage;
    packed_7stage <= packed_6stage;
    WB_reg_write_addr <= packed_7stage[131:137];
    WB_reg_write_data <= packed_7stage[3:130];
    WB_reg_write_en <= packed_7stage[142];
  end
  else begin
  flush_instr2_even <= 1'b0; // default value
    if(unit_id == 3'b111) begin
      new_PC <= new_PC_result;
      branch_taken <= branch_taken_1stage;
      is_branch <= 1'b1;
      if(instr1_branch && branch_taken_1stage) begin
        flush_instr2_even <= 1'b1;
      end
    end else begin
      is_branch <= 1'b0;
      branch_taken <= 1'b0;
    end

    packed_2stage <= packed_1stage;
    packed_3stage <= packed_2stage;
    packed_4stage <= packed_3stage;
    packed_5stage <= packed_4stage;
    packed_6stage <= packed_5stage;
    packed_7stage <= packed_6stage;
    WB_reg_write_addr <= packed_7stage[131:137];
    WB_reg_write_data <= packed_7stage[3:130];
    WB_reg_write_en <= packed_7stage[142];
  end
end

endmodule