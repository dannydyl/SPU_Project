module Forwarding_Unit(
  // INPUT
  input [0:6] reg_ra_src_even, // even pipe register source
  input [0:6] reg_rb_src_even,
  input [0:6] reg_rc_src_even,

  input [0:6] reg_ra_src_odd, // odd pipe register source
  input [0:6] reg_rb_src_odd,
  input [0:6] reg_rc_src_odd,

  // input from 7 stage pipes
  input [0:142] packed_1stage_even,
  input [0:142] packed_2stage_even,
  input [0:142] packed_3stage_even,
  input [0:142] packed_4stage_even,
  input [0:142] packed_5stage_even,
  input [0:142] packed_6stage_even,
  input [0:142] packed_7stage_even,

  input [0:142] packed_1stage_odd,
  input [0:142] packed_2stage_odd,
  input [0:142] packed_3stage_odd,
  input [0:142] packed_4stage_odd,
  input [0:142] packed_5stage_odd,
  input [0:142] packed_6stage_odd,
  input [0:142] packed_7stage_odd,
// OUTPUT
// even pipe forwarding enable -------------------
  output ra_fw_en_1stage_even,
  output rb_fw_en_1stage_even,
  output rc_fw_en_1stage_even,

  output ra_fw_en_2stage_even,
  output rb_fw_en_2stage_even,
  output rc_fw_en_2stage_even,

  output ra_fw_en_3stage_even,
  output rb_fw_en_3stage_even,
  output rc_fw_en_3stage_even,

  output ra_fw_en_4stage_even,
  output rb_fw_en_4stage_even,
  output rc_fw_en_4stage_even,

  output ra_fw_en_5stage_even,
  output rb_fw_en_5stage_even,
  output rc_fw_en_5stage_even,

  output ra_fw_en_6stage_even,
  output rb_fw_en_6stage_even,
  output rc_fw_en_6stage_even,

  output ra_fw_en_7stage_even,
  output rb_fw_en_7stage_even,
  output rc_fw_en_7stage_even,
// ----------------------------------------------

// odd pipe forwarding enable -------------------
  output ra_fw_en_1stage_odd,
  output rb_fw_en_1stage_odd,
  output rc_fw_en_1stage_odd,

  output ra_fw_en_2stage_odd,
  output rb_fw_en_2stage_odd,
  output rc_fw_en_2stage_odd,

  output ra_fw_en_3stage_odd,
  output rb_fw_en_3stage_odd,
  output rc_fw_en_3stage_odd,

  output ra_fw_en_4stage_odd,
  output rb_fw_en_4stage_odd,
  output rc_fw_en_4stage_odd,

  output ra_fw_en_5stage_odd,
  output rb_fw_en_5stage_odd,
  output rc_fw_en_5stage_odd,

  output ra_fw_en_6stage_odd,
  output rb_fw_en_6stage_odd,
  output rc_fw_en_6stage_odd,

  output ra_fw_en_7stage_odd,
  output rb_fw_en_7stage_odd,
  output rc_fw_en_7stage_odd
  // ----------------------------------------------
);

  // even pipe -------------------
  wire [0:6] reg_dst_1stage_even, // dont need since we can't forward from stage 1
  wire [0:6] reg_dst_2stage_even, // even pipe register destination
  wire [0:6] reg_dst_3stage_even,
  wire [0:6] reg_dst_4stage_even,
  wire [0:6] reg_dst_5stage_even,
  wire [0:6] reg_dst_6stage_even,
  wire [0:6] reg_dst_7stage_even,

  wire reg_wr_1stage_even,
  wire reg_wr_2stage_even,
  wire reg_wr_3stage_even,
  wire reg_wr_4stage_even,
  wire reg_wr_5stage_even,
  wire reg_wr_6stage_even,
  wire reg_wr_7stage_even,

  wire [0:3] latency_1stage_even,
  wire [0:3] latency_2stage_even,
  wire [0:3] latency_3stage_even,
  wire [0:3] latency_4stage_even,
  wire [0:3] latency_5stage_even,
  wire [0:3] latency_6stage_even,
  wire [0:3] latency_7stage_even,

  // unpacking packed data
  assign reg_dst_1stage_even = packed_1stage_even[131:137];
  assign reg_dst_2stage_even = packed_2stage_even[131:137];
  assign reg_dst_3stage_even = packed_3stage_even[131:137];
  assign reg_dst_4stage_even = packed_4stage_even[131:137];
  assign reg_dst_5stage_even = packed_5stage_even[131:137];
  assign reg_dst_6stage_even = packed_6stage_even[131:137];
  assign reg_dst_7stage_even = packed_7stage_even[131:137];

  assign reg_wr_1stage_even = packed_1stage_even[142];
  assign reg_wr_2stage_even = packed_2stage_even[142];
  assign reg_wr_3stage_even = packed_3stage_even[142];
  assign reg_wr_4stage_even = packed_4stage_even[142];
  assign reg_wr_5stage_even = packed_5stage_even[142];
  assign reg_wr_6stage_even = packed_6stage_even[142];
  assign reg_wr_7stage_even = packed_7stage_even[142];

  assign latency_1stage_even = packed_1stage_even[138:141];
  assign latency_2stage_even = packed_2stage_even[138:141];
  assign latency_3stage_even = packed_3stage_even[138:141];
  assign latency_4stage_even = packed_4stage_even[138:141];
  assign latency_5stage_even = packed_5stage_even[138:141];
  assign latency_6stage_even = packed_6stage_even[138:141];
  assign latency_7stage_even = packed_7stage_even[138:141];
// odd pipe -------------------

  wire [0:6] reg_dst_1stage_odd,
  wire [0:6] reg_dst_2stage_odd,
  wire [0:6] reg_dst_3stage_odd,
  wire [0:6] reg_dst_4stage_odd,
  wire [0:6] reg_dst_5stage_odd,
  wire [0:6] reg_dst_6stage_odd,
  wire [0:6] reg_dst_7stage_odd,

  wire reg_wr_1stage_odd,
  wire reg_wr_2stage_odd,
  wire reg_wr_3stage_odd,
  wire reg_wr_4stage_odd,
  wire reg_wr_5stage_odd,
  wire reg_wr_6stage_odd,
  wire reg_wr_7stage_odd,

  wire [0:3] latency_1stage_odd,
  wire [0:3] latency_2stage_odd,
  wire [0:3] latency_3stage_odd,
  wire [0:3] latency_4stage_odd,
  wire [0:3] latency_5stage_odd,
  wire [0:3] latency_6stage_odd,
  wire [0:3] latency_7stage_odd,
  
  // unpacking packed data
  assign reg_dst_1stage_odd = packed_1stage_odd[131:137];
  assign reg_dst_2stage_odd = packed_2stage_odd[131:137];
  assign reg_dst_3stage_odd = packed_3stage_odd[131:137];
  assign reg_dst_4stage_odd = packed_4stage_odd[131:137];
  assign reg_dst_5stage_odd = packed_5stage_odd[131:137];
  assign reg_dst_6stage_odd = packed_6stage_odd[131:137];
  assign reg_dst_7stage_odd = packed_7stage_odd[131:137];

  assign reg_wr_1stage_odd = packed_1stage_odd[142];
  assign reg_wr_2stage_odd = packed_2stage_odd[142];
  assign reg_wr_3stage_odd = packed_3stage_odd[142];
  assign reg_wr_4stage_odd = packed_4stage_odd[142];
  assign reg_wr_5stage_odd = packed_5stage_odd[142];
  assign reg_wr_6stage_odd = packed_6stage_odd[142];
  assign reg_wr_7stage_odd = packed_7stage_odd[142];

  assign latency_1stage_odd = packed_1stage_odd[138:141];
  assign latency_2stage_odd = packed_2stage_odd[138:141];
  assign latency_3stage_odd = packed_3stage_odd[138:141];
  assign latency_4stage_odd = packed_4stage_odd[138:141];
  assign latency_5stage_odd = packed_5stage_odd[138:141];
  assign latency_6stage_odd = packed_6stage_odd[138:141];
  assign latency_7stage_odd = packed_7stage_odd[138:141];

  assign ra_fw_en_1stage_even = (reg_ra_src_even == reg_dst_1stage_even) && reg_wr_1stage_even && (latency_1stage_even <= 1);
  assign rb_fw_en_1stage_even = (reg_rb_src_even == reg_dst_1stage_even) && reg_wr_1stage_even && (latency_1stage_even <= 1); 
  assign rc_fw_en_1stage_even = (reg_rc_src_even == reg_dst_1stage_even) && reg_wr_1stage_even && (latency_1stage_even <= 1);

  assign ra_fw_en_2stage_even = (reg_ra_src_even == reg_dst_2stage_even) && reg_wr_2stage_even && (latency_2stage_even <= 2);
  assign rb_fw_en_2stage_even = (reg_rb_src_even == reg_dst_2stage_even) && reg_wr_2stage_even && (latency_2stage_even <= 2);
  assign rc_fw_en_2stage_even = (reg_rc_src_even == reg_dst_2stage_even) && reg_wr_2stage_even && (latency_2stage_even <= 2);

  assign ra_fw_en_3stage_even = (reg_ra_src_even == reg_dst_3stage_even) && reg_wr_3stage_even && (latency_3stage_even <= 3);
  assign rb_fw_en_3stage_even = (reg_rb_src_even == reg_dst_3stage_even) && reg_wr_3stage_even && (latency_3stage_even <= 3);
  assign rc_fw_en_3stage_even = (reg_rc_src_even == reg_dst_3stage_even) && reg_wr_3stage_even && (latency_3stage_even <= 3);

  assign ra_fw_en_4stage_even = (reg_ra_src_even == reg_dst_4stage_even) && reg_wr_4stage_even && (latency_4stage_even <= 4);
  assign rb_fw_en_4stage_even = (reg_rb_src_even == reg_dst_4stage_even) && reg_wr_4stage_even && (latency_4stage_even <= 4);
  assign rc_fw_en_4stage_even = (reg_rc_src_even == reg_dst_4stage_even) && reg_wr_4stage_even && (latency_4stage_even <= 4);

  assign ra_fw_en_5stage_even = (reg_ra_src_even == reg_dst_5stage_even) && reg_wr_5stage_even && (latency_5stage_even <= 5);
  assign rb_fw_en_5stage_even = (reg_rb_src_even == reg_dst_5stage_even) && reg_wr_5stage_even && (latency_5stage_even <= 5);
  assign rc_fw_en_5stage_even = (reg_rc_src_even == reg_dst_5stage_even) && reg_wr_5stage_even && (latency_5stage_even <= 5);

  assign ra_fw_en_6stage_even = (reg_ra_src_even == reg_dst_6stage_even) && reg_wr_6stage_even && (latency_6stage_even <= 6);
  assign rb_fw_en_6stage_even = (reg_rb_src_even == reg_dst_6stage_even) && reg_wr_6stage_even && (latency_6stage_even <= 6);
  assign rc_fw_en_6stage_even = (reg_rc_src_even == reg_dst_6stage_even) && reg_wr_6stage_even && (latency_6stage_even <= 6);

  assign ra_fw_en_7stage_even = (reg_ra_src_even == reg_dst_7stage_even) && reg_wr_7stage_even && (latency_7stage_even <= 7);
  assign rb_fw_en_7stage_even = (reg_rb_src_even == reg_dst_7stage_even) && reg_wr_7stage_even && (latency_7stage_even <= 7);
  assign rc_fw_en_7stage_even = (reg_rc_src_even == reg_dst_7stage_even) && reg_wr_7stage_even && (latency_7stage_even <= 7);

  assign ra_fw_en_1stage_odd = (reg_ra_src_odd == reg_dst_1stage_odd) && reg_wr_1stage_odd && (latency_1stage_odd <= 1);
  assign rb_fw_en_1stage_odd = (reg_rb_src_odd == reg_dst_1stage_odd) && reg_wr_1stage_odd && (latency_1stage_odd <= 1);
  assign rc_fw_en_1stage_odd = (reg_rc_src_odd == reg_dst_1stage_odd) && reg_wr_1stage_odd && (latency_1stage_odd <= 1);

  assign ra_fw_en_2stage_odd = (reg_ra_src_odd == reg_dst_2stage_odd) && reg_wr_2stage_odd && (latency_2stage_odd <= 2);
  assign rb_fw_en_2stage_odd = (reg_rb_src_odd == reg_dst_2stage_odd) && reg_wr_2stage_odd && (latency_2stage_odd <= 2);
  assign rc_fw_en_2stage_odd = (reg_rc_src_odd == reg_dst_2stage_odd) && reg_wr_2stage_odd && (latency_2stage_odd <= 2);

  assign ra_fw_en_3stage_odd = (reg_ra_src_odd == reg_dst_3stage_odd) && reg_wr_3stage_odd && (latency_3stage_odd <= 3);
  assign rb_fw_en_3stage_odd = (reg_rb_src_odd == reg_dst_3stage_odd) && reg_wr_3stage_odd && (latency_3stage_odd <= 3);
  assign rc_fw_en_3stage_odd = (reg_rc_src_odd == reg_dst_3stage_odd) && reg_wr_3stage_odd && (latency_3stage_odd <= 3);

  assign ra_fw_en_4stage_odd = (reg_ra_src_odd == reg_dst_4stage_odd) && reg_wr_4stage_odd && (latency_4stage_odd <= 4);
  assign rb_fw_en_4stage_odd = (reg_rb_src_odd == reg_dst_4stage_odd) && reg_wr_4stage_odd && (latency_4stage_odd <= 4);
  assign rc_fw_en_4stage_odd = (reg_rc_src_odd == reg_dst_4stage_odd) && reg_wr_4stage_odd && (latency_4stage_odd <= 4);

  assign ra_fw_en_5stage_odd = (reg_ra_src_odd == reg_dst_5stage_odd) && reg_wr_5stage_odd && (latency_5stage_odd <= 5);
  assign rb_fw_en_5stage_odd = (reg_rb_src_odd == reg_dst_5stage_odd) && reg_wr_5stage_odd && (latency_5stage_odd <= 5);
  assign rc_fw_en_5stage_odd = (reg_rc_src_odd == reg_dst_5stage_odd) && reg_wr_5stage_odd && (latency_5stage_odd <= 5);

  assign ra_fw_en_6stage_odd = (reg_ra_src_odd == reg_dst_6stage_odd) && reg_wr_6stage_odd && (latency_6stage_odd <= 6);
  assign rb_fw_en_6stage_odd = (reg_rb_src_odd == reg_dst_6stage_odd) && reg_wr_6stage_odd && (latency_6stage_odd <= 6);
  assign rc_fw_en_6stage_odd = (reg_rc_src_odd == reg_dst_6stage_odd) && reg_wr_6stage_odd && (latency_6stage_odd <= 6);

  assign ra_fw_en_7stage_odd = (reg_ra_src_odd == reg_dst_7stage_odd) && reg_wr_7stage_odd && (latency_7stage_odd <= 7);
  assign rb_fw_en_7stage_odd = (reg_rb_src_odd == reg_dst_7stage_odd) && reg_wr_7stage_odd && (latency_7stage_odd <= 7);
  assign rc_fw_en_7stage_odd = (reg_rc_src_odd == reg_dst_7stage_odd) && reg_wr_7stage_odd && (latency_7stage_odd <= 7);
  
  endmodule