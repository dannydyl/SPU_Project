`timescale 1ns/1ps

module top_level_tb;

  // signal declarations
  reg         clk;
  reg         rst;
  reg         load_en;
  reg         preload_en;
  reg  [0:31] instruction_in;
  reg   [0:9] preload_addr;
  reg [0:127] preload_values;

  // instantiate device under test
  top_level dut (
    .clk            (clk),
    .rst            (rst),
    .load_en        (load_en),
    .instruction_in (instruction_in),
    .preload_en     (preload_en),
    .preload_addr   (preload_addr),
    .preload_values (preload_values)
  );

  // clock generator
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // stimulus sequence
  initial begin
    // initial values
    rst            = 1;
    load_en        = 0;
    preload_en     = 0;
    instruction_in = 0;
    preload_addr   = 0;
    preload_values = 0;
    #20;

    rst = 0;  // release reset

    // preload some data
    preload_en     = 1;
    preload_addr   = 10;
    preload_values = {4{32'hDEADBEEF}};  // repeat pattern four times
    #10;
    preload_en = 0;

    // load one instruction
    load_en        = 1;
    instruction_in = 32'hA5A5A5A5;
    #10;
    load_en = 0;

    // let pipeline run for a while
    #200;

    $finish;
  end

  // // monitor outputs
  // initial begin
  //   $monitor("time %0t out1 %h out2 %h",
  //            $time, instruction_out1, instruction_out2);
  // end

endmodule
