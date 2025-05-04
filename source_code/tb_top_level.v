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
  reg [0:14] preload_LS_addr;
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
    clk = 1;
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

    // matrix A
    preload_LS_addr = 15'b000_0000_0000_0000;
    preload_LS_data = 128'h00000000_00000000_00000000_00000000;
    #(clock_cycle); 

    preload_LS_addr = 15'b000_0000_0001_0000;
    preload_LS_data = 128'h3f800000_3f800000_3f800000_3f800000;
    #(clock_cycle); 

    preload_LS_addr = 15'b000_0000_0010_0000;
    preload_LS_data = 128'h40000000_40000000_40000000_40000000;
    #(clock_cycle); 

    preload_LS_addr = 15'b000_0000_0011_0000;
    preload_LS_data = 128'h40400000_40400000_40400000_40400000;
    #(clock_cycle); 

    // A matrix for other elements
    // preload_LS_addr = 15'b000_0000_0001_0000;
    // preload_LS_data = 128'h40800000_40a00000_40c00000_40e00000;
    // #(clock_cycle); 

    // preload_LS_addr = 15'b000_0000_0010_0000;
    // preload_LS_data = 128'h41000000_41100000_41200000_41300000;
    // #(clock_cycle); 

    // preload_LS_addr = 15'b000_0000_0011_0000;
    // preload_LS_data = 128'h41400000_41500000_41600000_41700000;
    // #(clock_cycle); 

    // matrix B
    preload_LS_addr = 15'b000_0000_0100_0000;
    preload_LS_data = 128'h41800000_41800000_41800000_41800000;
    #(clock_cycle); 

    preload_LS_addr = 15'b000_0000_0101_0000;
    preload_LS_data = 128'h41a00000_41a00000_41a00000_41a00000;
    #(clock_cycle); 

    preload_LS_addr = 15'b000_0000_0110_0000;
    preload_LS_data = 128'h41c00000_41c00000_41c00000_41c00000;
    #(clock_cycle); 

    preload_LS_addr = 15'b000_0000_0111_0000;
    preload_LS_data = 128'h41e00000_41e00000_41e00000_41e00000;
    #(clock_cycle); 

    // B matrix for other elements
    // preload_LS_addr = 15'b000_0000_0101_0000;
    // preload_LS_data = 128'h41880000_41a80000_41c80000_41e80000;
    // #(clock_cycle); 

    // preload_LS_addr = 15'b000_0000_0110_0000;
    // preload_LS_data = 128'h41900000_41b00000_41d00000_41f00000;
    // #(clock_cycle); 

    // preload_LS_addr = 15'b000_0000_0111_0000;
    // preload_LS_data = 128'h41980000_41b80000_41d80000_41f80000;
    // #(clock_cycle); 


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
    #(clock_cycle); 
    // -------------------------
    // let pipeline run for a while
    #2000;

    $finish;
  end

  // // monitor outputs
  // initial begin
  //   $monitor("time %0t out1 %h out2 %h",
  //            $time, instruction_out1, instruction_out2);
  // end

endmodule
