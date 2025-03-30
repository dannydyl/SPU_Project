module Odd_Pipe(
  input clk,
  input rst,

  input [0:31] full_instr,
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
  output [0:9] new_PC,

  // preload signals
  input preload_LS_en,
  input [0:14] preload_LS_addr,
  input [0:127] preload_LS_data
);

`include "opcode_package.vh"

// [0:2] unit ID, [3:130] 128-bit result, [131:137] reg_dst, [138:141] latency, [142] RegWr
reg [0:142] packed_1stage;

reg [0:127] result; // used for permute or branch 

// was going to use this but it seems like it is not necessary
// [0:127] rt data, [128:142] addr_result, [143] LS_write_en
// reg [0:143] packed_LS_result_stage1;
// reg [0:143] packed_LS_result_stage2;
// reg [0:143] packed_LS_result_stage3;
// reg [0:143] packed_LS_result_stage4;
// reg [0:143] packed_LS_result_stage5;
// reg [0:143] packed_LS_result_stage6;
// reg [0:143] packed_LS_result_stage7;


wire [0:127] PERM_result, branch_rt_result, LS_data_result;
// reg [0:9] new_PC;
wire [0:14] addr_result;

reg LS_write_en;

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
  .PC_result(new_PC),
  .rt_result(branch_rt_result)
);

// LS
LS_ALU LS_inst(
  .instr_id(instr_id),
  .ra_data(ra_data),
  .imme10(imme10),
  .imme16(imme16),
  .addr_result(addr_result)
);

// below two always block can be combined
always @(*) begin // this should actually come from ID stage
  case (instr_id)
    `instr_ID_stqa: LS_write_en = 1'b1;
    `instr_ID_stqd: LS_write_en = 1'b1;
    default: LS_write_en = 1'b0;
  endcase
end

// always @(*) begin // this is for store instruction to be able forwarding
//   if (instr_id == `instr_ID_stqa || instr_id == `instr_ID_stq) begin
//     LS_data_result = rc_data;
//   end
// end

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

// the problem here is that if the instruction is store, the rt data should be able to forward before writing on LS
// but load instruction, will not be able to forward until 7th stage
// now that i think about it, store instruction dont really need to forward anything because no register is being written
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
  else begin
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