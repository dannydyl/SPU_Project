module IF_wrapper(
    input  clk,
    input  rst,
    input  load_en,
    input  [0:31] instruction_in,
    input [0:9] instr_load_addr,
    input [0:9] PC_in,
    input  branch_taken,
    input  stall,

    output reg [0:9] PC_current_out,
    output reg [0:31] instruction_out1,
    output reg [0:31] instruction_out2
);
    localparam LINE_LENGTH = 1024;  // 1024 instructions (4KB total)

    // Instruction buffer memory (4KB = 1024 x 32-bit instructions)
    reg [0:31] instr_buffer [0:LINE_LENGTH-1];
    
    // Program Counter
    reg no_more_instruction;
    wire [0:9] PC_current;

    // Instantiate Program Counter module
    Program_Counter PC_inst (
        .clk(clk),
        .rst(rst),
        .branch_taken(branch_taken),
        .stall(stall),
        .PC_in(PC_in),
        .PC_out(PC_current)
    );

    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            instruction_out1 <= 32'b0;
            instruction_out2 <= 32'b0;
        end
        else if (!stall) begin
            // Only fetch new instructions if not stalled
            instruction_out1 <= instr_buffer[PC_current];
            instruction_out2 <= instr_buffer[PC_current + 1];
        end
        PC_current_out <= PC_current;  // Output current PC

    end
    
integer i;
    // Process to load and output instructions
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            if (load_en) begin
                instr_buffer[instr_load_addr] <= instruction_in;  // Load instruction
            end
                // for (i = 0; i < LINE_LENGTH; i = i + 1)
                //     instr_buffer[i] <= 32'b0;
                no_more_instruction <= 1'b0;
        end else begin
            if (PC_current == LINE_LENGTH-1) begin
                no_more_instruction <= 1'b1;
            end else begin
                no_more_instruction <= 1'b0;
            end
        end
    end
endmodule
