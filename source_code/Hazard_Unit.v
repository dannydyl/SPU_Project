module Hazard_Unit(
  input instr1_type,
  input instr2_type,
  input [0:6] ra_addr_even,
  input [0:6] rb_addr_even,
  input [0:6] rc_addr_even,
  input [0:6] ra_addr_odd,
  input [0:6] rb_addr_odd,
  input [0:6] rc_addr_odd,

  input [0:142] packed_RFFUstage_even,
  input [0:142] packed_1stage_even, // replace this signal coming from ID
  input [0:142] packed_2stage_even,
  input [0:142] packed_3stage_even,
  input [0:142] packed_4stage_even,
  input [0:142] packed_5stage_even,
  input [0:142] packed_6stage_even,

  input [0:142] packed_RFFUstage_odd,
  input [0:142] packed_1stage_odd,
  input [0:142] packed_2stage_odd,
  input [0:142] packed_3stage_odd,
  input [0:142] packed_4stage_odd,
  input [0:142] packed_5stage_odd,
  input [0:142] packed_6stage_odd,

  output reg stall,
  output reg flush
);


always @(*) begin

  if (instr1_type == instr2_type) begin
    stall = 1'b1;
  end

  else if (reg_dst_even == reg_dst_odd) begin
    stall = 1'b1;
  end 

  else if ((ra_addr_even == packed_RFFUstage_even[131:137] || rb_addr_even == packed_RFFUstage_even[131:137] || rc_addr_even == packed_RFFUstage_even[131:137]) && packed_RFFUstage_even[142]) begin
    if(packed_RFFUstage_even[138:141] > 4'd1) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_even == packed_1stage_even[131:137] || rb_addr_even == packed_1stage_even[131:137] || rc_addr_even == packed_1stage_even[131:137]) && packed_1stage_even[142]) begin
    if(packed_1stage_even[138:141] > 4'd2) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_even == packed_2stage_even[131:137] || rb_addr_even == packed_2stage_even[131:137] || rc_addr_even == packed_2stage_even[131:137]) && packed_1stage_even[142]) begin
    if(packed_2stage_even[138:141] > 4'd3) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_even == packed_3stage_even[131:137] || rb_addr_even == packed_3stage_even[131:137] || rc_addr_even == packed_3stage_even[131:137]) && packed_1stage_even[142]) begin
    if(packed_3stage_even[138:141] > 4'd4) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_even == packed_4stage_even[131:137] || rb_addr_even == packed_4stage_even[131:137] || rc_addr_even == packed_4stage_even[131:137]) && packed_1stage_even[142]) begin
    if(packed_4stage_even[138:141] > 4'd5) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_even == packed_5stage_even[131:137] || rb_addr_even == packed_5stage_even[131:137] || rc_addr_even == packed_5stage_even[131:137]) && packed_1stage_even[142]) begin
    if(packed_5stage_even[138:141] > 4'd6) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_even == packed_6stage_even[131:137] || rb_addr_even == packed_6stage_even[131:137] || rc_addr_even == packed_6stage_even[131:137]) && packed_1stage_even[142]) begin
    if(packed_6stage_even[138:141] > 4'd7) begin
      stall = 1'b1;
    end
  end

  else if ((ra_addr_odd == packed_RFFUstage_odd[131:137] || rb_addr_odd == packed_RFFUstage_odd[131:137] || rc_addr_odd == packed_RFFUstage_odd[131:137]) && packed_RFFUstage_odd[142]) begin
    if(packed_RFFUstage_odd[138:141] > 4'd1) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_odd == packed_1stage_odd[131:137] || rb_addr_odd == packed_1stage_odd[131:137] || rc_addr_odd == packed_1stage_odd[131:137]) && packed_1stage_odd[142]) begin
    if(packed_1stage_odd[138:141] > 4'd2) begin
      stall = 1'b1;
    end
  end
  else if ((ra_addr_odd == packed_2stage_odd[131:137] || rb_addr_odd == packed_2stage_odd[131:137] || rc_addr_odd == packed_2stage_odd[131:137]) && packed_2stage_even[142]) begin
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
  else if ((ra_addr_even == packed_6stage_even[131:137] || rb_addr_even == packed_6stage_even[131:137] || rc_addr_even == packed_6stage_even[131:137]) && packed_6stage_even[142]) begin
    if(packed_6stage_even[138:141] > 4'd7) begin
      stall = 1'b1;
    end
  end

  else begin
    stall = 1'b0;
  end
  
end

endmodule