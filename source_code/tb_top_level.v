`timescale 1ns/1ps

module tb_top_level;

  // signal declarations
  reg         clk;
  reg         rst;
  reg         load_en;
  reg         preload_en;
  reg  [0:31] instruction_in;
  reg  [0:9]  instr_load_addr;
  reg   [0:9] preload_addr;
  reg [0:127] preload_values;

  integer i;
  reg [0:31] instruction_mem [0:1023];  // up to 1024 instructions

  // instantiate device under test
  top_level dut (
    .clk            (clk),
    .rst            (rst),
    .load_en        (load_en),
    .instruction_in (instruction_in),
    .instr_load_addr (instr_load_addr),
    .preload_en     (preload_en),
    .preload_addr   (preload_addr),
    .preload_values (preload_values)
  );

  localparam clock_cycle = 10;
  // Clock generation: 10ns period
  initial begin
    clk = 0;
    forever #(clock_cycle/2) clk = ~clk;
  end

  // stimulus sequence
  initial begin
    #(clock_cycle/2);
    // -------------------------
    // Read instructions from file
    $readmemb("/home/home5/dlee/ese545work/SPU_Project/output_binary.txt", instruction_mem);  
    $display("Checking first few loaded instructions:");
    $display("instruction_mem[0] = %b", instruction_mem[0]);
    $display("instruction_mem[1] = %b", instruction_mem[1]);
    $display("instruction_mem[2] = %b", instruction_mem[2]);
    $display("instruction_mem[3] = %b", instruction_mem[3]);
    // -------------------------
    // initial values
    rst            = 1;
    load_en        = 0;
    preload_en     = 0;
    instruction_in = 0;
    instr_load_addr = 0;
    preload_addr   = 0;
    preload_values = 0;
    #(clock_cycle);  

    // -------------------------
    // Feed instructions one by one
    
    load_en = 1;
    i = 0;
    begin : load_loop
      for (i = 0; i < 1024; i = i + 1) begin
        if (instruction_mem[i] === 32'bx) begin
          disable load_loop;
        end
        else begin
          instr_load_addr = i[9:0];
          instruction_in  = instruction_mem[i];
          #(clock_cycle);
        end
      end
    end
    rst = 0;  // release reset
    load_en = 0;
    // -------------------------
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
