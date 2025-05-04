module IF_wrapper(
    input  clk,
    input  rst,
    input  load_en,
    input  [0:31] instruction_in,
    input [0:8] instr_load_addr,
    input [0:8] PC_br_target,
    input  branch_taken,
    input is_branch,
    input  stall,

    output reg [0:8] PC_current_out,
    output reg [0:31] instruction_out1,
    output reg [0:31] instruction_out2,
    output reg find_nop
);
    localparam LINE_LENGTH = 512;  // 512 instructions (2KB total)

    // Instruction buffer memory (2KB = 512 x 32-bit instructions)
    reg [0:31] instr_buffer [0:LINE_LENGTH-1];
    
    // Program Counter
    reg no_more_instruction;
    reg [0:8] PC;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            PC <= 9'b0;  // Reset PC to 0
            instruction_out1 <= 32'b0;
            instruction_out2 <= 32'b0;
            PC_current_out <= 10'b0;  // Reset output PC
        end
        else begin
            if (is_branch && branch_taken) begin // branch taken
                if (PC_br_target[9] == 1'b1) begin // misaligned target
                    instruction_out1 <= 32'b0;  
                    instruction_out2 <= instr_buffer[PC_br_target - 2];  
                    PC <= PC_br_target - 1;
                    find_nop <= 1'b1; // telling ID stage to find which nop is needed
                end
                else begin // aligned target
                    instruction_out1 <= instr_buffer[PC_br_target - 2];
                    instruction_out2 <= instr_buffer[PC_br_target - 1];
                    PC <= PC_br_target;
                    find_nop <= 1'b0; 
                end
            end
            else if (stall) begin
                // hold PC
                instruction_out1 <= instr_buffer[PC - 2];
                instruction_out2 <= instr_buffer[PC - 1];
                PC <= PC;
                find_nop <= 1'b0; 
            end
            else begin
                // Normal operation, increment PC
                instruction_out1 <= instr_buffer[PC];
                instruction_out2 <= instr_buffer[PC + 1];
                PC <= PC + 2;
                find_nop <= 1'b0;
            end
            PC_current_out <= PC;  // Update output PC
        end

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
            if (PC == LINE_LENGTH-1) begin
                no_more_instruction <= 1'b1;
            end else begin
                no_more_instruction <= 1'b0;
            end
        end
    end
endmodule
