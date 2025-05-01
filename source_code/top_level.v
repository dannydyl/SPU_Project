module top_level(
  input clk,
  input rst,
  input load_en,
  input [0:31] instruction_in,
  input [0:9] instr_load_addr,
  input preload_en,
  input [0:9] preload_addr,
  input [0:127] preload_values,
  input preload_LS_en,
  input [0:14] preload_LS_addr,
  input [0:127] preload_LS_data

);

wire [0:31] instruction_out1, instruction_out2;

wire [0:31] full_instr_even, full_instr_odd, full_instr_even_to_pipe, full_instr_odd_to_pipe;
wire [0:6] instr_id_even, instr_id_odd, instr_id_even_to_pipe, instr_id_odd_to_pipe;
wire [0:6] reg_dst_even, reg_dst_odd, reg_dst_even_to_pipe, reg_dst_odd_to_pipe;
wire [0:2] unit_id_even, unit_id_odd, unit_id_even_to_pipe, unit_id_odd_to_pipe;
wire [0:3] latency_even, latency_odd, latency_even_to_pipe, latency_odd_to_pipe;
wire reg_wr_even, reg_wr_odd, reg_wr_even_to_pipe, reg_wr_odd_to_pipe;

wire [0:6] imme7_even, imme7_odd, imme7_even_to_pipe, imme7_odd_to_pipe;
wire [0:9] imme10_even, imme10_odd, imme10_even_to_pipe, imme10_odd_to_pipe;
wire [0:15] imme16_even, imme16_odd, imme16_even_to_pipe, imme16_odd_to_pipe;
wire [0:17] imme18_even, imme18_odd, imme18_even_to_pipe, imme18_odd_to_pipe;

wire [0:6] ra_addr_even, rb_addr_even, rc_addr_even,
            ra_addr_odd, rb_addr_odd, rc_addr_odd;
wire [0:127]  ra_data_even_to_pipe, rb_data_even_to_pipe, rc_data_even_to_pipe,
              ra_data_odd_to_pipe, rb_data_odd_to_pipe, rc_data_odd_to_pipe;

wire [0:142] packed_1stage_even, packed_2stage_even, packed_3stage_even, packed_4stage_even, 
              packed_5stage_even, packed_6stage_even, packed_7stage_even,
              packed_1stage_odd, packed_2stage_odd, packed_3stage_odd, packed_4stage_odd,
              packed_5stage_odd, packed_6stage_odd, packed_7stage_odd;

wire [0:6] WB_reg_write_addr_even, WB_reg_write_addr_odd;
wire [0:127] WB_reg_write_data_even, WB_reg_write_data_odd;
wire WB_reg_write_en_even, WB_reg_write_en_odd;

wire [0:9] PC_br_target, PC_pass2ID, PC_pass2RF, PC_pass2odd;

wire stall, flush, branch_taken, is_branch, find_nop;

IF_wrapper IF_inst(
  .clk(clk),
  .rst(rst),
  .load_en(load_en),
  .instruction_in(instruction_in),
  .instr_load_addr(instr_load_addr),
  .PC_br_target(PC_br_target),
  .is_branch(is_branch),
  .branch_taken(branch_taken),
  .stall(stall),

  .PC_current_out(PC_pass2ID),
  .instruction_out1(instruction_out1),
  .instruction_out2(instruction_out2),
  .find_nop(find_nop)
);

ID_HU_wrapper IDHU_inst(
  .clk(clk),
  .rst(rst),
  .is_branch(is_branch),
  .branch_taken(branch_taken),
  .PC_pass_in(PC_pass2ID),
  .instruction_in1(instruction_out1),
  .instruction_in2(instruction_out2),
  .find_nop(find_nop),

  .RF_reg_dst_even(reg_dst_even_to_pipe),
  .RF_reg_wr_even(reg_wr_even_to_pipe),
  .RF_latency_even(latency_even_to_pipe),
  .packed_2stage_even(packed_2stage_even),
  .packed_3stage_even(packed_3stage_even),
  .packed_4stage_even(packed_4stage_even),
  .packed_5stage_even(packed_5stage_even),
  .packed_6stage_even(packed_6stage_even),

  .RF_reg_dst_odd(reg_dst_odd_to_pipe),
  .RF_reg_wr_odd(reg_wr_odd_to_pipe),
  .RF_latency_odd(latency_odd_to_pipe),
  .packed_2stage_odd(packed_2stage_odd),
  .packed_3stage_odd(packed_3stage_odd),
  .packed_4stage_odd(packed_4stage_odd),
  .packed_5stage_odd(packed_5stage_odd),
  .packed_6stage_odd(packed_6stage_odd),

  .full_instr_even(full_instr_even),
  .instr_id_even(instr_id_even),
  .reg_dst_even(reg_dst_even),
  .unit_id_even(unit_id_even),
  .latency_even(latency_even),
  .reg_wr_even(reg_wr_even),
  .imme7_even(imme7_even),
  .imme10_even(imme10_even),
  .imme16_even(imme16_even),
  .imme18_even(imme18_even),

  .ra_addr_even(ra_addr_even),
  .rb_addr_even(rb_addr_even),
  .rc_addr_even(rc_addr_even),

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

  .ra_addr_odd(ra_addr_odd),
  .rb_addr_odd(rb_addr_odd),
  .rc_addr_odd(rc_addr_odd),

  .stall(stall),
  .flush(flush),
  .PC_pass_out(PC_pass2RF)
);

RF_FU_wrapper RFFU_inst(
  .clk(clk),
  .rst(rst),
  .flush(flush),
  .PC_pass_in(PC_pass2RF),
  // from ID 
  .full_instr_even(full_instr_even),
  .instr_id_even(instr_id_even),
  .reg_dst_even(reg_dst_even),
  .unit_id_even(unit_id_even),
  .latency_even(latency_even),
  .reg_wr_even(reg_wr_even),
  .imme7_even(imme7_even),  
  .imme10_even(imme10_even), 
  .imme16_even(imme16_even),  
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
  .out_full_instr_even(full_instr_even_to_pipe),
  .out_instr_id_even(instr_id_even_to_pipe),
  .out_reg_dst_even(reg_dst_even_to_pipe),
  .out_unit_id_even(unit_id_even_to_pipe),
  .out_latency_even(latency_even_to_pipe),
  .out_reg_wr_even(reg_wr_even_to_pipe),
  .out_imme7_even(imme7_even_to_pipe),
  .out_imme10_even(imme10_even_to_pipe),
  .out_imme16_even(imme16_even_to_pipe),
  .out_imme18_even(imme18_even_to_pipe),

  .out_full_instr_odd(full_instr_odd_to_pipe),
  .out_instr_id_odd(instr_id_odd_to_pipe),
  .out_reg_dst_odd(reg_dst_odd_to_pipe),
  .out_unit_id_odd(unit_id_odd_to_pipe),
  .out_latency_odd(latency_odd_to_pipe),
  .out_reg_wr_odd(reg_wr_odd_to_pipe),
  .out_imme7_odd(imme7_odd_to_pipe),
  .out_imme10_odd(imme10_odd_to_pipe),
  .out_imme16_odd(imme16_odd_to_pipe),
  .out_imme18_odd(imme18_odd_to_pipe),

  .ra_data_even(ra_data_even_to_pipe),
  .rb_data_even(rb_data_even_to_pipe),
  .rc_data_even(rc_data_even_to_pipe),
  .ra_data_odd(ra_data_odd_to_pipe),
  .rb_data_odd(rb_data_odd_to_pipe),
  .rc_data_odd(rc_data_odd_to_pipe),

  .PC_pass_out(PC_pass2odd),

  .preload_en(preload_en),
  .preload_addr(preload_addr),
  .preload_values(preload_values)
);

Even_Pipe Even_Pipe_inst (
  .clk(clk),
  .rst(rst),
  .flush(flush),
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
  .flush(flush),
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
  .current_PC(PC_pass2odd),
  .packed_2stage(packed_2stage_odd),
  .packed_3stage(packed_3stage_odd),
  .packed_4stage(packed_4stage_odd),
  .packed_5stage(packed_5stage_odd),
  .packed_6stage(packed_6stage_odd),
  .packed_7stage(packed_7stage_odd),
  .WB_reg_write_addr(WB_reg_write_addr_odd),
  .WB_reg_write_data(WB_reg_write_data_odd),
  .WB_reg_write_en(WB_reg_write_en_odd),
  .new_PC(PC_br_target), 
  .branch_taken(branch_taken),
  .is_branch(is_branch),
  .preload_LS_en(preload_LS_en),
  .preload_LS_addr(preload_LS_addr),
  .preload_LS_data(preload_LS_data)
);

endmodule