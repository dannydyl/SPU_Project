module Hazard_Unit(
  input [0:1] instr_dependent_protocol,
  input [0:1] data_dependent_protocol,
  input instr1_type,
  input instr2_type,
  input is_branch,
  input branch_taken,

  input [0:6] instr_id_even,
  input [0:6] reg_dst_even,
  input [0:6] ra_addr_even,
  input [0:6] rb_addr_even,
  input [0:6] rc_addr_even,
  input [0:6] instr_id_odd,
  input [0:6] reg_dst_odd,
  input [0:6] ra_addr_odd,
  input [0:6] rb_addr_odd,
  input [0:6] rc_addr_odd,

  input [0:6] ID_reg_dst_even,
  input ID_reg_wr_even,
  input [0:6] RF_reg_dst_even, 
  input RF_reg_wr_even,
  input [0:3] RF_latency_even,
  input [0:142] packed_2stage_even,
  input [0:142] packed_3stage_even,
  input [0:142] packed_4stage_even,
  input [0:142] packed_5stage_even,
  input [0:142] packed_6stage_even,

  input [0:6] ID_reg_dst_odd,
  input ID_reg_wr_odd,
  input [0:6] RF_reg_dst_odd,
  input RF_reg_wr_odd,
  input [0:3] RF_latency_odd,
  input [0:142] packed_2stage_odd,
  input [0:142] packed_3stage_odd,
  input [0:142] packed_4stage_odd,
  input [0:142] packed_5stage_odd,
  input [0:142] packed_6stage_odd,

  output reg stall,
  output reg dependent_stall,
  output reg flush
);

`include "opcode_package.vh"

wire instr_same;

assign instr_same = (instr1_type == instr2_type) ? 1'b1 : 1'b0;
// detect when two instructions must not issue together
wire both_valid = (instr_id_even != `instr_ID_nop
                   && instr_id_odd != `instr_ID_lnop
                   && instr_id_even != `instr_ID_stop
                   && instr_id_odd != `instr_ID_stop);

wire instr_needs_rc_even = 
  (instr_id_even == `instr_ID_addx || instr_id_even == `instr_ID_bg || instr_id_even ==`instr_ID_bgx ||
    instr_id_even == `instr_ID_cgx || instr_id_even == `instr_ID_iohl || instr_id_even == `instr_ID_sfx ||
    instr_id_even == `instr_ID_fma || instr_id_even == `instr_ID_fms || instr_id_even == `instr_ID_fnms ||
    instr_id_even == `instr_ID_mpya || instr_id_even == `instr_ID_selb || instr_id_even == `instr_ID_mpyh);

wire instr_needs_rc_odd = 
  (instr_id_even == `instr_ID_brhnz || instr_id_even == `instr_ID_brz || instr_id_even == `instr_ID_brnz ||
    instr_id_even == `instr_ID_brhz);

// dependent stall only when both valid and protocols allow
always @(*) begin
  dependent_stall = 1'b0;
  if (instr_dependent_protocol==2'b00
      && data_dependent_protocol==2'b00
      && both_valid
      && (instr1_type==instr2_type 
          || reg_dst_even==reg_dst_odd)) begin
    dependent_stall = 1'b1;
  end
end

always @(*) begin
  stall = 1'b0;
  flush = 1'b0;
  
  if (branch_taken == 1'b1 && is_branch == 1'b1) begin // for now it's always predict-not-taken, later should be replaced by 2bit branch prediction signal
    flush = 1'b1;
  end

  else if ((ra_addr_even == ID_reg_dst_even || rb_addr_even == ID_reg_dst_even || (instr_needs_rc_even && rc_addr_even == ID_reg_dst_even)) && ID_reg_wr_even) begin
    stall = 1'b1;
  end
  else if ((ra_addr_even == RF_reg_dst_even || rb_addr_even == RF_reg_dst_even || (instr_needs_rc_even && rc_addr_even == RF_reg_dst_even)) && RF_reg_wr_even) begin
    if(RF_latency_even > 4'd2) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_even == packed_2stage_even[131:137] || rb_addr_even == packed_2stage_even[131:137] || (instr_needs_rc_even && rc_addr_even == packed_2stage_even[131:137])) && packed_2stage_even[142]) begin
    if(packed_2stage_even[138:141] > 4'd3) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_even == packed_3stage_even[131:137] || rb_addr_even == packed_3stage_even[131:137] || (instr_needs_rc_even && rc_addr_even == packed_3stage_even[131:137])) && packed_3stage_even[142]) begin
    if(packed_3stage_even[138:141] > 4'd4) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_even == packed_4stage_even[131:137] || rb_addr_even == packed_4stage_even[131:137] || (instr_needs_rc_even && rc_addr_even == packed_4stage_even[131:137])) && packed_4stage_even[142]) begin
    if(packed_4stage_even[138:141] > 4'd5) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_even == packed_5stage_even[131:137] || rb_addr_even == packed_5stage_even[131:137] || (instr_needs_rc_even && rc_addr_even == packed_5stage_even[131:137])) && packed_5stage_even[142]) begin
    if(packed_5stage_even[138:141] > 4'd6) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_even == packed_6stage_even[131:137] || rb_addr_even == packed_6stage_even[131:137] || (instr_needs_rc_even && rc_addr_even == packed_6stage_even[131:137])) && packed_6stage_even[142]) begin
    if(packed_6stage_even[138:141] > 4'd7) begin
      stall = 1'b1;
    end
  end

  else if ((ra_addr_odd == ID_reg_dst_odd || rb_addr_odd == ID_reg_dst_odd || (instr_needs_rc_odd && rc_addr_odd == ID_reg_dst_odd)) && ID_reg_wr_odd) begin
    stall = 1'b1;
  end
  else if ((ra_addr_odd == RF_reg_dst_odd || rb_addr_odd == RF_reg_dst_odd || (instr_needs_rc_odd && rc_addr_odd == RF_reg_dst_odd)) && RF_reg_wr_odd) begin
    if(RF_latency_odd > 4'd2) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_odd == packed_2stage_odd[131:137] || rb_addr_odd == packed_2stage_odd[131:137] || (instr_needs_rc_odd && rc_addr_odd == packed_2stage_even[131:137])) && packed_2stage_odd[142]) begin
    if(packed_2stage_odd[138:141] > 4'd3) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_odd == packed_3stage_odd[131:137] || rb_addr_odd == packed_3stage_odd[131:137] || (instr_needs_rc_odd && rc_addr_odd == packed_3stage_even[131:137])) && packed_3stage_odd[142]) begin
    if(packed_3stage_odd[138:141] > 4'd4) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_odd == packed_4stage_odd[131:137] || rb_addr_odd == packed_4stage_odd[131:137] || (instr_needs_rc_odd && rc_addr_odd == packed_4stage_even[131:137])) && packed_4stage_odd[142]) begin
    if(packed_4stage_odd[138:141] > 4'd5) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_odd == packed_5stage_odd[131:137] || rb_addr_odd == packed_5stage_odd[131:137] || (instr_needs_rc_odd && rc_addr_odd == packed_5stage_even[131:137])) && packed_5stage_odd[142]) begin
    if(packed_5stage_odd[138:141] > 4'd6) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_odd == packed_6stage_odd[131:137] || rb_addr_odd == packed_6stage_odd[131:137] || (instr_needs_rc_odd && rc_addr_odd == packed_6stage_even[131:137])) && packed_6stage_odd[142]) begin
    if(packed_6stage_odd[138:141] > 4'd7) begin
      stall = 1'b1;
    end
  end

  // cross stage hazard detection
  else if ((ra_addr_even == ID_reg_dst_odd || rb_addr_even == ID_reg_dst_odd || (instr_needs_rc_even && rc_addr_even == ID_reg_dst_odd)) && ID_reg_wr_odd) begin
    stall = 1'b1;
  end
  else if ((ra_addr_even == RF_reg_dst_odd || rb_addr_even == RF_reg_dst_odd || (instr_needs_rc_even && rc_addr_even == RF_reg_dst_odd)) && RF_reg_wr_odd) begin
    if(RF_latency_odd > 4'd2) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_even == packed_2stage_odd[131:137] || rb_addr_even == packed_2stage_odd[131:137] || (instr_needs_rc_even && rc_addr_even == packed_2stage_odd[131:137])) && packed_2stage_odd[142]) begin
    if(packed_2stage_odd[138:141] > 4'd3) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_even == packed_3stage_odd[131:137] || rb_addr_even == packed_3stage_odd[131:137] || (instr_needs_rc_even && rc_addr_even == packed_3stage_odd[131:137])) && packed_3stage_odd[142]) begin
    if(packed_3stage_odd[138:141] > 4'd4) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_even == packed_4stage_odd[131:137] || rb_addr_even == packed_4stage_odd[131:137] || (instr_needs_rc_even && rc_addr_even == packed_4stage_odd[131:137])) && packed_4stage_odd[142]) begin
    if(packed_4stage_odd[138:141] > 4'd5) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_even == packed_5stage_odd[131:137] || rb_addr_even == packed_5stage_odd[131:137] || (instr_needs_rc_even && rc_addr_even == packed_5stage_odd[131:137])) && packed_5stage_odd[142]) begin
    if(packed_5stage_odd[138:141] > 4'd6) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_even == packed_6stage_odd[131:137] || rb_addr_even == packed_6stage_odd[131:137] || (instr_needs_rc_even && rc_addr_even == packed_6stage_odd[131:137])) && packed_6stage_odd[142]) begin
    if(packed_6stage_odd[138:141] > 4'd7) begin
      stall = 1'b1;
    end
  end

  else if ((ra_addr_odd == ID_reg_dst_even || rb_addr_odd == ID_reg_dst_even  || (instr_needs_rc_odd && rc_addr_odd == ID_reg_dst_even)) && ID_reg_wr_even) begin
    stall = 1'b1;
  end
  else if ((ra_addr_odd == RF_reg_dst_even || rb_addr_odd == RF_reg_dst_even || (instr_needs_rc_odd && rc_addr_odd == RF_reg_dst_even)) && RF_reg_wr_even) begin
    if(RF_latency_even > 4'd2) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_odd == packed_2stage_even[131:137] || rb_addr_odd == packed_2stage_even[131:137] || (instr_needs_rc_odd && rc_addr_odd == packed_2stage_even[131:137])) && packed_2stage_even[142]) begin
    if(packed_2stage_even[138:141] > 4'd3) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_odd == packed_3stage_even[131:137] || rb_addr_odd == packed_3stage_even[131:137] || (instr_needs_rc_odd && rc_addr_odd == packed_3stage_even[131:137])) && packed_3stage_even[142]) begin
    if(packed_3stage_even[138:141] > 4'd4) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_odd == packed_4stage_even[131:137] || rb_addr_odd == packed_4stage_even[131:137] || (instr_needs_rc_odd && rc_addr_odd == packed_4stage_even[131:137])) && packed_4stage_even[142]) begin
    if(packed_4stage_even[138:141] > 4'd5) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_odd == packed_5stage_even[131:137] || rb_addr_odd == packed_5stage_even[131:137] || (instr_needs_rc_odd && rc_addr_odd == packed_5stage_even[131:137])) && packed_5stage_even[142]) begin
    if(packed_5stage_even[138:141] > 4'd6) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_odd == packed_6stage_even[131:137] || rb_addr_odd == packed_6stage_even[131:137] || (instr_needs_rc_odd && rc_addr_odd == packed_6stage_even[131:137])) && packed_6stage_even[142]) begin
    if(packed_6stage_even[138:141] > 4'd7) begin
      stall = 1'b1;
    end
  end
  else begin
    stall = 1'b0;
    // dependent_stall = 1'b0;
    flush = 1'b0;
  end
end

endmodule
