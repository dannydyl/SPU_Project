module Forwarding_Unit(
  input [0:6] reg_ra_src_even,
  input [0:6] reg_rb_src_even,
  input [0:6] reg_rc_src_even,

  input [0:6] reg_ra_src_odd,
  input [0:6] reg_rb_src_odd,
  input [0:6] reg_rc_src_odd,

  input [0:6] reg_dst_1stage_even, // dont need since we can forward from stage 1
  input [0:6] reg_dst_2stage_even,
  input [0:6] reg_dst_3stage_even,
  input [0:6] reg_dst_4stage_even,
  input [0:6] reg_dst_5stage_even,
  input [0:6] reg_dst_6stage_even,
  input [0:6] reg_dst_7stage_even,

  input reg_wr_1stage_even,
  input reg_wr_2stage_even,
  input reg_wr_3stage_even,
  input reg_wr_4stage_even,
  input reg_wr_5stage_even,
  input reg_wr_6stage_even,
  input reg_wr_7stage_even,

  input [0:4] latency_1stage_even,
  input [0:4] latency_2stage_even,
  input [0:4] latency_3stage_even,
  input [0:4] latency_4stage_even,
  input [0:4] latency_5stage_even,
  input [0:4] latency_6stage_even,
  input [0:4] latency_7stage_even,


  input [0:6] reg_dst_1stage_odd,
  input [0:6] reg_dst_2stage_odd,
  input [0:6] reg_dst_3stage_odd,
  input [0:6] reg_dst_4stage_odd,
  input [0:6] reg_dst_5stage_odd,
  input [0:6] reg_dst_6stage_odd,
  input [0:6] reg_dst_7stage_odd,

  input reg_wr_1stage_odd,
  input reg_wr_2stage_odd,
  input reg_wr_3stage_odd,
  input reg_wr_4stage_odd,
  input reg_wr_5stage_odd,
  input reg_wr_6stage_odd,
  input reg_wr_7stage_odd,

  input [0:4] latency_1stage_odd,
  input [0:4] latency_2stage_odd,
  input [0:4] latency_3stage_odd,
  input [0:4] latency_4stage_odd,
  input [0:4] latency_5stage_odd,
  input [0:4] latency_6stage_odd,
  input [0:4] latency_7stage_odd,

  output ra_fw_en_even,
  output rb_fw_en_even,
  output rc_fw_en_even,

  output ra_fw_en_odd,
  output rb_fw_en_odd,
  output rc_fw_en_odd
);

endmodule