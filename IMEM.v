module IMEM(
    input wire clk,
    input wire rst,
    input wire load_en,
    input wire [31:0] instruction_in,
    output reg [31:0] instruction_out,
    output reg no_more_instruction,
    output wire [9:0] PC_out_v  // Now uses 10-bit PC to address 1024 instructions
);

    // Constants
    localparam LINE_LENGTH = 1024;  // 1024 instructions (4KB total)

    // Instruction buffer memory (4KB = 1024 x 32-bit instructions)
    reg [31:0] instr_buffer [0:LINE_LENGTH-1];
    
    // Program Counter
    reg [9:0] PC_current;

    // Instantiate Program Counter module
    Program_Counter PC_inst (
        .clk(clk),
        .rst(rst),
        .PC_out(PC_current)
    );

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
                instruction_out <= instr_buffer[PC_current];  // Read instruction
                if (PC_current == LINE_LENGTH-1)
                    no_more_instruction <= 1'b1;
                else
                    no_more_instruction <= 1'b0;
            end
        end
    end
endmodule
