module Dual_instr_fetch(
    input wire clk,
    input wire rst,
    input wire load_en,
    input wire [0:31] instruction_in,
    output reg [0:31] instruction_out1,
    output reg [0:31] instruction_out2
);

    // Constants
    localparam LINE_LENGTH = 1024;  // 1024 instructions (4KB total)

    // Instruction buffer memory (4KB = 1024 x 32-bit instructions)
    reg [0:31] instr_buffer [0:LINE_LENGTH-1];
    
    // Program Counter
    reg [0:9] PC_current;
    reg no_more_instruction;

    // Instantiate Program Counter module
    Program_Counter PC_inst (
        .clk(clk),
        .rst(rst),
        .PC_out(PC_current)
    );

    assign instruction_out1 = instr_buffer[PC_current];
    assign instruction_out2 = instr_buffer[PC_current+1];

    // Process to load and output instructions
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            integer i;
            for (i = 0; i < LINE_LENGTH; i = i + 1)
                instr_buffer[i] <= 32'b0;
            no_more_instruction <= 1'b0;
        end else begin
            if (load_en) begin
                instr_buffer[PC_current] <= instruction_in;  // Load instruction
            end else begin
                if (PC_current == LINE_LENGTH-1)
                    no_more_instruction <= 1'b1;
                else
                    no_more_instruction <= 1'b0;
            end
        end
    end
endmodule
