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
  reg [0:6] imme7_even;
  reg [0:9] imme10_even;
  reg [0:15] imme16_even;
  reg [0:17] imme18_even;

  // Odd pipe inputs
  reg [0:31] full_instr_odd;
  reg [0:6]  instr_id_odd;
  reg [0:6]  reg_dst_odd;
  reg [0:2]  unit_id_odd;
  reg [0:3]  latency_odd;
  reg        reg_wr_odd;
  reg [0:6] imme7_odd;
  reg [0:9] imme10_odd;
  reg [0:15] imme16_odd;
  reg [0:17] imme18_odd;

  // Register file addresses
  reg [0:6] ra_addr_even, rb_addr_even, rc_addr_even;
  reg [0:6] ra_addr_odd,  rb_addr_odd,  rc_addr_odd;

  // Preload signals (for verification)
  reg preload_en;
  reg [0:127] preload_addr, preload_values;

  localparam clock_cycle = 10;

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

    .ra_addr_even(ra_addr_even),
    .rb_addr_even(rb_addr_even),
    .rc_addr_even(rc_addr_even),
    .ra_addr_odd(ra_addr_odd),
    .rb_addr_odd(rb_addr_odd),
    .rc_addr_odd(rc_addr_odd),

    .preload_en(preload_en),
    .preload_addr(preload_addr),
    .preload_values(preload_values)
  );

  // Clock generation: 10ns period
  initial begin
    clk = 0;
    forever #(clock_cycle/2) clk = ~clk;
  end

integer i;
  // Dump waveforms for simulation
  initial begin
    $dumpfile("RF_FU_Pipe_wrapper_tb.vcd");
    $dumpvars(0, tb_RF_FU_Pipe_wrapper);
  end

  // Test stimulus
  initial begin
    // Initialize all signals
    #(clock_cycle/2);
    rst = 1;
    // preload_en = 0;
    full_instr_even = 32'd0;
    instr_id_even   = 7'd0;
    reg_dst_even    = 7'd0;
    unit_id_even    = 3'd0;
    latency_even    = 4'd0;
    reg_wr_even     = 0;
    imme7_even      = 7'd0;
    imme10_even     = 10'd0;
    imme16_even     = 16'd0;
    imme18_even     = 18'd0;

    full_instr_odd  = 32'd0;
    instr_id_odd    = 7'd0;
    reg_dst_odd     = 7'd0;
    unit_id_odd     = 3'd0;
    latency_odd     = 4'd0;
    reg_wr_odd      = 0;
    imme7_odd       = 7'd0;
    imme10_odd      = 10'd0;
    imme16_odd      = 16'd0;
    imme18_odd      = 18'd0;

    ra_addr_even = 7'd0;
    rb_addr_even = 7'd0;
    rc_addr_even = 7'd0;
    ra_addr_odd  = 7'd0;
    rb_addr_odd  = 7'd0;
    rc_addr_odd  = 7'd0;

      // Load pre-defined values into all 128 registers
    #(clock_cycle); // let all the registers to be all 0s

    preload_en = 1;

    preload_addr = 128'h1;
    preload_values = 128'h00000001_00000001_00000001_00000001;
    #(clock_cycle);

    preload_addr = 128'h3;
    preload_values = 128'h00000003_00000003_00000003_00000003;
    #(clock_cycle);

    preload_addr = 128'h2;
    preload_values = 128'h00000002_00000002_00000002_00000002;
    #(clock_cycle);

    preload_addr = 128'h3;
    preload_values = 128'h00000003_00000003_00000003_00000003;
    #(clock_cycle);

    preload_en = 0;
    rst = 0;
    // for (i = 0; i < 128; i = i + 1) begin
    //   preload_values = {8{i}}; // Example pattern: {i, i, i, i, i, i, i, i}
    //   #(clock_cycle); // have to preload reg value every cycle
    // end

    #(clock_cycle);

    // Apply first set of sample instructions
    full_instr_even = 32'b00011100000000001100000100000001;
    instr_id_even   = 7'd4;
    reg_dst_even    = 7'b0000001;
    unit_id_even    = 3'b001;
    latency_even    = 4'b0011;
    reg_wr_even     = 1;
    imme7_even      = 7'd0;
    imme10_even     = 10'd3;
    imme16_even     = 16'd0;
    imme18_even     = 18'd0;

    ra_addr_even = 7'd2;
    rb_addr_even = 7'd3;
    rc_addr_even = 7'd1;

    full_instr_odd  = 32'd0;
    instr_id_odd    = 7'd0;
    reg_dst_odd     = 7'd0;
    unit_id_odd     = 3'd0;
    latency_odd     = 4'd0;
    reg_wr_odd      = 0;
    imme7_odd       = 7'd0;
    imme10_odd      = 10'd0;
    imme16_odd      = 16'd0;
    imme18_odd      = 18'd0;

    ra_addr_odd  = 7'd0;
    rb_addr_odd  = 7'd0;
    rc_addr_odd  = 7'd0;

    // Add further test cases (or loop over an array of ~90 instructions)
    // #(clock_cycle);
    // full_instr_even = 32'h8c90c9c8;
    // instr_id_even   = 7'h03;
    // reg_dst_even    = 7'h04;
    // unit_id_even    = 3'h5;
    // latency_even    = 4'h6;
    // reg_wr_even     = 0;

    // full_instr_odd  = 32'h00000000;
    // instr_id_odd    = 7'h03;
    // reg_dst_odd     = 7'h04;
    // unit_id_odd     = 3'h5;
    // latency_odd     = 4'h6;
    // reg_wr_odd      = 0;

    // Run simulation for additional cycles
    #200;
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
