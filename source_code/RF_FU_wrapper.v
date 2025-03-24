module RF_FU_wrapper(
  input clk,
  input rst,

  // inputs for instruction
  input [0:31] full_instr_even,
  input [0:6] instr_id_even,
  input [0:6] reg_dst_even,
  input [0:2] unit_id_even,
  input [0:3] latency_even,
  input reg_wr_even,
  input [0:6] imme7_even,
  input [0:9] imme10_even,
  input [0:15] imme16_even,
  input [0:17] imme18_even,

  input [0:31] full_instr_odd,
  input [0:6] instr_id_odd,
  input [0:6] reg_dst_odd,
  input [0:2] unit_id_odd,
  input [0:3] latency_odd,
  input reg_wr_odd,
  input [0:6] imme7_odd,
  input [0:9] imme10_odd,
  input [0:15] imme16_odd,
  input [0:17] imme18_odd,

  // inputs for register file
  input [0:6] ra_addr_even,   // these three addresses are also used for forwarding unit
  input [0:6] rb_addr_even,
  input [0:6] rc_addr_even,

  input [0:6] ra_addr_odd,
  input [0:6] rb_addr_odd,
  input [0:6] rc_addr_odd,

  input reg_write_en_1,
  input reg_write_en_2,

  input [0:6] reg_write_addr_1,
  input [0:6] reg_write_addr_2,
  input [0:127] reg_write_data_1,
  input [0:127] reg_write_data_2,

  // inputs for forwarding unit
  input [0:142] packed_2stage_even,
  input [0:142] packed_3stage_even,
  input [0:142] packed_4stage_even,
  input [0:142] packed_5stage_even,
  input [0:142] packed_6stage_even,
  input [0:142] packed_7stage_even,

  input [0:142] packed_2stage_odd,
  input [0:142] packed_3stage_odd,
  input [0:142] packed_4stage_odd,
  input [0:142] packed_5stage_odd,
  input [0:142] packed_6stage_odd,
  input [0:142] packed_7stage_odd,

  // OUTPUT 
  output reg [0:31] out_full_instr_even, // bypassing signals from ID
  output reg [0:6] out_instr_id_even,
  output reg [0:6] out_reg_dst_even,
  output reg [0:2] out_unit_id_even,
  output reg [0:3] out_latency_even,
  output reg out_reg_wr_even,
  output reg [0:6] out_imme7_even,
  output reg [0:9] out_imme10_even,
  output reg [0:15] out_imme16_even,
  output reg [0:17] out_imme18_even,

  output reg [0:31] out_full_instr_odd,
  output reg [0:6] out_instr_id_odd,
  output reg [0:6] out_reg_dst_odd,
  output reg [0:2] out_unit_id_odd,
  output reg [0:3] out_latency_odd,
  output reg out_reg_wr_odd,
  output reg [0:6] out_imme7_odd,
  output reg [0:9] out_imme10_odd,
  output reg [0:15] out_imme16_odd,
  output reg [0:17] out_imme18_odd,

  output reg [0:127] ra_data_even,
  output reg [0:127] rb_data_even,
  output reg [0:127] rc_data_even,

  output reg [0:127] ra_data_odd,
  output reg [0:127] rb_data_odd,
  output reg [0:127] rc_data_odd,

  // Preload RF. Verification purpose only
  input preload_en,
  input [0:127] preload_addr,
  input [0:127] preload_values

);
wire [0:127] regfile_out_data_1;
wire [0:127] regfile_out_data_2;
wire [0:127] regfile_out_data_3;
wire [0:127] regfile_out_data_4;
wire [0:127] regfile_out_data_5;
wire [0:127] regfile_out_data_6;
// need fw en for odd pipe
wire ra_fw_en_2stage_even;
wire rb_fw_en_2stage_even;
wire rc_fw_en_2stage_even;
wire ra_fw_en_3stage_even;
wire rb_fw_en_3stage_even;
wire rc_fw_en_3stage_even;
wire ra_fw_en_4stage_even;
wire rb_fw_en_4stage_even;
wire rc_fw_en_4stage_even;
wire ra_fw_en_5stage_even;
wire rb_fw_en_5stage_even;
wire rc_fw_en_5stage_even;
wire ra_fw_en_6stage_even;
wire rb_fw_en_6stage_even;
wire rc_fw_en_6stage_even;
wire ra_fw_en_7stage_even;
wire rb_fw_en_7stage_even;
wire rc_fw_en_7stage_even;

wire ra_fw_en_2stage_odd;
wire rb_fw_en_2stage_odd;
wire rc_fw_en_2stage_odd;
wire ra_fw_en_3stage_odd;
wire rb_fw_en_3stage_odd;
wire rc_fw_en_3stage_odd;
wire ra_fw_en_4stage_odd;
wire rb_fw_en_4stage_odd;
wire rc_fw_en_4stage_odd;
wire ra_fw_en_5stage_odd;
wire rb_fw_en_5stage_odd;
wire rc_fw_en_5stage_odd;
wire ra_fw_en_6stage_odd;
wire rb_fw_en_6stage_odd;
wire rc_fw_en_6stage_odd;
wire ra_fw_en_7stage_odd;
wire rb_fw_en_7stage_odd;
wire rc_fw_en_7stage_odd;

wire ra_fw_en_2stage_from_odd_to_even;
wire rb_fw_en_2stage_from_odd_to_even;
wire rc_fw_en_2stage_from_odd_to_even;
wire ra_fw_en_3stage_from_odd_to_even;
wire rb_fw_en_3stage_from_odd_to_even;
wire rc_fw_en_3stage_from_odd_to_even;
wire ra_fw_en_4stage_from_odd_to_even;
wire rb_fw_en_4stage_from_odd_to_even;
wire rc_fw_en_4stage_from_odd_to_even;
wire ra_fw_en_5stage_from_odd_to_even;
wire rb_fw_en_5stage_from_odd_to_even;
wire rc_fw_en_5stage_from_odd_to_even;
wire ra_fw_en_6stage_from_odd_to_even;
wire rb_fw_en_6stage_from_odd_to_even;
wire rc_fw_en_6stage_from_odd_to_even;
wire ra_fw_en_7stage_from_odd_to_even;
wire rb_fw_en_7stage_from_odd_to_even;
wire rc_fw_en_7stage_from_odd_to_even;

wire ra_fw_en_2stage_from_even_to_odd;
wire rb_fw_en_2stage_from_even_to_odd;
wire rc_fw_en_2stage_from_even_to_odd;
wire ra_fw_en_3stage_from_even_to_odd;
wire rb_fw_en_3stage_from_even_to_odd;
wire rc_fw_en_3stage_from_even_to_odd;
wire ra_fw_en_4stage_from_even_to_odd;
wire rb_fw_en_4stage_from_even_to_odd;
wire rc_fw_en_4stage_from_even_to_odd;
wire ra_fw_en_5stage_from_even_to_odd;
wire rb_fw_en_5stage_from_even_to_odd;
wire rc_fw_en_5stage_from_even_to_odd;
wire ra_fw_en_6stage_from_even_to_odd;
wire rb_fw_en_6stage_from_even_to_odd;
wire rc_fw_en_6stage_from_even_to_odd;
wire ra_fw_en_7stage_from_even_to_odd;
wire rb_fw_en_7stage_from_even_to_odd;
wire rc_fw_en_7stage_from_even_to_odd;

Reg_file RF_inst(
  .clk(clk),
  .rst(rst),
  // write operations
  .reg_write_en_1(reg_write_en_1),
  .reg_write_en_2(reg_write_en_2),
  .reg_write_addr_1(reg_write_addr_1),
  .reg_write_addr_2(reg_write_addr_2),
  .reg_write_data_1(reg_write_data_1),
  .reg_write_data_2(reg_write_data_2),

  // read operations
  .reg_read_addr_1(ra_addr_even),
  .reg_read_addr_2(rb_addr_even),
  .reg_read_addr_3(rc_addr_even),
  .reg_read_addr_4(ra_addr_odd),
  .reg_read_addr_5(rb_addr_odd),
  .reg_read_addr_6(rc_addr_odd),

  .reg_read_data_1(regfile_out_data_1),
  .reg_read_data_2(regfile_out_data_2),
  .reg_read_data_3(regfile_out_data_3),
  .reg_read_data_4(regfile_out_data_4),
  .reg_read_data_5(regfile_out_data_5),
  .reg_read_data_6(regfile_out_data_6),

  .preload_en(preload_en),
  .preload_addr(preload_addr),
  .preload_values(preload_values)
);

Forwarding_Unit FU_inst(
  .reg_ra_src_even(ra_addr_even),
  .reg_rb_src_even(rb_addr_even),
  .reg_rc_src_even(rc_addr_even),

  .reg_ra_src_odd(ra_addr_odd),
  .reg_rb_src_odd(rb_addr_odd),
  .reg_rc_src_odd(rc_addr_odd),

  .packed_2stage_even(packed_2stage_even),
  .packed_3stage_even(packed_3stage_even),
  .packed_4stage_even(packed_4stage_even),
  .packed_5stage_even(packed_5stage_even),
  .packed_6stage_even(packed_6stage_even),
  .packed_7stage_even(packed_7stage_even),

  .packed_2stage_odd(packed_2stage_odd),
  .packed_3stage_odd(packed_3stage_odd),
  .packed_4stage_odd(packed_4stage_odd),
  .packed_5stage_odd(packed_5stage_odd),
  .packed_6stage_odd(packed_6stage_odd),
  .packed_7stage_odd(packed_7stage_odd),

  // OUTPUT
  .ra_fw_en_2stage_even(ra_fw_en_2stage_even),
  .rb_fw_en_2stage_even(rb_fw_en_2stage_even),
  .rc_fw_en_2stage_even(rc_fw_en_2stage_even),
  .ra_fw_en_3stage_even(ra_fw_en_3stage_even),
  .rb_fw_en_3stage_even(rb_fw_en_3stage_even),
  .rc_fw_en_3stage_even(rc_fw_en_3stage_even),
  .ra_fw_en_4stage_even(ra_fw_en_4stage_even),
  .rb_fw_en_4stage_even(rb_fw_en_4stage_even),
  .rc_fw_en_4stage_even(rc_fw_en_4stage_even),
  .ra_fw_en_5stage_even(ra_fw_en_5stage_even),
  .rb_fw_en_5stage_even(rb_fw_en_5stage_even),
  .rc_fw_en_5stage_even(rc_fw_en_5stage_even),
  .ra_fw_en_6stage_even(ra_fw_en_6stage_even),
  .rb_fw_en_6stage_even(rb_fw_en_6stage_even),
  .rc_fw_en_6stage_even(rc_fw_en_6stage_even),
  .ra_fw_en_7stage_even(ra_fw_en_7stage_even),
  .rb_fw_en_7stage_even(rb_fw_en_7stage_even),
  .rc_fw_en_7stage_even(rc_fw_en_7stage_even),

  .ra_fw_en_2stage_odd(ra_fw_en_2stage_odd),
  .rb_fw_en_2stage_odd(rb_fw_en_2stage_odd),
  .rc_fw_en_2stage_odd(rc_fw_en_2stage_odd),
  .ra_fw_en_3stage_odd(ra_fw_en_3stage_odd),
  .rb_fw_en_3stage_odd(rb_fw_en_3stage_odd),
  .rc_fw_en_3stage_odd(rc_fw_en_3stage_odd),
  .ra_fw_en_4stage_odd(ra_fw_en_4stage_odd),
  .rb_fw_en_4stage_odd(rb_fw_en_4stage_odd),
  .rc_fw_en_4stage_odd(rc_fw_en_4stage_odd),
  .ra_fw_en_5stage_odd(ra_fw_en_5stage_odd),
  .rb_fw_en_5stage_odd(rb_fw_en_5stage_odd),
  .rc_fw_en_5stage_odd(rc_fw_en_5stage_odd),
  .ra_fw_en_6stage_odd(ra_fw_en_6stage_odd),
  .rb_fw_en_6stage_odd(rb_fw_en_6stage_odd),
  .rc_fw_en_6stage_odd(rc_fw_en_6stage_odd),
  .ra_fw_en_7stage_odd(ra_fw_en_7stage_odd),
  .rb_fw_en_7stage_odd(rb_fw_en_7stage_odd),
  .rc_fw_en_7stage_odd(rc_fw_en_7stage_odd),

  .ra_fw_en_2stage_from_odd_to_even(ra_fw_en_2stage_from_odd_to_even),
  .rb_fw_en_2stage_from_odd_to_even(rb_fw_en_2stage_from_odd_to_even),
  .rc_fw_en_2stage_from_odd_to_even(rc_fw_en_2stage_from_odd_to_even),
  .ra_fw_en_3stage_from_odd_to_even(ra_fw_en_3stage_from_odd_to_even),
  .rb_fw_en_3stage_from_odd_to_even(rb_fw_en_3stage_from_odd_to_even),
  .rc_fw_en_3stage_from_odd_to_even(rc_fw_en_3stage_from_odd_to_even),
  .ra_fw_en_4stage_from_odd_to_even(ra_fw_en_4stage_from_odd_to_even),
  .rb_fw_en_4stage_from_odd_to_even(rb_fw_en_4stage_from_odd_to_even),
  .rc_fw_en_4stage_from_odd_to_even(rc_fw_en_4stage_from_odd_to_even),
  .ra_fw_en_5stage_from_odd_to_even(ra_fw_en_5stage_from_odd_to_even),
  .rb_fw_en_5stage_from_odd_to_even(rb_fw_en_5stage_from_odd_to_even),
  .rc_fw_en_5stage_from_odd_to_even(rc_fw_en_5stage_from_odd_to_even),
  .ra_fw_en_6stage_from_odd_to_even(ra_fw_en_6stage_from_odd_to_even),
  .rb_fw_en_6stage_from_odd_to_even(rb_fw_en_6stage_from_odd_to_even),
  .rc_fw_en_6stage_from_odd_to_even(rc_fw_en_6stage_from_odd_to_even),
  .ra_fw_en_7stage_from_odd_to_even(ra_fw_en_7stage_from_odd_to_even),
  .rb_fw_en_7stage_from_odd_to_even(rb_fw_en_7stage_from_odd_to_even),
  .rc_fw_en_7stage_from_odd_to_even(rc_fw_en_7stage_from_odd_to_even),

  .ra_fw_en_2stage_from_even_to_odd(ra_fw_en_2stage_from_even_to_odd),
  .rb_fw_en_2stage_from_even_to_odd(rb_fw_en_2stage_from_even_to_odd),
  .rc_fw_en_2stage_from_even_to_odd(rc_fw_en_2stage_from_even_to_odd),
  .ra_fw_en_3stage_from_even_to_odd(ra_fw_en_3stage_from_even_to_odd),
  .rb_fw_en_3stage_from_even_to_odd(rb_fw_en_3stage_from_even_to_odd),
  .rc_fw_en_3stage_from_even_to_odd(rc_fw_en_3stage_from_even_to_odd),
  .ra_fw_en_4stage_from_even_to_odd(ra_fw_en_4stage_from_even_to_odd),
  .rb_fw_en_4stage_from_even_to_odd(rb_fw_en_4stage_from_even_to_odd),
  .rc_fw_en_4stage_from_even_to_odd(rc_fw_en_4stage_from_even_to_odd),
  .ra_fw_en_5stage_from_even_to_odd(ra_fw_en_5stage_from_even_to_odd),
  .rb_fw_en_5stage_from_even_to_odd(rb_fw_en_5stage_from_even_to_odd),
  .rc_fw_en_5stage_from_even_to_odd(rc_fw_en_5stage_from_even_to_odd),
  .ra_fw_en_6stage_from_even_to_odd(ra_fw_en_6stage_from_even_to_odd),
  .rb_fw_en_6stage_from_even_to_odd(rb_fw_en_6stage_from_even_to_odd),
  .rc_fw_en_6stage_from_even_to_odd(rc_fw_en_6stage_from_even_to_odd),
  .ra_fw_en_7stage_from_even_to_odd(ra_fw_en_7stage_from_even_to_odd),
  .rb_fw_en_7stage_from_even_to_odd(rb_fw_en_7stage_from_even_to_odd),
  .rc_fw_en_7stage_from_even_to_odd(rc_fw_en_7stage_from_even_to_odd)
);

// For instruction info bypassing
wire [0:31] temp_full_instr_even;
wire [0:6] temp_instr_id_even;
wire [0:6] temp_reg_dst_even;
wire [0:2] temp_unit_id_even;
wire [0:3] temp_latency_even;
wire temp_reg_wr_even;
wire [0:6] temp_imme7_even;
wire [0:9] temp_imme10_even;
wire [0:15] temp_imme16_even;
wire [0:17] temp_imme18_even;

wire [0:31] temp_full_instr_odd;
wire [0:6] temp_instr_id_odd;
wire [0:6] temp_reg_dst_odd;
wire [0:2] temp_unit_id_odd;
wire [0:3] temp_latency_odd;
wire temp_reg_wr_odd;
wire [0:6] temp_imme7_odd;
wire [0:9] temp_imme10_odd;
wire [0:15] temp_imme16_odd;
wire [0:17] temp_imme18_odd;

assign temp_full_instr_even = full_instr_even;
assign temp_instr_id_even = instr_id_even;
assign temp_reg_dst_even = reg_dst_even;
assign temp_unit_id_even = unit_id_even;
assign temp_latency_even = latency_even;
assign temp_reg_wr_even = reg_wr_even;
assign temp_imme7_even = imme7_even;
assign temp_imme10_even = imme10_even;
assign temp_imme16_even = imme16_even;
assign temp_imme18_even = imme18_even;

assign temp_full_instr_odd = full_instr_odd;
assign temp_instr_id_odd = instr_id_odd;
assign temp_reg_dst_odd = reg_dst_odd;
assign temp_unit_id_odd = unit_id_odd;
assign temp_latency_odd = latency_odd;
assign temp_reg_wr_odd = reg_wr_odd;
assign temp_imme7_odd = imme7_odd;
assign temp_imme10_odd = imme10_odd;
assign temp_imme16_odd = imme16_odd;
assign temp_imme18_odd = imme18_odd;

// for forwarding reg dst result extracted from packed value
wire [0:127] reg_dst_result_2stage_even;
wire [0:127] reg_dst_result_3stage_even;
wire [0:127] reg_dst_result_4stage_even;
wire [0:127] reg_dst_result_5stage_even;
wire [0:127] reg_dst_result_6stage_even;
wire [0:127] reg_dst_result_7stage_even;

wire [0:127] reg_dst_result_2stage_odd;
wire [0:127] reg_dst_result_3stage_odd;
wire [0:127] reg_dst_result_4stage_odd;
wire [0:127] reg_dst_result_5stage_odd;
wire [0:127] reg_dst_result_6stage_odd;
wire [0:127] reg_dst_result_7stage_odd;

assign reg_dst_result_2stage_even = packed_2stage_even[3:130];
assign reg_dst_result_3stage_even = packed_3stage_even[3:130];
assign reg_dst_result_4stage_even = packed_4stage_even[3:130];
assign reg_dst_result_5stage_even = packed_5stage_even[3:130];
assign reg_dst_result_6stage_even = packed_6stage_even[3:130];
assign reg_dst_result_7stage_even = packed_7stage_even[3:130];

assign reg_dst_result_2stage_odd = packed_2stage_odd[3:130];
assign reg_dst_result_3stage_odd = packed_3stage_odd[3:130];
assign reg_dst_result_4stage_odd = packed_4stage_odd[3:130];
assign reg_dst_result_5stage_odd = packed_5stage_odd[3:130];
assign reg_dst_result_6stage_odd = packed_6stage_odd[3:130];
assign reg_dst_result_7stage_odd = packed_7stage_odd[3:130];

always @(posedge clk or posedge rst) begin
  if(rst) begin
    out_full_instr_even <= 32'b0;
    out_instr_id_even <= 7'b0;
    out_reg_dst_even <= 7'b0;
    out_unit_id_even <= 3'b0;
    out_latency_even <= 4'b0;
    out_reg_wr_even <= 1'b0;
    out_imme7_even <= 7'b0;
    out_imme10_even <= 10'b0;
    out_imme16_even <= 16'b0;
    out_imme18_even <= 18'b0;

    out_full_instr_odd <= 32'b0;
    out_instr_id_odd <= 7'b0;
    out_reg_dst_odd <= 7'b0;
    out_unit_id_odd <= 3'b0;
    out_latency_odd <= 4'b0;
    out_reg_wr_odd <= 1'b0;
    out_imme7_odd <= 7'b0;
    out_imme10_odd <= 10'b0;
    out_imme16_odd <= 16'b0;
    out_imme18_odd <= 18'b0;
    
    ra_data_even <= 128'b0;
    rb_data_even <= 128'b0;
    rc_data_even <= 128'b0;

    ra_data_odd <= 128'b0;
    rb_data_odd <= 128'b0;
    rc_data_odd <= 128'b0;
  end
  else begin
    out_full_instr_even <= temp_full_instr_even;
    out_instr_id_even <= temp_instr_id_even;
    out_reg_dst_even <= temp_reg_dst_even;
    out_unit_id_even <= temp_unit_id_even;
    out_latency_even <= temp_latency_even;
    out_reg_wr_even <= temp_reg_wr_even;
    out_imme7_even <= temp_imme7_even;
    out_imme10_even <= temp_imme10_even;
    out_imme16_even <= temp_imme16_even;
    out_imme18_even <= temp_imme18_even;

    out_full_instr_odd <= temp_full_instr_odd;
    out_instr_id_odd <= temp_instr_id_odd;
    out_reg_dst_odd <= temp_reg_dst_odd;
    out_unit_id_odd <= temp_unit_id_odd;
    out_latency_odd <= temp_latency_odd;
    out_reg_wr_odd <= temp_reg_wr_odd;
    out_imme7_odd <= temp_imme7_odd;
    out_imme10_odd <= temp_imme10_odd;
    out_imme16_odd <= temp_imme16_odd;
    out_imme18_odd <= temp_imme18_odd;

    // when result has to be forwarded to ra (even), recent stages has priority for forwarding ALSO same pipe has priority
    ra_data_even <=             (ra_fw_en_2stage_even) ? reg_dst_result_2stage_even :
                    (ra_fw_en_2stage_from_odd_to_even) ? reg_dst_result_2stage_odd :
                                (ra_fw_en_3stage_even) ? reg_dst_result_3stage_even :
                    (ra_fw_en_3stage_from_odd_to_even) ? reg_dst_result_3stage_odd :
                                (ra_fw_en_4stage_even) ? reg_dst_result_4stage_even :
                    (ra_fw_en_4stage_from_odd_to_even) ? reg_dst_result_4stage_odd :
                                (ra_fw_en_5stage_even) ? reg_dst_result_5stage_even :
                    (ra_fw_en_5stage_from_odd_to_even) ? reg_dst_result_5stage_odd :
                                (ra_fw_en_6stage_even) ? reg_dst_result_6stage_even :
                    (ra_fw_en_6stage_from_odd_to_even) ? reg_dst_result_6stage_odd :
                                (ra_fw_en_7stage_even) ? reg_dst_result_7stage_even :
                    (ra_fw_en_7stage_from_odd_to_even) ? reg_dst_result_7stage_odd :
                                                         regfile_out_data_1;

    rb_data_even <=             (rb_fw_en_2stage_even) ? reg_dst_result_2stage_even :
                    (rb_fw_en_2stage_from_odd_to_even) ? reg_dst_result_2stage_odd :
                                (rb_fw_en_3stage_even) ? reg_dst_result_3stage_even :
                    (rb_fw_en_3stage_from_odd_to_even) ? reg_dst_result_3stage_odd :
                                (rb_fw_en_4stage_even) ? reg_dst_result_4stage_even :
                    (rb_fw_en_4stage_from_odd_to_even) ? reg_dst_result_4stage_odd :
                                (rb_fw_en_5stage_even) ? reg_dst_result_5stage_even :
                    (rb_fw_en_5stage_from_odd_to_even) ? reg_dst_result_5stage_odd :
                                (rb_fw_en_6stage_even) ? reg_dst_result_6stage_even :
                    (rb_fw_en_6stage_from_odd_to_even) ? reg_dst_result_6stage_odd :
                                (rb_fw_en_7stage_even) ? reg_dst_result_7stage_even :
                    (rb_fw_en_7stage_from_odd_to_even) ? reg_dst_result_7stage_odd :
                                                         regfile_out_data_2;

    rc_data_even <=             (rc_fw_en_2stage_even) ? reg_dst_result_2stage_even :
                    (rc_fw_en_2stage_from_odd_to_even) ? reg_dst_result_2stage_odd :
                                (rc_fw_en_3stage_even) ? reg_dst_result_3stage_even :
                    (rc_fw_en_3stage_from_odd_to_even) ? reg_dst_result_3stage_odd :
                                (rc_fw_en_4stage_even) ? reg_dst_result_4stage_even :
                    (rc_fw_en_4stage_from_odd_to_even) ? reg_dst_result_4stage_odd :
                                (rc_fw_en_5stage_even) ? reg_dst_result_5stage_even :
                    (rc_fw_en_5stage_from_odd_to_even) ? reg_dst_result_5stage_odd :
                                (rc_fw_en_6stage_even) ? reg_dst_result_6stage_even :
                    (rc_fw_en_6stage_from_odd_to_even) ? reg_dst_result_6stage_odd :
                                (rc_fw_en_7stage_even) ? reg_dst_result_7stage_even :
                    (rc_fw_en_7stage_from_odd_to_even) ? reg_dst_result_7stage_odd :
                                                         regfile_out_data_3;
                    
    ra_data_odd <=               (ra_fw_en_2stage_odd) ? reg_dst_result_2stage_odd :
                    (ra_fw_en_2stage_from_even_to_odd) ? reg_dst_result_2stage_even :
                                 (ra_fw_en_3stage_odd) ? reg_dst_result_3stage_odd :
                    (ra_fw_en_3stage_from_even_to_odd) ? reg_dst_result_3stage_even :
                                 (ra_fw_en_4stage_odd) ? reg_dst_result_4stage_odd :
                    (ra_fw_en_4stage_from_even_to_odd) ? reg_dst_result_4stage_even :
                                 (ra_fw_en_5stage_odd) ? reg_dst_result_5stage_odd :
                    (ra_fw_en_5stage_from_even_to_odd) ? reg_dst_result_5stage_even :
                                 (ra_fw_en_6stage_odd) ? reg_dst_result_6stage_odd :
                    (ra_fw_en_6stage_from_even_to_odd) ? reg_dst_result_6stage_even :
                                 (ra_fw_en_7stage_odd) ? reg_dst_result_7stage_odd :
                    (ra_fw_en_7stage_from_even_to_odd) ? reg_dst_result_7stage_even :
                                                         regfile_out_data_4;
                    
    rb_data_odd <=               (rb_fw_en_2stage_odd) ? reg_dst_result_2stage_odd :
                    (rb_fw_en_2stage_from_even_to_odd) ? reg_dst_result_2stage_even :
                                 (rb_fw_en_3stage_odd) ? reg_dst_result_3stage_odd :
                    (rb_fw_en_3stage_from_even_to_odd) ? reg_dst_result_3stage_even :
                                 (rb_fw_en_4stage_odd) ? reg_dst_result_4stage_odd :
                    (rb_fw_en_4stage_from_even_to_odd) ? reg_dst_result_4stage_even :
                                 (rb_fw_en_5stage_odd) ? reg_dst_result_5stage_odd :
                    (rb_fw_en_5stage_from_even_to_odd) ? reg_dst_result_5stage_even :
                                 (rb_fw_en_6stage_odd) ? reg_dst_result_6stage_odd :
                    (rb_fw_en_6stage_from_even_to_odd) ? reg_dst_result_6stage_even :
                                 (rb_fw_en_7stage_odd) ? reg_dst_result_7stage_odd :
                    (rb_fw_en_7stage_from_even_to_odd) ? reg_dst_result_7stage_even :
                                                         regfile_out_data_5;

    rc_data_odd <=               (rc_fw_en_2stage_odd) ? reg_dst_result_2stage_odd :
                    (rc_fw_en_2stage_from_even_to_odd) ? reg_dst_result_2stage_even :
                                 (rc_fw_en_3stage_odd) ? reg_dst_result_3stage_odd :
                    (rc_fw_en_3stage_from_even_to_odd) ? reg_dst_result_3stage_even :
                                 (rc_fw_en_4stage_odd) ? reg_dst_result_4stage_odd :
                    (rc_fw_en_4stage_from_even_to_odd) ? reg_dst_result_4stage_even :
                                 (rc_fw_en_5stage_odd) ? reg_dst_result_5stage_odd :
                    (rc_fw_en_5stage_from_even_to_odd) ? reg_dst_result_5stage_even :
                                 (rc_fw_en_6stage_odd) ? reg_dst_result_6stage_odd :
                    (rc_fw_en_6stage_from_even_to_odd) ? reg_dst_result_6stage_even :
                                 (rc_fw_en_7stage_odd) ? reg_dst_result_7stage_odd :
                    (rc_fw_en_7stage_from_even_to_odd) ? reg_dst_result_7stage_even :
                                                         regfile_out_data_6;
                    


  end
end

endmodule