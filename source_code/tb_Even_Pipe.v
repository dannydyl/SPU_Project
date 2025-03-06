// Dummy FX1_ALU module definition for simulation
module FX1_ALU(
  input  [0:6]   instr_id,
  input  [0:127] ra,
  input  [0:127] rb,
  input  [0:127] rc,
  input  [0:7]   imme7,
  input  [0:9]   imme10,
  input  [0:15]  imme16,
  input  [0:17]  imme18,
  output reg [0:127] result
);
  // Simple operation: for example, add ra and rb.
  always @(*) begin
    result = ra + rb;
  end
endmodule

// Testbench for Even_Pipe module
module tb_even_pipe;

  // Declare testbench signals (inputs as regs, outputs as wires)
  reg clk;
  reg rst;
  reg [0:31] full_isntr;
  reg [0:6]  instr_id;
  reg [0:6]  reg_dst;
  reg [0:2]  unit_id;
  reg [0:3]  latency;
  reg        reg_wr;
  reg [0:127] ra_data;
  reg [0:127] rb_data;
  reg [0:127] rc_data;
  reg [0:7]   imme7;
  reg [0:9]   imme10;
  reg [0:15]  imme16;
  reg [0:17]  imme18;

  wire [0:142] packed_result_1stage;
  wire [0:142] packed_result_2stage;
  wire [0:142] packed_result_3stage;
  wire [0:142] packed_result_4stage;
  wire [0:142] packed_result_5stage;
  wire [0:142] packed_result_6stage;
  wire [0:142] packed_result_7stage;
  wire [0:6]   WB_reg_write_addr;
  wire [0:127] WB_reg_write_data;
  wire         WB_reg_write_en;

  // Instantiate the device under test (DUT)
  Even_Pipe dut (
    .clk(clk),
    .rst(rst),
    .full_isntr(full_isntr),
    .instr_id(instr_id),
    .reg_dst(reg_dst),
    .unit_id(unit_id),
    .latency(latency),
    .reg_wr(reg_wr),
    .ra_data(ra_data),
    .rb_data(rb_data),
    .rc_data(rc_data),
    .imme7(imme7),
    .imme10(imme10),
    .imme16(imme16),
    .imme18(imme18),
    .packed_result_1stage(packed_result_1stage),
    .packed_result_2stage(packed_result_2stage),
    .packed_result_3stage(packed_result_3stage),
    .packed_result_4stage(packed_result_4stage),
    .packed_result_5stage(packed_result_5stage),
    .packed_result_6stage(packed_result_6stage),
    .packed_result_7stage(packed_result_7stage),
    .WB_reg_write_addr(WB_reg_write_addr),
    .WB_reg_write_data(WB_reg_write_data),
    .WB_reg_write_en(WB_reg_write_en)
  );

  // Clock generation: 10 time-unit period
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Stimulus: apply reset and then drive test vectors
  initial begin
    // Initialize inputs and assert reset
    rst = 1;
    full_isntr = 32'hFFFFFFFF;
    instr_id    = 7'b1010101;
    reg_dst     = 7'b0000111;
    unit_id     = 3'b000;  // Use FX1 mode
    latency     = 4'b0010;
    reg_wr      = 1'b1;
    ra_data     = 128'h11111111111111111111111111111111;
    rb_data     = 128'h22222222222222222222222222222222;
    rc_data     = 128'h33333333333333333333333333333333;
    imme7       = 8'hAA;
    imme10      = 10'b1010101010;
    imme16      = 16'hBEEF;
    imme18      = 18'h2AAAA;

    #12 rst = 0;  // Deassert reset just after one clock cycle

    // Wait for about 10 clock cycles to observe the pipeline (7-stage delay)
    #100;

    // Apply a new set of input values to see pipelining in action
    full_isntr = 32'h12345678;
    instr_id    = 7'b0101010;
    reg_dst     = 7'b1110001;
    unit_id     = 3'b000;  // Remains in FX1 mode
    latency     = 4'b0101;
    reg_wr      = 1'b0;
    ra_data     = 128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    rb_data     = 128'hBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB;
    rc_data     = 128'hCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC;
    imme7       = 8'h55;
    imme10      = 10'b0101010101;
    imme16      = 16'hFACE;
    imme18      = 18'h15555;

    #100;
    $finish;
  end

  // Monitor the WB stage outputs (which reflect the data after 7 pipeline stages)
  initial begin
    $monitor("Time=%0t | WB_reg_write_addr=%h | WB_reg_write_data=%h | WB_reg_write_en=%b",
             $time, WB_reg_write_addr, WB_reg_write_data, WB_reg_write_en);
  end

endmodule
