module Even_Pipe(
  input clk,
  input rst,

  input [0:31] full_isntr,
  input [0:6] instr_id,
  input [0:6] reg_dst,
  input [0:2] unit_id,
  input [0:3] latency,
  input reg_wr,

  input [0:127] ra_data,
  input [0:127] rb_data,
  input [0:127] rc_data, // rc port is also used for instructions that need rt data as an operand
  input [0:7] imme7,
  input [0:9] imme10,
  input [0:15] imme16,
  input [0:17] imme18,




  // output for forwarding unit
  output [0:142] packed_result_1stage,
  output [0:142] packed_result_2stage,
  output [0:142] packed_result_3stage,
  output [0:142] packed_result_4stage,
  output [0:142] packed_result_5stage,
  output [0:142] packed_result_6stage,
  output [0:142] packed_result_7stage,

  // Write back stage
  output [0:6] WB_reg_write_addr,
  output [0:127] WB_reg_write_data,
  output WB_reg_write_en

);
// [0:2] unit ID, [3:130] 128-bit result, [131:137] reg_dst, [138:141] latency, [142] RegWr
reg [0:142] packed_result;
reg [0:142] packed_result_1stage, packed_result_2stage, packed_result_3stage, packed_result_4stage, packed_result_5stage, packed_result_6stage, packed_result_7stage;

reg [0:127] result;
reg [0:2] unit_id;
reg [0:6] reg_dst;
reg [0:3] latency;
reg reg_wr;

reg [0:127] FX1_result;


FX1_ALU fx1_inst (
  .instr_id(instr_id),
  .ra(ra_data),
  .rb(rb_data),
  .rc(rc_data),
  .imme7(imme7),
  .imme10(imme10),
  .imme16(imme16),
  .imme18(imme18),
  .result(FX1_result)
);

// FX2 unit

// SP unit

// BYTE unit


always @(*) begin

  case (unit_id) 
    3'b000: result <= FX1_result;
    3'b001: result <= FX2_result;
    3'b010: result <= SP_result;  
    3'b011: result <= BYTE_result;
  endcase

  packed_result <= {unit_id, result, reg_dst, latency, reg_wr};

end

always @(posedge clk or posedge rst) begin
  if (rst) begin
    packed_result_1stage <= 0;
    packed_result_2stage <= 0;
    packed_result_3stage <= 0;
    packed_result_4stage <= 0;
    packed_result_5stage <= 0;
    packed_result_6stage <= 0;
    packed_result_7stage <= 0;
  end
  else begin
    packed_result_1stage <= packed_result;
    packed_result_2stage <= packed_result_1stage;
    packed_result_3stage <= packed_result_2stage;
    packed_result_4stage <= packed_result_3stage;
    packed_result_5stage <= packed_result_4stage;
    packed_result_6stage <= packed_result_5stage;
    packed_result_7stage <= packed_result_6stage;
    WB_reg_write_addr <= packed_result_7stage[131:137];
    WB_reg_write_data <= packed_result_7stage[3:130];
    WB_reg_write_en <= packed_result_7stage[142];
  end
end





endmodule