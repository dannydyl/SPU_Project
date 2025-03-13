`timescale 1ns/1ps

module tb_RF_FU_Pipe_wrapper;

  // Clock and reset
  reg clk;
  reg rst;

  // Even pipe inputs
  reg [0:31] full_instr_even;
  reg [0:6]  instr_id_even;
  reg [0:6]  reg_dst_even;
  reg [0:2]  unit_id_even;
  reg [0:3]  latency_even;
  reg        reg_wr_even;

  // Odd pipe inputs
  reg [0:31] full_instr_odd;
  reg [0:6]  instr_id_odd;
  reg [0:6]  reg_dst_odd;
  reg [0:2]  unit_id_odd;
  reg [0:3]  latency_odd;
  reg        reg_wr_odd;

  // Register file addresses
  reg [0:6] ra_addr_even, rb_addr_even, rc_addr_even;
  reg [0:6] ra_addr_odd,  rb_addr_odd,  rc_addr_odd;

  // Preload signals (for verification)
  reg preload_en;
  reg [0:127] preload_values [0:127];

  // Instantiate the DUT
  RF_FU_Pipe_wrapper dut (
    .clk(clk),
    .rst(rst),

    .full_instr_even(full_instr_even),
    .instr_id_even(instr_id_even),
    .reg_dst_even(reg_dst_even),
    .unit_id_even(unit_id_even),
    .latency_even(latency_even),
    .reg_wr_even(reg_wr_even),

    .full_instr_odd(full_instr_odd),
    .instr_id_odd(instr_id_odd),
    .reg_dst_odd(reg_dst_odd),
    .unit_id_odd(unit_id_odd),
    .latency_odd(latency_odd),
    .reg_wr_odd(reg_wr_odd),

    .ra_addr_even(ra_addr_even),
    .rb_addr_even(rb_addr_even),
    .rc_addr_even(rc_addr_even),
    .ra_addr_odd(ra_addr_odd),
    .rb_addr_odd(rb_addr_odd),
    .rc_addr_odd(rc_addr_odd),

    .preload_en(preload_en),
    .preload_values(preload_values)
  );

  // Clock generation: 10ns period
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Dump waveforms for simulation
  initial begin
    $dumpfile("RF_FU_Pipe_wrapper_tb.vcd");
    $dumpvars(0, tb_RF_FU_Pipe_wrapper);
  end

  // Test stimulus
  initial begin
    // Initialize all signals
    rst = 1;
    preload_en = 0;
    full_instr_even = 32'd0;
    instr_id_even   = 7'd0;
    reg_dst_even    = 7'd0;
    unit_id_even    = 3'd0;
    latency_even    = 4'd0;
    reg_wr_even     = 0;

    full_instr_odd  = 32'd0;
    instr_id_odd    = 7'd0;
    reg_dst_odd     = 7'd0;
    unit_id_odd     = 3'd0;
    latency_odd     = 4'd0;
    reg_wr_odd      = 0;

    ra_addr_even = 7'd0;
    rb_addr_even = 7'd0;
    rc_addr_even = 7'd0;
    ra_addr_odd  = 7'd0;
    rb_addr_odd  = 7'd0;
    rc_addr_odd  = 7'd0;

    // Apply reset for a short duration
    #20;
    rst = 0;

    // Apply first set of sample instructions
    #10;
    full_instr_even = 32'hA5A5A5A5;
    instr_id_even   = 7'h01;
    reg_dst_even    = 7'h02;
    unit_id_even    = 3'h3;
    latency_even    = 4'h4;
    reg_wr_even     = 1;

    full_instr_odd  = 32'h5A5A5A5A;
    instr_id_odd    = 7'h01;
    reg_dst_odd     = 7'h02;
    unit_id_odd     = 3'h3;
    latency_odd     = 4'h4;
    reg_wr_odd      = 1;

    // Add further test cases (or loop over an array of ~90 instructions)
    #10;
    full_instr_even = 32'hFFFFFFFF;
    instr_id_even   = 7'h03;
    reg_dst_even    = 7'h04;
    unit_id_even    = 3'h5;
    latency_even    = 4'h6;
    reg_wr_even     = 0;

    full_instr_odd  = 32'h00000000;
    instr_id_odd    = 7'h03;
    reg_dst_odd     = 7'h04;
    unit_id_odd     = 3'h5;
    latency_odd     = 4'h6;
    reg_wr_odd      = 0;

    // Run simulation for additional cycles
    #50;
    $finish;
  end

  // Print packed stage signals each cycle
  always @(posedge clk) begin
    $display("Time: %0t", $time);
    $display("Even pipe stages: 1:%b 2:%b 3:%b 4:%b 5:%b 6:%b 7:%b",
             dut.packed_1stage_even, dut.packed_2stage_even, dut.packed_3stage_even,
             dut.packed_4stage_even, dut.packed_5stage_even, dut.packed_6stage_even,
             dut.packed_7stage_even);
    $display("Odd pipe stages:  1:%b 2:%b 3:%b 4:%b 5:%b 6:%b 7:%b",
             dut.packed_1stage_odd, dut.packed_2stage_odd, dut.packed_3stage_odd,
             dut.packed_4stage_odd, dut.packed_5stage_odd, dut.packed_6stage_odd,
             dut.packed_7stage_odd);
  end

endmodule
