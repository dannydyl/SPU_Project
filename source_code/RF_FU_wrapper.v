module RF_FU_wrapper(
  input clk,
  input rst,

  // inputs for instruction
  input [0:31] instruction_even,
  input [0:31] instruction_odd,
  input [0:2] unit_id_even,
  input [0:2] unit_id_odd,
  input [0:6] instr_id_even,
  input [0:6] instr_id_odd,

  // inputs for register file
  input [0:6] ra_addr_even,
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
  input [0:6] reg_dst_1stage_even,
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

  input [0:3] latency_1stage_even,
  input [0:3] latency_2stage_even,
  input [0:3] latency_3stage_even,
  input [0:3] latency_4stage_even,
  input [0:3] latency_5stage_even,
  input [0:3] latency_6stage_even,
  input [0:3] latency_7stage_even,

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

  input [0:3] latency_1stage_odd,
  input [0:3] latency_2stage_odd,
  input [0:3] latency_3stage_odd,
  input [0:3] latency_4stage_odd,
  input [0:3] latency_5stage_odd,
  input [0:3] latency_6stage_odd,
  input [0:3] latency_7stage_odd,

  input [0:127] reg_dst_result_1stage_even,
  input [0:127] reg_dst_result_2stage_even,
  input [0:127] reg_dst_result_3stage_even,
  input [0:127] reg_dst_result_4stage_even,
  input [0:127] reg_dst_result_5stage_even,
  input [0:127] reg_dst_result_6stage_even,
  input [0:127] reg_dst_result_7stage_even,

  input [0:127] reg_dst_result_1stage_odd,
  input [0:127] reg_dst_result_2stage_odd,
  input [0:127] reg_dst_result_3stage_odd,
  input [0:127] reg_dst_result_4stage_odd,
  input [0:127] reg_dst_result_5stage_odd,
  input [0:127] reg_dst_result_6stage_odd,
  input [0:127] reg_dst_result_7stage_odd,

  // OUTPUT 
  output reg [0:31] out_instr_even,
  output reg [0:31] out_instr_odd,
  output reg [0:6] out_instr_id_even,
  output reg [0:6] out_instr_id_odd,
  output reg [0:2] out_unit_id_even,
  output reg [0:2] out_unit_id_odd,

  output reg [0:127] ra_data_even,
  output reg [0:127] rb_data_even,
  output reg [0:127] rc_data_even,

  output reg [0:127] ra_data_odd,
  output reg [0:127] rb_data_odd,
  output reg [0:127] rc_data_odd

);
reg [0:127] regfile_out_data_1;
reg [0:127] regfile_out_data_2;
reg [0:127] regfile_out_data_3;
reg [0:127] regfile_out_data_4;
reg [0:127] regfile_out_data_5;
reg [0:127] regfile_out_data_6;

wire ra_fw_en_1stage_even;
wire rb_fw_en_1stage_even;
wire rc_fw_en_1stage_even;
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
);

Forwarding_Unit FU_inst(
  .reg_ra_src_even(ra_addr_even),
  .reg_rb_src_even(rb_addr_even),
  .reg_rc_src_even(rc_addr_even),

  .reg_dst_1stage_even(reg_dst_1stage_even),
  .reg_dst_2stage_even(reg_dst_2stage_even),
  .reg_dst_3stage_even(reg_dst_3stage_even),
  .reg_dst_4stage_even(reg_dst_4stage_even),
  .reg_dst_5stage_even(reg_dst_5stage_even),
  .reg_dst_6stage_even(reg_dst_6stage_even),
  .reg_dst_7stage_even(reg_dst_7stage_even),

  .reg_wr_1stage_even(reg_wr_1stage_even),
  .reg_wr_2stage_even(reg_wr_2stage_even),
  .reg_wr_3stage_even(reg_wr_3stage_even),
  .reg_wr_4stage_even(reg_wr_4stage_even),
  .reg_wr_5stage_even(reg_wr_5stage_even),
  .reg_wr_6stage_even(reg_wr_6stage_even),
  .reg_wr_7stage_even(reg_wr_7stage_even),

  .latency_1stage_even(latency_1stage_even),
  .latency_2stage_even(latency_2stage_even),
  .latency_3stage_even(latency_3stage_even),
  .latency_4stage_even(latency_4stage_even),
  .latency_5stage_even(latency_5stage_even),
  .latency_6stage_even(latency_6stage_even),
  .latency_7stage_even(latency_7stage_even),

  .reg_ra_src_odd(ra_addr_odd),
  .reg_rb_src_odd(rb_addr_odd),
  .reg_rc_src_odd(rc_addr_odd),

  .reg_dst_1stage_odd(reg_dst_1stage_odd),
  .reg_dst_2stage_odd(reg_dst_2stage_odd),
  .reg_dst_3stage_odd(reg_dst_3stage_odd),
  .reg_dst_4stage_odd(reg_dst_4stage_odd),
  .reg_dst_5stage_odd(reg_dst_5stage_odd),
  .reg_dst_6stage_odd(reg_dst_6stage_odd),
  .reg_dst_7stage_odd(reg_dst_7stage_odd),

  .reg_wr_1stage_odd(reg_wr_1stage_odd),
  .reg_wr_2stage_odd(reg_wr_2stage_odd),
  .reg_wr_3stage_odd(reg_wr_3stage_odd),
  .reg_wr_4stage_odd(reg_wr_4stage_odd),
  .reg_wr_5stage_odd(reg_wr_5stage_odd),
  .reg_wr_6stage_odd(reg_wr_6stage_odd),
  .reg_wr_7stage_odd(reg_wr_7stage_odd),

  .latency_1stage_odd(latency_1stage_odd),
  .latency_2stage_odd(latency_2stage_odd),
  .latency_3stage_odd(latency_3stage_odd),
  .latency_4stage_odd(latency_4stage_odd),
  .latency_5stage_odd(latency_5stage_odd),
  .latency_6stage_odd(latency_6stage_odd),
  .latency_7stage_odd(latency_7stage_odd),

  // OUTPUT
  .ra_fw_en_1stage_even(ra_fw_en_1stage_even),
  .rb_fw_en_1stage_even(rb_fw_en_1stage_even),
  .rc_fw_en_1stage_even(rc_fw_en_1stage_even),
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
  .rc_fw_en_7stage_even(rc_fw_en_7stage_even)
);


wire temp_instr_even;
wire temp_instr_odd;
wire temp_instr_id_even;
wire temp_instr_id_odd;
wire temp_unit_id_even;
wire temp_unit_id_odd;

assign temp_instr_even = instruction_even;
assign temp_instr_odd = instruction_odd;
assign temp_instr_id_even = instr_id_even;
assign temp_instr_id_odd = instr_id_odd;
assign temp_unit_id_even = unit_id_even;
assign temp_unit_id_odd = unit_id_odd;

always @(posedge clk or posedge rst) begin
  if(rst) begin
    out_instr_even <= 32'b0;
    out_instr_odd <= 32'b0;
    out_instr_id_even <= 7'b0;
    out_instr_id_odd <= 7'b0;
    out_unit_id_even <= 3'b0;
    out_unit_id_odd <= 3'b0;
    
    regfile_out_data_1 <= 128'b0;
    regfile_out_data_2 <= 128'b0;
    regfile_out_data_3 <= 128'b0;
    regfile_out_data_4 <= 128'b0;
    regfile_out_data_5 <= 128'b0;
    regfile_out_data_6 <= 128'b0;
  end
  else begin
    out_instr_even <= temp_instr_even;
    out_instr_odd <= temp_instr_odd;
    out_instr_id_even <= temp_instr_id_even;
    out_instr_id_odd <= temp_instr_id_odd;
    out_unit_id_even <= temp_unit_id_even;
    out_unit_id_odd <= temp_unit_id_odd;

    // when result has to be forwarded to ra (even), recent stages has priority for forwarding
    ra_data_even <= (ra_fw_en_1stage_even) ? reg_dst_result_1stage_even :
                    (ra_fw_en_2stage_even) ? reg_dst_result_2stage_even :
                    (ra_fw_en_3stage_even) ? reg_dst_result_3stage_even :
                    (ra_fw_en_4stage_even) ? reg_dst_result_4stage_even :
                    (ra_fw_en_5stage_even) ? reg_dst_result_5stage_even :
                    (ra_fw_en_6stage_even) ? reg_dst_result_6stage_even :
                    (ra_fw_en_7stage_even) ? reg_dst_result_7stage_even :
                    regfile_out_data_1;

    // when result has to be forwarded to rb (even), recent stages has priority for forwarding
    rb_data_even <= (rb_fw_en_1stage_even) ? reg_dst_result_1stage_even :
                    (rb_fw_en_2stage_even) ? reg_dst_result_2stage_even :
                    (rb_fw_en_3stage_even) ? reg_dst_result_3stage_even :
                    (rb_fw_en_4stage_even) ? reg_dst_result_4stage_even :
                    (rb_fw_en_5stage_even) ? reg_dst_result_5stage_even :
                    (rb_fw_en_6stage_even) ? reg_dst_result_6stage_even :
                    (rb_fw_en_7stage_even) ? reg_dst_result_7stage_even :
                    regfile_out_data_2;

    rc_data_even <= (rc_fw_en_1stage_even) ? reg_dst_result_1stage_even :
                    (rc_fw_en_2stage_even) ? reg_dst_result_2stage_even :
                    (rc_fw_en_3stage_even) ? reg_dst_result_3stage_even :
                    (rc_fw_en_4stage_even) ? reg_dst_result_4stage_even :
                    (rc_fw_en_5stage_even) ? reg_dst_result_5stage_even :
                    (rc_fw_en_6stage_even) ? reg_dst_result_6stage_even :
                    (rc_fw_en_7stage_even) ? reg_dst_result_7stage_even :
                    regfile_out_data_3;

    ra_data_odd <=  (ra_fw_en_1stage_odd) ? reg_dst_result_1stage_odd :
                    (ra_fw_en_2stage_odd) ? reg_dst_result_2stage_odd :
                    (ra_fw_en_3stage_odd) ? reg_dst_result_3stage_odd :
                    (ra_fw_en_4stage_odd) ? reg_dst_result_4stage_odd :
                    (ra_fw_en_5stage_odd) ? reg_dst_result_5stage_odd :
                    (ra_fw_en_6stage_odd) ? reg_dst_result_6stage_odd :
                    (ra_fw_en_7stage_odd) ? reg_dst_result_7stage_odd :
                    regfile_out_data_4;

    rb_data_odd <=  (rb_fw_en_1stage_odd) ? reg_dst_result_1stage_odd :
                    (rb_fw_en_2stage_odd) ? reg_dst_result_2stage_odd :
                    (rb_fw_en_3stage_odd) ? reg_dst_result_3stage_odd :
                    (rb_fw_en_4stage_odd) ? reg_dst_result_4stage_odd :
                    (rb_fw_en_5stage_odd) ? reg_dst_result_5stage_odd :
                    (rb_fw_en_6stage_odd) ? reg_dst_result_6stage_odd :
                    (rb_fw_en_7stage_odd) ? reg_dst_result_7stage_odd :
                    regfile_out_data_5;

    rc_data_odd <=  (rc_fw_en_1stage_odd) ? reg_dst_result_1stage_odd :
                    (rc_fw_en_2stage_odd) ? reg_dst_result_2stage_odd :
                    (rc_fw_en_3stage_odd) ? reg_dst_result_3stage_odd :
                    (rc_fw_en_4stage_odd) ? reg_dst_result_4stage_odd :
                    (rc_fw_en_5stage_odd) ? reg_dst_result_5stage_odd :
                    (rc_fw_en_6stage_odd) ? reg_dst_result_6stage_odd :
                    (rc_fw_en_7stage_odd) ? reg_dst_result_7stage_odd :
                    regfile_out_data_6;


  end
end

endmodule