module Hazard_Unit(
  input [0:1] instr_dependent_protocol,
  input instr1_type,
  input instr2_type,
  input is_branch,
  input branch_taken,

  input [0:6] reg_dst_even,
  input [0:6] ra_addr_even,
  input [0:6] rb_addr_even,
  input [0:6] rc_addr_even,
  input [0:6] reg_dst_odd,
  input [0:6] ra_addr_odd,
  input [0:6] rb_addr_odd,
  input [0:6] rc_addr_odd,

  input [0:6] ID_reg_dst_even,
  input ID_reg_wr_even,
  input [0:6] RF_reg_dst_even, // 얘가 사실상 stage 1이 가지고 잇는 정보야
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


always @(*) begin
  if (instr_dependent_protocol != 2'b00) begin
    dependent_stall = 1'b0;
  end
  else if (instr1_type == instr2_type) begin
    dependent_stall = 1'b1;
  end

  else if (reg_dst_even == reg_dst_odd) begin // 생각해보니까 이것도 dependent_stall이네
    dependent_stall = 1'b1;
  end
  
  else if (branch_taken == is_branch) begin // for now it's always predict-not-taken, later should be replaced by branch prediction signal
    flush = 1'b1;
  end

  else if ((ra_addr_even == ID_reg_dst_even || rb_addr_even == ID_reg_dst_even || rc_addr_even == ID_reg_dst_even) && ID_reg_wr_even) begin
    stall = 1'b1;
  end
  else if ((ra_addr_even == RF_reg_dst_even || rb_addr_even == RF_reg_dst_even || rc_addr_even == RF_reg_dst_even) && RF_reg_wr_even) begin
    if(RF_latency_even > 4'd2) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_even == packed_2stage_even[131:137] || rb_addr_even == packed_2stage_even[131:137] || rc_addr_even == packed_2stage_even[131:137]) && packed_2stage_even[142]) begin
    if(packed_2stage_even[138:141] > 4'd3) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_even == packed_3stage_even[131:137] || rb_addr_even == packed_3stage_even[131:137] || rc_addr_even == packed_3stage_even[131:137]) && packed_3stage_even[142]) begin
    if(packed_3stage_even[138:141] > 4'd4) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_even == packed_4stage_even[131:137] || rb_addr_even == packed_4stage_even[131:137] || rc_addr_even == packed_4stage_even[131:137]) && packed_4stage_even[142]) begin
    if(packed_4stage_even[138:141] > 4'd5) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_even == packed_5stage_even[131:137] || rb_addr_even == packed_5stage_even[131:137] || rc_addr_even == packed_5stage_even[131:137]) && packed_5stage_even[142]) begin
    if(packed_5stage_even[138:141] > 4'd6) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_even == packed_6stage_even[131:137] || rb_addr_even == packed_6stage_even[131:137] || rc_addr_even == packed_6stage_even[131:137]) && packed_6stage_even[142]) begin
    if(packed_6stage_even[138:141] > 4'd7) begin
      stall = 1'b1;
    end
  end

  else if ((ra_addr_odd == ID_reg_dst_odd || rb_addr_odd == ID_reg_dst_odd || rc_addr_odd == ID_reg_dst_odd) && ID_reg_wr_odd) begin
    stall = 1'b1;
  end
  else if ((ra_addr_odd == RF_reg_dst_odd || rb_addr_odd == RF_reg_dst_odd || rc_addr_odd == RF_reg_dst_odd) && RF_reg_wr_odd) begin
    if(RF_latency_odd > 4'd2) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_odd == packed_2stage_odd[131:137] || rb_addr_odd == packed_2stage_odd[131:137] || rc_addr_odd == packed_2stage_odd[131:137]) && packed_2stage_odd[142]) begin
    if(packed_2stage_odd[138:141] > 4'd3) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_odd == packed_3stage_odd[131:137] || rb_addr_odd == packed_3stage_odd[131:137] || rc_addr_odd == packed_3stage_odd[131:137]) && packed_3stage_odd[142]) begin
    if(packed_3stage_odd[138:141] > 4'd4) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_odd == packed_4stage_odd[131:137] || rb_addr_odd == packed_4stage_odd[131:137] || rc_addr_odd == packed_4stage_odd[131:137]) && packed_4stage_odd[142]) begin
    if(packed_4stage_odd[138:141] > 4'd5) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_odd == packed_5stage_odd[131:137] || rb_addr_odd == packed_5stage_odd[131:137] || rc_addr_odd == packed_5stage_odd[131:137]) && packed_5stage_odd[142]) begin
    if(packed_5stage_odd[138:141] > 4'd6) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_odd == packed_6stage_odd[131:137] || rb_addr_odd == packed_6stage_odd[131:137] || rc_addr_odd == packed_6stage_odd[131:137]) && packed_6stage_odd[142]) begin
    if(packed_6stage_odd[138:141] > 4'd7) begin
      stall = 1'b1;
    end
  end

  else if ((ra_addr_even == ID_reg_dst_odd || rb_addr_even == ID_reg_dst_odd || rc_addr_even == ID_reg_dst_odd) && ID_reg_wr_odd) begin
    stall = 1'b1;
  end
  else if ((ra_addr_even == RF_reg_dst_odd || rb_addr_even == RF_reg_dst_odd || rc_addr_even == RF_reg_dst_odd) && RF_reg_wr_odd) begin
    if(RF_latency_odd > 4'd2) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_even == packed_2stage_odd[131:137] || rb_addr_even == packed_2stage_odd[131:137] || rc_addr_even == packed_2stage_odd[131:137]) && packed_2stage_odd[142]) begin
    if(packed_2stage_odd[138:141] > 4'd3) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_even == packed_3stage_odd[131:137] || rb_addr_even == packed_3stage_odd[131:137] || rc_addr_even == packed_3stage_odd[131:137]) && packed_3stage_odd[142]) begin
    if(packed_3stage_odd[138:141] > 4'd4) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_even == packed_4stage_odd[131:137] || rb_addr_even == packed_4stage_odd[131:137] || rc_addr_even == packed_4stage_odd[131:137]) && packed_4stage_odd[142]) begin
    if(packed_4stage_odd[138:141] > 4'd5) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_even == packed_5stage_odd[131:137] || rb_addr_even == packed_5stage_odd[131:137] || rc_addr_even == packed_5stage_odd[131:137]) && packed_5stage_odd[142]) begin
    if(packed_5stage_odd[138:141] > 4'd6) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_even == packed_6stage_odd[131:137] || rb_addr_even == packed_6stage_odd[131:137] || rc_addr_even == packed_6stage_odd[131:137]) && packed_6stage_odd[142]) begin
    if(packed_6stage_odd[138:141] > 4'd7) begin
      stall = 1'b1;
    end
  end

  else if ((ra_addr_odd == ID_reg_dst_even || rb_addr_odd == ID_reg_dst_even || rc_addr_odd == ID_reg_dst_even) && ID_reg_wr_even) begin
    stall = 1'b1;
  end
  else if ((ra_addr_odd == RF_reg_dst_even || rb_addr_odd == RF_reg_dst_even || rc_addr_odd == RF_reg_dst_even) && RF_reg_wr_even) begin
    if(RF_latency_even > 4'd2) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_odd == packed_2stage_even[131:137] || rb_addr_odd == packed_2stage_even[131:137] || rc_addr_odd == packed_2stage_even[131:137]) && packed_2stage_even[142]) begin
    if(packed_2stage_even[138:141] > 4'd3) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_odd == packed_3stage_even[131:137] || rb_addr_odd == packed_3stage_even[131:137] || rc_addr_odd == packed_3stage_even[131:137]) && packed_3stage_even[142]) begin
    if(packed_3stage_even[138:141] > 4'd4) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_odd == packed_4stage_even[131:137] || rb_addr_odd == packed_4stage_even[131:137] || rc_addr_odd == packed_4stage_even[131:137]) && packed_4stage_even[142]) begin
    if(packed_4stage_even[138:141] > 4'd5) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_odd == packed_5stage_even[131:137] || rb_addr_odd == packed_5stage_even[131:137] || rc_addr_odd == packed_5stage_even[131:137]) && packed_5stage_even[142]) begin
    if(packed_5stage_even[138:141] > 4'd6) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_odd == packed_6stage_even[131:137] || rb_addr_odd == packed_6stage_even[131:137] || rc_addr_odd == packed_6stage_even[131:137]) && packed_6stage_even[142]) begin
    if(packed_6stage_even[138:141] > 4'd7) begin
      stall = 1'b1;
    end
  end

  else begin
    stall = 1'b0;
    dependent_stall = 1'b0;
    flush = 1'b0;
  end
end

endmodule