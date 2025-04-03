module RF_FU_Pipe_wrapper(
  input clk,
  input rst,

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

  input [0:6] ra_addr_even,
  input [0:6] rb_addr_even,
  input [0:6] rc_addr_even,
  input [0:6] ra_addr_odd,
  input [0:6] rb_addr_odd,
  input [0:6] rc_addr_odd,


  // preload Verification purpose only
  input preload_en,
  input [0:127] preload_addr,
  input [0:127] preload_values,
  input preload_LS_en,
  input [0:14] preload_LS_addr,
  input [0:127] preload_LS_data
);

reg [0:31] full_instr_even_to_pipe, full_instr_odd_to_pipe;
reg [0:6] instr_id_even_to_pipe, instr_id_odd_to_pipe;
reg [0:6] reg_dst_even_to_pipe, reg_dst_odd_to_pipe;
reg [0:2] unit_id_even_to_pipe, unit_id_odd_to_pipe;
reg [0:3] latency_even_to_pipe, latency_odd_to_pipe;
reg reg_wr_even_to_pipe, reg_wr_odd_to_pipe;

reg [0:6] imme7_even_to_pipe, imme7_odd_to_pipe;
reg [0:9] imme10_even_to_pipe, imme10_odd_to_pipe;
reg [0:15] imme16_even_to_pipe, imme16_odd_to_pipe;
reg [0:17] imme18_even_to_pipe, imme18_odd_to_pipe;

reg [0:127] ra_data_even_to_pipe, rb_data_even_to_pipe, rc_data_even_to_pipe,
              ra_data_odd_to_pipe, rb_data_odd_to_pipe, rc_data_odd_to_pipe;

reg [0:142] packed_1stage_even, packed_2stage_even, packed_3stage_even, packed_4stage_even, 
              packed_5stage_even, packed_6stage_even, packed_7stage_even,
              packed_1stage_odd, packed_2stage_odd, packed_3stage_odd, packed_4stage_odd,
              packed_5stage_odd, packed_6stage_odd, packed_7stage_odd;

wire [0:6] WB_reg_write_addr_even, WB_reg_write_addr_odd;
wire [0:127] WB_reg_write_data_even, WB_reg_write_data_odd;
wire WB_reg_write_en_even, WB_reg_write_en_odd;

wire [0:9] current_PC_odd, new_PC_odd;


wire [0:31] full_instr_even_fo, full_instr_odd_fo;
wire [0:6] instr_id_even_fo, instr_id_odd_fo;
wire [0:6] reg_dst_even_fo, reg_dst_odd_fo;
wire [0:2] unit_id_even_fo, unit_id_odd_fo;
wire [0:3] latency_even_fo, latency_odd_fo;
wire reg_wr_even_fo, reg_wr_odd_fo;
wire [0:6] imme7_even_fo, imme7_odd_fo;
wire [0:9] imme10_even_fo, imme10_odd_fo;
wire [0:15] imme16_even_fo, imme16_odd_fo;
wire [0:17] imme18_even_fo, imme18_odd_fo;
wire [0:127] ra_data_even_fo, rb_data_even_fo, rc_data_even_fo,
              ra_data_odd_fo, rb_data_odd_fo, rc_data_odd_fo;

RF_FU_wrapper RF_FU_wrapper_inst (
  .clk(clk),
  .rst(rst),

  // from ID 
  .full_instr_even(full_instr_even),
  .instr_id_even(instr_id_even),
  .reg_dst_even(reg_dst_even),
  .unit_id_even(unit_id_even),
  .latency_even(latency_even),
  .reg_wr_even(reg_wr_even),
  .imme7_even(imme7_even),  // could be reduced to two signals since I7, I10 last bit index is same
  .imme10_even(imme10_even), // and I16, I18 last bit index is same
  .imme16_even(imme16_even),  // or could be extracted from full instr based on which instruction
  .imme18_even(imme18_even),

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

  // register file access
  .ra_addr_even(ra_addr_even),
  .rb_addr_even(rb_addr_even),
  .rc_addr_even(rc_addr_even),
  .ra_addr_odd(ra_addr_odd),
  .rb_addr_odd(rb_addr_odd),
  .rc_addr_odd(rc_addr_odd),
  .reg_write_en_1(WB_reg_write_en_even),
  .reg_write_en_2(WB_reg_write_en_odd),
  .reg_write_addr_1(WB_reg_write_addr_even),
  .reg_write_addr_2(WB_reg_write_addr_odd),
  .reg_write_data_1(WB_reg_write_data_even),
  .reg_write_data_2(WB_reg_write_data_odd),
  
  // inputs for forwarding unit
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

  // output
  .out_full_instr_even(full_instr_even_fo),
  .out_instr_id_even(instr_id_even_fo),
  .out_reg_dst_even(reg_dst_even_fo),
  .out_unit_id_even(unit_id_even_fo),
  .out_latency_even(latency_even_fo),
  .out_reg_wr_even(reg_wr_even_fo),
  .out_imme7_even(imme7_even_fo),
  .out_imme10_even(imme10_even_fo),
  .out_imme16_even(imme16_even_fo),
  .out_imme18_even(imme18_even_fo),

  .out_full_instr_odd(full_instr_odd_fo),
  .out_instr_id_odd(instr_id_odd_fo),
  .out_reg_dst_odd(reg_dst_odd_fo),
  .out_unit_id_odd(unit_id_odd_fo),
  .out_latency_odd(latency_odd_fo),
  .out_reg_wr_odd(reg_wr_odd_fo),
  .out_imme7_odd(imme7_odd_fo),
  .out_imme10_odd(imme10_odd_fo),
  .out_imme16_odd(imme16_odd_fo),
  .out_imme18_odd(imme18_odd_fo),

  .ra_data_even(ra_data_even_fo),
  .rb_data_even(rb_data_even_fo),
  .rc_data_even(rc_data_even_fo),
  .ra_data_odd(ra_data_odd_fo),
  .rb_data_odd(rb_data_odd_fo),
  .rc_data_odd(rc_data_odd_fo),

  .preload_en(preload_en),
  .preload_addr(preload_addr),
  .preload_values(preload_values)
);

always @(posedge clk or posedge rst) begin
  if (rst) begin
    full_instr_even_to_pipe <= 0;
    instr_id_even_to_pipe <= 0;
    reg_dst_even_to_pipe <= 0;
    unit_id_even_to_pipe <= 0;
    latency_even_to_pipe <= 0;
    reg_wr_even_to_pipe <= 0;
    ra_data_even_to_pipe <= 0;
    rb_data_even_to_pipe <= 0;
    rc_data_even_to_pipe <= 0;
    imme7_even_to_pipe <= 0;
    imme10_even_to_pipe <= 0;
    imme16_even_to_pipe <= 0;
    imme18_even_to_pipe <= 0;

    full_instr_odd_to_pipe <= 0;
    instr_id_odd_to_pipe <= 0;
    reg_dst_odd_to_pipe <= 0;
    unit_id_odd_to_pipe <= 0;
    latency_odd_to_pipe <= 0;
    reg_wr_odd_to_pipe <= 0;
    ra_data_odd_to_pipe <= 0;
    rb_data_odd_to_pipe <= 0;
    rc_data_odd_to_pipe <= 0;
    imme7_odd_to_pipe <= 0;
    imme10_odd_to_pipe <= 0;
    imme16_odd_to_pipe <= 0;
    imme18_odd_to_pipe <= 0;
  end else begin
    full_instr_even_to_pipe <= full_instr_even_fo;
    instr_id_even_to_pipe <= instr_id_even_fo;
    reg_dst_even_to_pipe <= reg_dst_even_fo;
    unit_id_even_to_pipe <= unit_id_even_fo;
    latency_even_to_pipe <= latency_even_fo;
    reg_wr_even_to_pipe <= reg_wr_even_fo;
    ra_data_even_to_pipe <= ra_data_even_fo;
    rb_data_even_to_pipe <= rb_data_even_fo;
    rc_data_even_to_pipe <= rc_data_even_fo;
    imme7_even_to_pipe <= imme7_even_fo;
    imme10_even_to_pipe <= imme10_even_fo;
    imme16_even_to_pipe <= imme16_even_fo;
    imme18_even_to_pipe <= imme18_even_fo;

    full_instr_odd_to_pipe <= full_instr_odd_fo;
    instr_id_odd_to_pipe <= instr_id_odd_fo;
    reg_dst_odd_to_pipe <= reg_dst_odd_fo;
    unit_id_odd_to_pipe <= unit_id_odd_fo;
    latency_odd_to_pipe <= latency_odd_fo;
    reg_wr_odd_to_pipe <= reg_wr_odd_fo;
    ra_data_odd_to_pipe <= ra_data_odd_fo;
    rb_data_odd_to_pipe <= rb_data_odd_fo;
    rc_data_odd_to_pipe <= rc_data_odd_fo;
    imme7_odd_to_pipe <= imme7_odd_fo;
    imme10_odd_to_pipe <= imme10_odd_fo;
    imme16_odd_to_pipe <= imme16_odd_fo;
    imme18_odd_to_pipe <= imme18_odd_fo; 
  end
end

Even_Pipe Even_Pipe_inst (
  .clk(clk),
  .rst(rst),
  .full_instr(full_instr_even_to_pipe),
  .instr_id(instr_id_even_to_pipe),
  .reg_dst(reg_dst_even_to_pipe),
  .unit_id(unit_id_even_to_pipe),
  .latency(latency_even_to_pipe),
  .reg_wr(reg_wr_even_to_pipe),
  .ra_data(ra_data_even_to_pipe),
  .rb_data(rb_data_even_to_pipe),
  .rc_data(rc_data_even_to_pipe),
  .imme7(imme7_even_to_pipe),   
  .imme10(imme10_even_to_pipe),
  .imme16(imme16_even_to_pipe),
  .imme18(imme18_even_to_pipe),
  .packed_2stage(packed_2stage_even),
  .packed_3stage(packed_3stage_even),
  .packed_4stage(packed_4stage_even),
  .packed_5stage(packed_5stage_even),
  .packed_6stage(packed_6stage_even),
  .packed_7stage(packed_7stage_even),
  .WB_reg_write_addr(WB_reg_write_addr_even),
  .WB_reg_write_data(WB_reg_write_data_even),
  .WB_reg_write_en(WB_reg_write_en_even)
);

Odd_Pipe Odd_Pipe_inst(
  .clk(clk),
  .rst(rst),
  .full_instr(full_instr_odd_to_pipe),
  .instr_id(instr_id_odd_to_pipe),
  .reg_dst(reg_dst_odd_to_pipe),
  .unit_id(unit_id_odd_to_pipe),
  .latency(latency_odd_to_pipe),
  .reg_wr(reg_wr_odd_to_pipe),
  .ra_data(ra_data_odd_to_pipe),
  .rb_data(rb_data_odd_to_pipe),
  .rc_data(rc_data_odd_to_pipe),
  .imme7(imme7_odd_to_pipe),  
  .imme10(imme10_odd_to_pipe),
  .imme16(imme16_odd_to_pipe),
  .imme18(imme18_odd_to_pipe),
  .current_PC(new_PC_odd), // have to be connected to PC module
  .packed_2stage(packed_2stage_odd),
  .packed_3stage(packed_3stage_odd),
  .packed_4stage(packed_4stage_odd),
  .packed_5stage(packed_5stage_odd),
  .packed_6stage(packed_6stage_odd),
  .packed_7stage(packed_7stage_odd),
  .WB_reg_write_addr(WB_reg_write_addr_odd),
  .WB_reg_write_data(WB_reg_write_data_odd),
  .WB_reg_write_en(WB_reg_write_en_odd),
  .new_PC(current_PC_odd), // have to be connected to PC module
  .preload_LS_en(preload_LS_en),
  .preload_LS_addr(preload_LS_addr),
  .preload_LS_data(preload_LS_data)
);

Program_Counter Program_Counter_inst( // only for branch verification purpose. Should be placed in ID stage
  .clk(clk),
  .rst(rst),
  .unit_id(unit_id_odd_to_pipe),
  .PC_in(current_PC_odd),
  .PC_out(new_PC_odd)
);

endmodule