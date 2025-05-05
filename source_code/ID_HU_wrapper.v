module ID_HU_wrapper(
  input clk,
  input rst,

  input is_branch,
  input branch_taken,
  input flush_instr2_even,
  input [0:8] PC_pass_in,
  input [0:31] instruction_in1,
  input [0:31] instruction_in2,
  input find_nop,

  input [0:6] RF_reg_dst_even,
  input RF_reg_wr_even,
  input [0:3] RF_latency_even,
  input [0:142] packed_2stage_even,
  input [0:142] packed_3stage_even,
  input [0:142] packed_4stage_even,
  input [0:142] packed_5stage_even,
  input [0:142] packed_6stage_even,

  input [0:6] RF_reg_dst_odd,
  input RF_reg_wr_odd,
  input [0:3] RF_latency_odd,
  input [0:142] packed_2stage_odd,
  input [0:142] packed_3stage_odd,
  input [0:142] packed_4stage_odd,
  input [0:142] packed_5stage_odd,
  input [0:142] packed_6stage_odd,

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

  output reg instr1_branch,
  output wire stall,
  output reg flush,
  output reg flush_4stage,
  output reg [0:8] PC_pass_out
);

`include "opcode_package.vh"

wire [0:142] packed_IDstage_even, packed_IDstage_odd;
reg [0:142]   packed_RFFUstage_even, packed_1stage_even, packed_RFFUstage_odd, packed_1stage_odd;

wire [0:6] temp_instr_id_1, temp_instr_id_2;
wire [0:6] temp_reg_dst_1, temp_reg_dst_2;
wire [0:2] temp_unit_id_1, temp_unit_id_2;
wire [0:3] temp_latency_1, temp_latency_2;
wire temp_reg_wr_1, temp_reg_wr_2;
wire [0:6] temp_imme7_1, temp_imme7_2;
wire [0:9] temp_imme10_1, temp_imme10_2;
wire [0:15] temp_imme16_1, temp_imme16_2;
wire [0:17] temp_imme18_1, temp_imme18_2;
wire [0:6] temp_ra_addr_1, temp_ra_addr_2;
wire [0:6] temp_rb_addr_1, temp_rb_addr_2;
wire [0:6] temp_rc_addr_1, temp_rc_addr_2;

reg [0:6] temp_reg_dst_even, temp_reg_dst_odd, temp_ra_addr_even, temp_ra_addr_odd,
            temp_rb_addr_even, temp_rb_addr_odd, temp_rc_addr_even, temp_rc_addr_odd;

wire temp_stall, temp_dependent_stall, temp_flush, temp_instr1_type, temp_instr2_type;

reg [0:6] temp_instr_id_even, temp_instr_id_odd;
reg [0:1] instr_dependent_protocol; // 01: even, 10: odd 00: reset
reg [0:1] data_dependent_protocol; // 01: even, 10: odd 00: reset

Instruction_Decode ID_inst(
  .instruction_in1(instruction_in1),
  .instruction_in2(instruction_in2),

  .instr_id_1(temp_instr_id_1),
  .reg_dst_1(temp_reg_dst_1),
  .unit_id_1(temp_unit_id_1),
  .latency_1(temp_latency_1),
  .reg_wr_1(temp_reg_wr_1),
  .imme7_1(temp_imme7_1),
  .imme10_1(temp_imme10_1),
  .imme16_1(temp_imme16_1),
  .imme18_1(temp_imme18_1),

  .ra_addr_1(temp_ra_addr_1),
  .rb_addr_1(temp_rb_addr_1),
  .rc_addr_1(temp_rc_addr_1),

  .instr_id_2(temp_instr_id_2),
  .reg_dst_2(temp_reg_dst_2),
  .unit_id_2(temp_unit_id_2),
  .latency_2(temp_latency_2),
  .reg_wr_2(temp_reg_wr_2),
  .imme7_2(temp_imme7_2),
  .imme10_2(temp_imme10_2),
  .imme16_2(temp_imme16_2),
  .imme18_2(temp_imme18_2),

  .ra_addr_2(temp_ra_addr_2),
  .rb_addr_2(temp_rb_addr_2),
  .rc_addr_2(temp_rc_addr_2),

  .instr1_type(temp_instr1_type),
  .instr2_type(temp_instr2_type)
);

//assign temp_reg_dst_even = temp_instr1_type ? temp_reg_dst_1 : temp_reg_dst_2;
//assign temp_ra_addr_even = temp_instr1_type ? temp_ra_addr_1 : temp_ra_addr_2;
//assign temp_rb_addr_even = temp_instr1_type ? temp_rb_addr_1 : temp_rb_addr_2;
//assign temp_rc_addr_even = temp_instr1_type ? temp_rc_addr_1 : temp_rc_addr_2;
//assign temp_reg_dst_odd = temp_instr2_type ? temp_reg_dst_1 : temp_reg_dst_2;
//assign temp_ra_addr_odd = temp_instr2_type ? temp_ra_addr_1 : temp_ra_addr_2;
//assign temp_rb_addr_odd = temp_instr2_type ? temp_rb_addr_1 : temp_rb_addr_2;
//assign temp_rc_addr_odd = temp_instr2_type ? temp_rc_addr_1 : temp_rc_addr_2;
//assign temp_instr_id_even = temp_instr1_type ? temp_instr_id_1 : temp_instr_id_2;
//assign temp_instr_id_odd = temp_instr2_type ? temp_instr_id_1 : temp_instr_id_2;
always @(*) begin
  if ((temp_instr1_type == 1'b1) && (temp_instr2_type == 1'b0)) begin
    temp_reg_dst_even = temp_reg_dst_1;
    temp_ra_addr_even = temp_ra_addr_1;
    temp_rb_addr_even = temp_rb_addr_1;
    temp_rc_addr_even = temp_rc_addr_1;
    temp_reg_dst_odd = temp_reg_dst_2;
    temp_ra_addr_odd = temp_ra_addr_2;
    temp_rb_addr_odd = temp_rb_addr_2;
    temp_rc_addr_odd = temp_rc_addr_2;
    temp_instr_id_even = temp_instr_id_1;
    temp_instr_id_odd = temp_instr_id_2;
  end
  else if ((temp_instr1_type == 1'b0) && (temp_instr2_type == 1'b0)) begin
    temp_reg_dst_even = temp_reg_dst_2;
    temp_ra_addr_even = temp_ra_addr_2;
    temp_rb_addr_even = temp_rb_addr_2;
    temp_rc_addr_even = temp_rc_addr_2;
    temp_reg_dst_odd = temp_reg_dst_1;
    temp_ra_addr_odd = temp_ra_addr_1;
    temp_rb_addr_odd = temp_rb_addr_1;
    temp_rc_addr_odd = temp_rc_addr_1;
    temp_instr_id_even = temp_instr_id_2;
    temp_instr_id_odd = temp_instr_id_1;
  end
  else if ((temp_instr1_type == 1'b1) && (temp_instr2_type == 1'b1)) begin
    temp_reg_dst_even = temp_reg_dst_2;
    temp_ra_addr_even = temp_ra_addr_2;
    temp_rb_addr_even = temp_rb_addr_2;
    temp_rc_addr_even = temp_rc_addr_2;
    temp_reg_dst_odd = 0;
    temp_ra_addr_odd = 0;
    temp_rb_addr_odd = 0;
    temp_rc_addr_odd = 0;
    temp_instr_id_even = temp_instr_id_2;
    temp_instr_id_odd = 0;
  end
  else if ((temp_instr1_type == 1'b0) && (temp_instr2_type == 1'b0)) begin
    temp_reg_dst_odd = temp_reg_dst_2;
    temp_ra_addr_odd = temp_ra_addr_2;
    temp_rb_addr_odd = temp_rb_addr_2;
    temp_rc_addr_odd = temp_rc_addr_2;
    temp_reg_dst_even = 0;
    temp_ra_addr_even = 0;
    temp_rb_addr_even = 0;
    temp_rc_addr_even = 0;
    temp_instr_id_even = 0;
    temp_instr_id_odd = temp_instr_id_2;
  end
end
Hazard_Unit HU_inst(
  .instr_dependent_protocol(instr_dependent_protocol),
  .data_dependent_protocol(data_dependent_protocol),
  .instr1_type(temp_instr1_type),
  .instr2_type(temp_instr2_type),
  .is_branch(is_branch),
  .branch_taken(branch_taken),

  .instr_id_even(temp_instr_id_even),
  .reg_dst_even(temp_reg_dst_even),
  .ra_addr_even(temp_ra_addr_even),
  .rb_addr_even(temp_rb_addr_even),
  .rc_addr_even(temp_rc_addr_even),
  .instr_id_odd(temp_instr_id_odd),
  .reg_dst_odd(temp_reg_dst_odd),
  .ra_addr_odd(temp_ra_addr_odd),
  .rb_addr_odd(temp_rb_addr_odd),
  .rc_addr_odd(temp_rc_addr_odd),

  .ID_reg_dst_even(reg_dst_even),
  .ID_reg_wr_even(reg_wr_even),
  .RF_reg_dst_even(RF_reg_dst_even),
  .RF_reg_wr_even(RF_reg_wr_even),
  .RF_latency_even(RF_latency_even),
  .packed_2stage_even(packed_2stage_even),
  .packed_3stage_even(packed_3stage_even),
  .packed_4stage_even(packed_4stage_even),
  .packed_5stage_even(packed_5stage_even),
  .packed_6stage_even(packed_6stage_even),

  .ID_reg_dst_odd(reg_dst_odd),
  .ID_reg_wr_odd(reg_wr_odd),
  .RF_reg_dst_odd(RF_reg_dst_odd),
  .RF_reg_wr_odd(RF_reg_wr_odd),
  .RF_latency_odd(RF_latency_odd),
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
assign stall = temp_stall | temp_dependent_stall;


always @(posedge clk or posedge rst) begin
instr1_branch <= 1'b0;
  if (rst) begin
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

    packed_RFFUstage_even <= 142'd0;
    packed_RFFUstage_odd <= 142'd0;

    instr1_branch <= 1'b0;
    flush <= 1'b0; 
    PC_pass_out <= 10'b0;
    instr_dependent_protocol <= 2'b00;
    data_dependent_protocol <= 2'b00;
  end
  else if (temp_dependent_stall) begin // when dependency stall happens, allow first instruction go to first
    if(temp_instr1_type == 1'b1 && temp_instr2_type == 1'b1) begin // if both instrs are even
      instr_id_even <= temp_instr_id_1;
      reg_dst_even <= temp_reg_dst_1;
      unit_id_even <= temp_unit_id_1;
      latency_even <= temp_latency_1;
      reg_wr_even <= temp_reg_wr_1;
      imme7_even <= temp_imme7_1;
      imme10_even <= temp_imme10_1;
      imme16_even <= temp_imme16_1;
      imme18_even <= temp_imme18_1;
      ra_addr_even <= temp_ra_addr_1;
      rb_addr_even <= temp_rb_addr_1;
      rc_addr_even <= temp_rc_addr_1;

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

      instr_dependent_protocol <= 2'b01;

    end
    else if (temp_instr1_type == 1'b0 && temp_instr2_type == 1'b0) begin // if both instrs are odd
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

      instr_id_odd <= temp_instr_id_1;
      reg_dst_odd <= temp_reg_dst_1;
      unit_id_odd <= temp_unit_id_1;
      latency_odd <= temp_latency_1;
      reg_wr_odd <= temp_reg_wr_1;
      imme7_odd <= temp_imme7_1;
      imme10_odd <= temp_imme10_1;
      imme16_odd <= temp_imme16_1;
      imme18_odd <= temp_imme18_1;

      ra_addr_odd <= temp_ra_addr_1;
      rb_addr_odd <= temp_rb_addr_1;
      rc_addr_odd <= temp_rc_addr_1;
  
      instr_dependent_protocol <= 2'b10;
    end
    // data dependent stall
    else if (temp_instr1_type == 1'b1) begin  // instr1 go first and it's even
      instr_id_even <= temp_instr_id_1;
      reg_dst_even <= temp_reg_dst_1;
      unit_id_even <= temp_unit_id_1;
      latency_even <= temp_latency_1;
      reg_wr_even <= temp_reg_wr_1;
      imme7_even <= temp_imme7_1;
      imme10_even <= temp_imme10_1;
      imme16_even <= temp_imme16_1;
      imme18_even <= temp_imme18_1;

      ra_addr_even <= temp_ra_addr_1;
      rb_addr_even <= temp_rb_addr_1;
      rc_addr_even <= temp_rc_addr_1;

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

      data_dependent_protocol <= 2'b01;
    end
    else if (temp_instr1_type == 1'b0) begin // instr1 go first and it's odd
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

      instr_id_odd <= temp_instr_id_1;
      reg_dst_odd <= temp_reg_dst_1;
      unit_id_odd <= temp_unit_id_1;
      latency_odd <= temp_latency_1;
      reg_wr_odd <= temp_reg_wr_1;
      imme7_odd <= temp_imme7_1;
      imme10_odd <= temp_imme10_1;
      imme16_odd <= temp_imme16_1;
      imme18_odd <= temp_imme18_1;

      ra_addr_odd <= temp_ra_addr_1;
      rb_addr_odd <= temp_rb_addr_1;
      rc_addr_odd <= temp_rc_addr_1;

      data_dependent_protocol <= 2'b10;
    end
  end
  else if (temp_stall) begin
    // feed nop to both pipes
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
  else if (instr_dependent_protocol != 2'b00) begin // when dependency stall, allow the next instruction to go with nop
    if (instr_dependent_protocol == 2'b01) begin // next even instr go
      instr_id_even <= temp_instr_id_2;
      reg_dst_even <= temp_reg_dst_2;
      unit_id_even <= temp_unit_id_2;
      latency_even <= temp_latency_2;
      reg_wr_even <= temp_reg_wr_2;
      imme7_even <= temp_imme7_2;
      imme10_even <= temp_imme10_2;
      imme16_even <= temp_imme16_2;
      imme18_even <= temp_imme18_2;

      ra_addr_even <= temp_ra_addr_2;
      rb_addr_even <= temp_rb_addr_2;
      rc_addr_even <= temp_rc_addr_2;

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

      instr_dependent_protocol <= 2'b00; 
    end
    else if (instr_dependent_protocol == 2'b10) begin // next odd instr go
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

      instr_id_odd <= temp_instr_id_2;
      reg_dst_odd <= temp_reg_dst_2;
      unit_id_odd <= temp_unit_id_2;
      latency_odd <= temp_latency_2;
      reg_wr_odd <= temp_reg_wr_2;
      imme7_odd <= temp_imme7_2;
      imme10_odd <= temp_imme10_2;
      imme16_odd <= temp_imme16_2;
      imme18_odd <= temp_imme18_2;

      ra_addr_odd <= temp_ra_addr_2;
      rb_addr_odd <= temp_rb_addr_2;
      rc_addr_odd <= temp_rc_addr_2;

      instr_dependent_protocol <= 2'b00; 
    end
  end
  else if (data_dependent_protocol != 2'b00) begin
    if (data_dependent_protocol == 2'b01) begin // next odd instr2 go when instr1 was even
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

      instr_id_odd <= temp_instr_id_2;
      reg_dst_odd <= temp_reg_dst_2;
      unit_id_odd <= temp_unit_id_2;
      latency_odd <= temp_latency_2;
      reg_wr_odd <= temp_reg_wr_2;
      imme7_odd <= temp_imme7_2;
      imme10_odd <= temp_imme10_2;
      imme16_odd <= temp_imme16_2;
      imme18_odd <= temp_imme18_2;

      ra_addr_odd <= temp_ra_addr_2;
      rb_addr_odd <= temp_rb_addr_2;
      rc_addr_odd <= temp_rc_addr_2;

      data_dependent_protocol <= 2'b00;
    end
    else if (data_dependent_protocol == 2'b10) begin // next even instr2 go when instr1 was odd
      instr_id_even <= temp_instr_id_2;
      reg_dst_even <= temp_reg_dst_2;
      unit_id_even <= temp_unit_id_2;
      latency_even <= temp_latency_2;
      reg_wr_even <= temp_reg_wr_2;
      imme7_even <= temp_imme7_2;
      imme10_even <= temp_imme10_2;
      imme16_even <= temp_imme16_2;
      imme18_even <= temp_imme18_2;

      ra_addr_even <= temp_ra_addr_2;
      rb_addr_even <= temp_rb_addr_2;
      rc_addr_even <= temp_rc_addr_2;

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

      data_dependent_protocol <= 2'b00;
    end
  end
  else if (find_nop == 1'b1) begin
    if (temp_instr2_type == 1'b1) begin // if instr is even, lnop asserted
      instr_id_even <= temp_instr_id_2;
      reg_dst_even <= temp_reg_dst_2;
      unit_id_even <= temp_unit_id_2;
      latency_even <= temp_latency_2;
      reg_wr_even <= temp_reg_wr_2;
      imme7_even <= temp_imme7_2;
      imme10_even <= temp_imme10_2;
      imme16_even <= temp_imme16_2;
      imme18_even <= temp_imme18_2;

      ra_addr_even <= temp_ra_addr_2;
      rb_addr_even <= temp_rb_addr_2;
      rc_addr_even <= temp_rc_addr_2;

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
    else if (temp_instr2_type == 1'b0) begin // if instr is odd, nop asserted
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

      instr_id_odd <= temp_instr_id_2;
      reg_dst_odd <= temp_reg_dst_2;
      unit_id_odd <= temp_unit_id_2;
      latency_odd <= temp_latency_2;
      reg_wr_odd <= temp_reg_wr_2;
      imme7_odd <= temp_imme7_2;
      imme10_odd <= temp_imme10_2;
      imme16_odd <= temp_imme16_2;
      imme18_odd <= temp_imme18_2;

      ra_addr_odd <= temp_ra_addr_2;
      rb_addr_odd <= temp_rb_addr_2;
      rc_addr_odd <= temp_rc_addr_2;
    end
  end
  else if (temp_instr_id_1 == `instr_ID_stop || temp_instr_id_2 == `instr_ID_stop) begin // when one of instr is stop
    if(temp_instr_id_1 != `instr_ID_stop && temp_instr1_type == 1'b1) begin
      instr_id_even <= temp_instr_id_1;
      reg_dst_even <= temp_reg_dst_1;
      unit_id_even <= temp_unit_id_1;
      latency_even <= temp_latency_1;
      reg_wr_even <= temp_reg_wr_1;
      imme7_even <= temp_imme7_1;
      imme10_even <= temp_imme10_1;
      imme16_even <= temp_imme16_1;
      imme18_even <= temp_imme18_1;
      ra_addr_even <= temp_ra_addr_1;
      rb_addr_even <= temp_rb_addr_1;
      rc_addr_even <= temp_rc_addr_1;

      instr_id_odd <= `instr_ID_stop;
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
    else if (temp_instr_id_1 != `instr_ID_stop && temp_instr1_type == 1'b0) begin
      instr_id_even <= `instr_ID_stop;
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

      instr_id_odd <= temp_instr_id_1;
      reg_dst_odd <= temp_reg_dst_1;
      unit_id_odd <= temp_unit_id_1;
      latency_odd <= temp_latency_1;
      reg_wr_odd <= temp_reg_wr_1;
      imme7_odd <= temp_imme7_1;
      imme10_odd <= temp_imme10_1;
      imme16_odd <= temp_imme16_1;
      imme18_odd <= temp_imme18_1;

      ra_addr_odd <= temp_ra_addr_1;
      rb_addr_odd <= temp_rb_addr_1;
      rc_addr_odd <= temp_rc_addr_1;

    end
    else if(temp_instr_id_2 != `instr_ID_stop && temp_instr2_type == 1'b1) begin
      instr_id_even <= temp_instr_id_2;
      reg_dst_even <= temp_reg_dst_2;
      unit_id_even <= temp_unit_id_2;
      latency_even <= temp_latency_2;
      reg_wr_even <= temp_reg_wr_2;
      imme7_even <= temp_imme7_2;
      imme10_even <= temp_imme10_2;
      imme16_even <= temp_imme16_2;
      imme18_even <= temp_imme18_2;

      ra_addr_even <= temp_ra_addr_2;
      rb_addr_even <= temp_rb_addr_2;
      rc_addr_even <= temp_rc_addr_2;

      instr_id_odd <= `instr_ID_stop;
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
    else if(temp_instr_id_2 != `instr_ID_stop && temp_instr2_type == 1'b0) begin
      instr_id_even <= `instr_ID_stop;
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

      instr_id_odd <= temp_instr_id_2;
      reg_dst_odd <= temp_reg_dst_2;
      unit_id_odd <= temp_unit_id_2;
      latency_odd <= temp_latency_2;
      reg_wr_odd <= temp_reg_wr_2;
      imme7_odd <= temp_imme7_2;
      imme10_odd <= temp_imme10_2;
      imme16_odd <= temp_imme16_2;
      imme18_odd <= temp_imme18_2;

      ra_addr_odd <= temp_ra_addr_2;
      rb_addr_odd <= temp_rb_addr_2;
      rc_addr_odd <= temp_rc_addr_2;

    end
    else if(temp_instr_id_2 != `instr_ID_stop && temp_instr2_type ) begin
      instr_id_even <= temp_instr_id_1;
      reg_dst_even <= temp_reg_dst_1;
      unit_id_even <= temp_unit_id_1;
      latency_even <= temp_latency_1;
      reg_wr_even <= temp_reg_wr_1;
      imme7_even <= temp_imme7_1;
      imme10_even <= temp_imme10_1;
      imme16_even <= temp_imme16_1;
      imme18_even <= temp_imme18_1;

      ra_addr_even <= temp_ra_addr_1;
      rb_addr_even <= temp_rb_addr_1;
      rc_addr_even <= temp_rc_addr_1;
    end
  end
  else begin
    // feed the decoded instruction to the next stage RF
    if(temp_instr1_type == 1'b1) begin
      instr_id_even <= temp_instr_id_1;
      reg_dst_even <= temp_reg_dst_1;
      unit_id_even <= temp_unit_id_1;
      latency_even <= temp_latency_1;
      reg_wr_even <= temp_reg_wr_1;
      imme7_even <= temp_imme7_1;
      imme10_even <= temp_imme10_1;
      imme16_even <= temp_imme16_1;
      imme18_even <= temp_imme18_1;
      ra_addr_even <= temp_ra_addr_1;
      rb_addr_even <= temp_rb_addr_1;
      rc_addr_even <= temp_rc_addr_1;
    end
    else begin
      instr_id_odd <= temp_instr_id_1;
      reg_dst_odd <= temp_reg_dst_1;
      unit_id_odd <= temp_unit_id_1;
      latency_odd <= temp_latency_1;
      reg_wr_odd <= temp_reg_wr_1;
      imme7_odd <= temp_imme7_1;
      imme10_odd <= temp_imme10_1;
      imme16_odd <= temp_imme16_1;
      imme18_odd <= temp_imme18_1;
      ra_addr_odd <= temp_ra_addr_1;
      rb_addr_odd <= temp_rb_addr_1;
      rc_addr_odd <= temp_rc_addr_1;
    end

    if(temp_instr2_type == 1'b1) begin
      instr_id_even <= temp_instr_id_2;
      reg_dst_even <= temp_reg_dst_2;
      unit_id_even <= temp_unit_id_2;
      latency_even <= temp_latency_2;
      reg_wr_even <= temp_reg_wr_2;
      imme7_even <= temp_imme7_2;
      imme10_even <= temp_imme10_2;
      imme16_even <= temp_imme16_2;
      imme18_even <= temp_imme18_2;

      ra_addr_even <= temp_ra_addr_2;
      rb_addr_even <= temp_rb_addr_2;
      rc_addr_even <= temp_rc_addr_2;

    end
    else begin
      instr_id_odd <= temp_instr_id_2;
      reg_dst_odd <= temp_reg_dst_2;
      unit_id_odd <= temp_unit_id_2;
      latency_odd <= temp_latency_2;
      reg_wr_odd <= temp_reg_wr_2;
      imme7_odd <= temp_imme7_2;
      imme10_odd <= temp_imme10_2;
      imme16_odd <= temp_imme16_2;
      imme18_odd <= temp_imme18_2;

      ra_addr_odd <= temp_ra_addr_2;
      rb_addr_odd <= temp_rb_addr_2;
      rc_addr_odd <= temp_rc_addr_2;
    end

  end
  if (temp_unit_id_1 == 3'b111) begin // send signal to Odd pipe that instr1 is branch
    instr1_branch <= 1'b1;
  end
  flush_4stage <= flush_instr2_even;
  flush <= temp_flush;
  PC_pass_out <= PC_pass_in;
  // stall <= temp_stall | temp_dependent_stall;
end

endmodule
