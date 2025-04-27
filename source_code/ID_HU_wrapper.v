module ID_HU_wrapper(
  input clk,
  input rst,
  input [0:31] instruction_in1,
  input [0:31] instruction_in2,

  output reg[0:31] full_instr_even,
  output reg [0:6] instr_id_even,
  output reg [0:6] reg_dst_even,
  output reg [0:2] unit_id_even,
  output reg [0:3] latency_even,
  output reg reg_wr_even,
  output reg [0:6] imme7_even,
  output reg [0:9] imme10_even,
  output reg [0:15] imme16_even,
  output reg [0:17] imme18_even,

  output reg [0:6] ra_addr_even,
  output reg [0:6] rb_addr_even,
  output reg [0:6] rc_addr_even,

  output reg [0:31] full_instr_odd,
  output reg [0:6] instr_id_odd,
  output reg [0:6] reg_dst_odd,
  output reg [0:2] unit_id_odd,
  output reg [0:3] latency_odd,
  output reg reg_wr_odd,
  output reg [0:6] imme7_odd,
  output reg [0:9] imme10_odd,
  output reg [0:15] imme16_odd,
  output reg [0:17] imme18_odd,

  output reg [0:6] ra_addr_odd,
  output reg [0:6] rb_addr_odd,
  output reg [0:6] rc_addr_odd,

  output reg stall,
  output reg flush
);

`include "opcode_package.vh"

wire [0:142] packed_IDstage_even, packed_IDstage_odd;
reg [0:142]   packed_RFFUstage_even, packed_1stage_even, packed_RFFUstage_odd, packed_1stage_odd;

reg [0:31] instruction_in1_reg, instruction_in2_reg;

Instruction_Decode ID_inst(
  .instruction_in1(instruction_in1),
  .instruction_in2(instruction_in2),

  .full_instr_even(full_instr_even),
  .instr_id_even(instr_id_even),
  .reg_dst_even(reg_dst_even),
  .unit_id_even(unit_id_even),
  .latency_even(latency_even),
  .reg_wr_even(reg_wr_even),
  .imme7_even(imme7_even),
  .imme10_even(imme10_even),
  .imme16_even(imme16_even),
  .imme18_even(imme18_even),

  .ra_addr_even(ra_addr_even),
  .rb_addr_even(rb_addr_even),
  .rc_addr_even(rc_addr_even),

  .full_instr_odd(full_instr_odd),
  .instr_id_odd(instr_id_odd),
  .reg_dst_odd(reg_dst_odd),
  .unit_id_odd(unit_id_odd),
  .latency_odd(latency_odd),
  .reg_wr_odd(reg_wr_odd),
  .imme7_odd(imme7_odd),
  .imme10_odd(imme10_odd),
  .imme16_odd(imme16_odd),
  .imme18_odd(imme18_odd),

  .ra_addr_odd(ra_addr_odd),
  .rb_addr_odd(rb_addr_odd),
  .rc_addr_odd(rc_addr_odd),

  .instr1_type(instr1_type),
  .instr2_type(instr2_type)
);

Hazard_Unit HU_inst(
  .instr1_type(instr1_type),
  .instr2_type(instr2_type),
  .ra_addr_even(ra_addr_even),
  .rb_addr_even(rb_addr_even),
  .rc_addr_even(rc_addr_even),
  .ra_addr_odd(ra_addr_odd),
  .rb_addr_odd(rb_addr_odd),
  .rc_addr_odd(rc_addr_odd),

  .packed_RFFUstage_even(packed_RFFUstage_even),
  .packed_1stage_even(packed_1stage_even),
  .packed_2stage_even(packed_2stage_even),
  .packed_3stage_even(packed_3stage_even),
  .packed_4stage_even(packed_4stage_even),
  .packed_5stage_even(packed_5stage_even),
  .packed_6stage_even(packed_6stage_even),

  .packed_RFFUstage_odd(packed_RFFUstage_odd),
  .packed_1stage_odd(packed_1stage_odd),
  .packed_2stage_odd(packed_2stage_odd),
  .packed_3stage_odd(packed_3stage_odd),
  .packed_4stage_odd(packed_4stage_odd),
  .packed_5stage_odd(packed_5stage_odd),
  .packed_6stage_odd(packed_6stage_odd),

  .stall(stall),
  .flush(flush)
);

assign packed_IDstage_even = {unit_id_even, 128'd0, reg_dst_even, latency_even, reg_wr_even};
assign packed_IDstage_odd = {unit_id_odd, 128'd0, reg_dst_odd, latency_odd, reg_wr_odd};

always @(*) begin
  instruction_in1_reg = instruction_in1;
  instruction_in2_reg = instruction_in2;
end

always @(posedge clk or posedge rst) begin
  if (rst) begin

  end
  else if (stall) begin
    // feed nop to both pipes
    full_instr_even <= 32'b01000000001000000000000000000000;
    instr_id_even <= 'instr_ID_nop;
    reg_dst_even <= 7'b0;
    unit_id_even <= 3'b0;
    latency_even <= 4'b0;
    reg_wr_even <= 1'b0;
    imme7_even <= 7'b0;
    imme10_even <= 10'b0;
    imme16_even <= 16'b0;
    imme18_even <= 18'b0;

    ra_addr_even <= 7'b0;
    rb_addr_even <= 7'b0;
    rc_addr_even <= 7'b0;

    full_instr_odd <= 32'b00000000001000000000000000000000;
    instr_id_odd <= 'instr_ID_lnop;
    reg_dst_odd <= 7'b0;
    unit_id_odd <= 3'b0;
    latency_odd <= 4'b0;
    reg_wr_odd <= 1'b0;
    imme7_odd <= 7'b0;
    imme10_odd <= 10'b0;
    imme16_odd <= 16'b0;
    imme18_odd <= 18'b0;
    
    ra_addr_odd <= 7'b0;
    rb_addr_odd <= 7'b0;
    rc_addr_odd <= 7'b0;

    // feed 0s to internal packed stages
    packed_RFFUstage_even <= 142'b0;
    packed_RFFUstage_odd <= 142'b0;
  end
  else begin
    // keeping packed info of RF stage and 1 stage for hazard check since we cannot get this from the pipes
    packed_RFFUstage_even <= packed_IDstage_even;
    packed_1stage_even <= packed_RFFUstage_even;
    packed_RFFUstage_odd <= packed_IDstage_odd;
    packed_1stage_odd <= packed_RFFUstage_odd;
  end
end

endmodule