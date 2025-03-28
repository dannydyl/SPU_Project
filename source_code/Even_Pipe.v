module Even_Pipe(
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




  // output for forwarding unit
  output reg [0:142] packed_2stage,
  output reg [0:142] packed_3stage,
  output reg [0:142] packed_4stage,
  output reg [0:142] packed_5stage,
  output reg [0:142] packed_6stage,
  output reg [0:142] packed_7stage,

  // Write back stage
  output reg [0:6] WB_reg_write_addr,
  output reg [0:127] WB_reg_write_data,
  output reg WB_reg_write_en

);
// [0:2] unit ID, [3:130] 128-bit result, [131:137] reg_dst, [138:141] latency, [142] RegWr
reg [0:142] packed_1stage;
// reg [0:142] packed_result_1stage, packed_result_2stage, packed_result_3stage, packed_result_4stage, packed_result_5stage, packed_result_6stage, packed_result_7stage;

reg [0:127] result;

wire [0:127] FX1_result, FX2_result, SP_result, BYTE_result;


FX1_ALU fx1_inst (
  .instr_id(instr_id),
  .ra_data(ra_data),
  .rb_data(rb_data),
  .rc_data(rc_data),
  .imme7(imme7),
  .imme10(imme10),
  .imme16(imme16),
  .imme18(imme18),
  .result(FX1_result)
);

// FX2 unit
FX2_ALU FX2_inst(
  .instr_id(instr_id),
  .ra_data(ra_data),
  .rb_data(rb_data),
  .rc_data(rc_data),
  .imme7(imme7),
  .imme10(imme10),
  .imme16(imme16),
  .imme18(imme18),
  .result(FX2_result)
);

// SP unit
SP_ALU SP_inst(
  .instr_id(instr_id),
  .ra_data(ra_data),
  .rb_data(rb_data),
  .rc_data(rc_data),
  .imme7(imme7),
  .imme10(imme10),
  .imme16(imme16),
  .imme18(imme18),
  .result(SP_result)
);

// BYTE unit
BYTE_ALU BYTE_inst(
  .instr_id(instr_id),
  .ra_data(ra_data),
  .rb_data(rb_data),
  .rc_data(rc_data),
  .imme7(imme7),
  .imme10(imme10),
  .imme16(imme16),
  .imme18(imme18),
  .result(BYTE_result)
);

always @(*) begin
  if (instr_id == 7'd86 | instr_id == 7'd87) begin
    packed_1stage = 143'b0;
  end else begin
    case (unit_id) 
      3'b001: result = FX1_result;
      3'b010: result = FX2_result;
      3'b011: result = SP_result;  
      3'b100: result = BYTE_result;
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