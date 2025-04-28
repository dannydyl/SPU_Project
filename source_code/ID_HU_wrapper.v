module ID_HU_wrapper(
  input clk,
  input rst,

  input is_branch,
  input branch_taken,
  input [0:9] PC_pass_in,
  input [0:31] instruction_in1,
  input [0:31] instruction_in2,
  input find_nop,

  input [0:6] RF_reg_dst_even,
  input RF_reg_wr_even,
  input [0:142] packed_2stage_even,
  input [0:142] packed_3stage_even,
  input [0:142] packed_4stage_even,
  input [0:142] packed_5stage_even,
  input [0:142] packed_6stage_even,

  input [0:6] RF_reg_dst_odd,
  input RF_reg_wr_odd,
  input [0:142] packed_2stage_odd,
  input [0:142] packed_3stage_odd,
  input [0:142] packed_4stage_odd,
  input [0:142] packed_5stage_odd,
  input [0:142] packed_6stage_odd,

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
  output reg flush,
  output reg [0:9] PC_pass_out
);

`include "opcode_package.vh"

wire [0:142] packed_IDstage_even, packed_IDstage_odd;
reg [0:142]   packed_RFFUstage_even, packed_1stage_even, packed_RFFUstage_odd, packed_1stage_odd;

wire [0:31] temp_full_instr_even, temp_full_instr_odd;
wire [0:6] temp_instr_id_even, temp_instr_id_odd;
wire [0:6] temp_reg_dst_even, temp_reg_dst_odd;
wire [0:2] temp_unit_id_even, temp_unit_id_odd;
wire [0:3] temp_latency_even, temp_latency_odd;
wire temp_reg_wr_even, temp_reg_wr_odd;
wire [0:6] temp_imme7_even, temp_imme7_odd;
wire [0:9] temp_imme10_even, temp_imme10_odd;
wire [0:15] temp_imme16_even, temp_imme16_odd;
wire [0:17] temp_imme18_even, temp_imme18_odd;
wire [0:6] temp_ra_addr_even, temp_ra_addr_odd;
wire [0:6] temp_rb_addr_even, temp_rb_addr_odd;
wire [0:6] temp_rc_addr_even, temp_rc_addr_odd;

wire temp_stall, temp_dependent_stall, temp_flush, temp_instr1_type, temp_instr2_type;

reg [0:1] who_went_first; // 01: even, 10: odd 00: reset

Instruction_Decode ID_inst(
  .instruction_in1(instruction_in1),
  .instruction_in2(instruction_in2),

  .full_instr_even(temp_full_instr_even),
  .instr_id_even(temp_instr_id_even),
  .reg_dst_even(temp_reg_dst_even),
  .unit_id_even(temp_unit_id_even),
  .latency_even(temp_latency_even),
  .reg_wr_even(temp_reg_wr_even),
  .imme7_even(temp_imme7_even),
  .imme10_even(temp_imme10_even),
  .imme16_even(temp_imme16_even),
  .imme18_even(temp_imme18_even),

  .ra_addr_even(temp_ra_addr_even),
  .rb_addr_even(temp_rb_addr_even),
  .rc_addr_even(temp_rc_addr_even),

  .full_instr_odd(temp_full_instr_odd),
  .instr_id_odd(temp_instr_id_odd),
  .reg_dst_odd(temp_reg_dst_odd),
  .unit_id_odd(temp_unit_id_odd),
  .latency_odd(temp_latency_odd),
  .reg_wr_odd(temp_reg_wr_odd),
  .imme7_odd(temp_imme7_odd),
  .imme10_odd(temp_imme10_odd),
  .imme16_odd(temp_imme16_odd),
  .imme18_odd(temp_imme18_odd),

  .ra_addr_odd(temp_ra_addr_odd),
  .rb_addr_odd(temp_rb_addr_odd),
  .rc_addr_odd(temp_rc_addr_odd),

  .instr1_type(temp_instr1_type),
  .instr2_type(temp_instr2_type)
);

Hazard_Unit HU_inst(
  .instr1_type(temp_instr1_type),
  .instr2_type(temp_instr2_type),
  .is_branch(is_branch),
  .branch_taken(branch_taken),

  .reg_dst_even(temp_reg_dst_even),
  .ra_addr_even(temp_ra_addr_even),
  .rb_addr_even(temp_rb_addr_even),
  .rc_addr_even(temp_rc_addr_even),
  .reg_dst_odd(temp_reg_dst_odd),
  .ra_addr_odd(temp_ra_addr_odd),
  .rb_addr_odd(temp_rb_addr_odd),
  .rc_addr_odd(temp_rc_addr_odd),

  .RF_reg_dst_even(RF_reg_dst_even),
  .RF_reg_wr_even(RF_reg_wr_even),
  .packed_1stage_even(packed_1stage_even),
  .packed_2stage_even(packed_2stage_even),
  .packed_3stage_even(packed_3stage_even),
  .packed_4stage_even(packed_4stage_even),
  .packed_5stage_even(packed_5stage_even),
  .packed_6stage_even(packed_6stage_even),

  .RF_reg_dst_odd(RF_reg_dst_odd),
  .RF_reg_wr_odd(RF_reg_wr_odd),
  .packed_1stage_odd(packed_1stage_odd),
  .packed_2stage_odd(packed_2stage_odd),
  .packed_3stage_odd(packed_3stage_odd),
  .packed_4stage_odd(packed_4stage_odd),
  .packed_5stage_odd(packed_5stage_odd),
  .packed_6stage_odd(packed_6stage_odd),

  .stall(temp_stall),
  .dependent_stall(temp_dependent_stall),
  .flush(temp_flush)
);

assign packed_IDstage_even = {unit_id_even, 128'd0, reg_dst_even, latency_even, reg_wr_even};
assign packed_IDstage_odd = {unit_id_odd, 128'd0, reg_dst_odd, latency_odd, reg_wr_odd};



always @(posedge clk or posedge rst) begin
  if (rst) begin
    full_instr_even <= 32'b0;
    instr_id_even <= `instr_ID_nop;
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

    full_instr_odd <= 32'b0;
    instr_id_odd <= `instr_ID_nop;
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

    packed_RFFUstage_even <= 142'd0;
    packed_RFFUstage_odd <= 142'd0;

    stall <= 1'b0;
    dependent_stall <= 1'b0; 
    flush <= 1'b0; 
    PC_pass_out <= 10'b0;
    who_went_first <= 2'b00;
  end
  else if (temp_dependent_stall) begin // when dependency stall happens, allow first instruction go to first
    if(temp_instr1_type == 1'b0 && temp_instr2_type == 1'b0) begin
      full_instr_even <= temp_full_instr_even;
      instr_id_even <= temp_instr_id_even;
      reg_dst_even <= temp_reg_dst_even;
      unit_id_even <= temp_unit_id_even;
      latency_even <= temp_latency_even;
      reg_wr_even <= temp_reg_wr_even;
      imme7_even <= temp_imme7_even;
      imme10_even <= temp_imme10_even;
      imme16_even <= temp_imme16_even;
      imme18_even <= temp_imme18_even;
      ra_addr_even <= temp_ra_addr_even;
      rb_addr_even <= temp_rb_addr_even;
      rc_addr_even <= temp_rc_addr_even;

      full_instr_odd <= 32'b00000000001000000000000000000000;
      instr_id_odd <= `instr_ID_lnop;
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

      who_went_first <= 2'b01;

    end
    else if (temp_instr1_type == 1'b1 && temp_instr2_type == 1'b1) begin
      full_instr_even <= 32'b01000000001000000000000000000000;
      instr_id_even <= `instr_ID_nop;
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

      full_instr_odd <= temp_full_instr_odd;
      instr_id_odd <= temp_instr_id_odd;
      reg_dst_odd <= temp_reg_dst_odd;
      unit_id_odd <= temp_unit_id_odd;
      latency_odd <= temp_latency_odd;
      reg_wr_odd <= temp_reg_wr_odd;
      imme7_odd <= temp_imme7_odd;
      imme10_odd <= temp_imme10_odd;
      imme16_odd <= temp_imme16_odd;
      imme18_odd <= temp_imme18_odd;

      ra_addr_odd <= temp_ra_addr_odd;
      rb_addr_odd <= temp_rb_addr_odd;
      rc_addr_odd <= temp_rc_addr_odd;
  
      who_went_first <= 2'b10;
    end
  end
  else if (temp_stall) begin
    stall <= temp_stall;
    dependent_stall <= temp_dependent_stall;
    flush <= temp_flush;
    PC_pass_out <= PC_pass_in;
    // feed nop to both pipes
    full_instr_even <= 32'b01000000001000000000000000000000;
    instr_id_even <= `instr_ID_nop;
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
    instr_id_odd <= `instr_ID_lnop;
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
    packed_1stage_even <= packed_RFFUstage_even;
    packed_1stage_odd <= packed_RFFUstage_odd;
  end
  else if (who_went_first != 2'b00) begin // when dependency stall, allow the next instruction to go with nop
    if (who_went_first == 2'b01) begin
      full_instr_even <= 32'b0;
      instr_id_even <= `instr_ID_nop;
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

      full_instr_odd <= temp_full_instr_odd;
      instr_id_odd <= temp_instr_id_odd;
      reg_dst_odd <= temp_reg_dst_odd;
      unit_id_odd <= temp_unit_id_odd;
      latency_odd <= temp_latency_odd;
      reg_wr_odd <= temp_reg_wr_odd;
      imme7_odd <= temp_imme7_odd;
      imme10_odd <= temp_imme10_odd;
      imme16_odd <= temp_imme16_odd;
      imme18_odd <= temp_imme18_odd;

      ra_addr_odd <= temp_ra_addr_odd;
      rb_addr_odd <= temp_rb_addr_odd;
      rc_addr_odd <= temp_rc_addr_odd;

      who_went_first <= 2'b00; 
    end
    else if (who_went_first == 2'b10) begin
      full_instr_even <= temp_full_instr_even;
      instr_id_even <= temp_instr_id_even;
      reg_dst_even <= temp_reg_dst_even;
      unit_id_even <= temp_unit_id_even;
      latency_even <= temp_latency_even;
      reg_wr_even <= temp_reg_wr_even;
      imme7_even <= temp_imme7_even;
      imme10_even <= temp_imme10_even;
      imme16_even <= temp_imme16_even;
      imme18_even <= temp_imme18_even;

      ra_addr_even <= temp_ra_addr_even;
      rb_addr_even <= temp_rb_addr_even;
      rc_addr_even <= temp_rc_addr_even;

      full_instr_odd <= 32'b0;
      instr_id_odd <= `instr_ID_nop;
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

      who_went_first <= 2'b00; 
    end
  end
  else if (find_nop == 1'b1) begin
    if (temp_instr2_type == 1'b0) begin // if instr is even, lnop asserted
      full_instr_odd <= 32'b00000000001000000000000000000000;
      instr_id_odd <= `instr_ID_lnop;
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
    end
    else if (temp_instr2_type == 1'b1) begin // if instr is odd, nop asserted
      full_instr_even <= 32'b01000000001000000000000000000000;
      instr_id_even <= `instr_ID_nop;
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
    end
  end
  else begin
    // feed the decoded instruction to the next stage RF
    full_instr_even <= temp_full_instr_even;
    instr_id_even <= temp_instr_id_even;
    reg_dst_even <= temp_reg_dst_even;
    unit_id_even <= temp_unit_id_even;
    latency_even <= temp_latency_even;
    reg_wr_even <= temp_reg_wr_even;
    imme7_even <= temp_imme7_even;
    imme10_even <= temp_imme10_even;
    imme16_even <= temp_imme16_even;
    imme18_even <= temp_imme18_even;
    ra_addr_even <= temp_ra_addr_even;
    rb_addr_even <= temp_rb_addr_even;
    rc_addr_even <= temp_rc_addr_even;

    full_instr_odd <= temp_full_instr_odd;
    instr_id_odd <= temp_instr_id_odd;
    reg_dst_odd <= temp_reg_dst_odd;
    unit_id_odd <= temp_unit_id_odd;
    latency_odd <= temp_latency_odd;
    reg_wr_odd <= temp_reg_wr_odd;
    imme7_odd <= temp_imme7_odd;
    imme10_odd <= temp_imme10_odd;
    imme16_odd <= temp_imme16_odd;
    imme18_odd <= temp_imme18_odd;
    ra_addr_odd <= temp_ra_addr_odd;
    rb_addr_odd <= temp_rb_addr_odd;
    rc_addr_odd <= temp_rc_addr_odd;

    // stall signal goes to PC and flush signal goes to RFFU stage and stage 1
    stall <= temp_stall | temp_dependent_stall;
    flush <= temp_flush;
    PC_pass_out <= PC_pass_in;

    // 아래 이거 그냥 그 스테이지에서 가져오는거로 한번 바꿔보자
    // keeping packed info of RF stage and 1 stage for hazard check since we cannot get this from the pipes
    packed_RFFUstage_even <= packed_IDstage_even;
    packed_1stage_even <= packed_RFFUstage_even;
    packed_RFFUstage_odd <= packed_IDstage_odd;
    packed_1stage_odd <= packed_RFFUstage_odd;
  end
end

endmodule