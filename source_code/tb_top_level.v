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
  reg         preload_LS_en;
  reg [0:6] preload_LS_addr;
  reg [0:127] preload_LS_data;

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
    .preload_values (preload_values),
    .preload_LS_en  (preload_LS_en),
    .preload_LS_addr(preload_LS_addr),
    .preload_LS_data(preload_LS_data)
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
    // -------------------------
    // initial values
    rst            = 1;
    load_en        = 0;
    preload_en     = 0;
    instruction_in = 0;
    instr_load_addr = 0;
    preload_addr   = 0;
    preload_values = 0;
    preload_LS_en  = 0;
    preload_LS_addr = 0;
    preload_LS_data = 0;
    #(clock_cycle);  
    
    // preload to LS
    preload_LS_en  = 1;

    preload_LS_addr = 15'b000_0000_0001_0000;
    preload_LS_data = 128'h00000001_00000001_00000001_00000001;
    #(clock_cycle); 

    preload_LS_addr = 15'b000_0000_0010_0000;
    preload_LS_data = 128'h00000002_00000002_00000002_00000002;
    #(clock_cycle); 

    preload_LS_addr = 15'b000_0000_0011_0000;
    preload_LS_data = 128'h00000003_00000003_00000003_00000003;
    #(clock_cycle); 

    preload_LS_addr = 15'b000_0000_0100_0000;
    preload_LS_data = 128'h00000004_00000004_00000004_00000004;
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
    #(clock_cycle/2);
    rst = 0;  // release reset
    preload_LS_en  = 0;
    load_en = 0;
    
    // -------------------------
    // let pipeline run for a while
    #800;

    $finish;
  end

  // // monitor outputs
  // initial begin
  //   $monitor("time %0t out1 %h out2 %h",
  //            $time, instruction_out1, instruction_out2);
  // end

endmodule
