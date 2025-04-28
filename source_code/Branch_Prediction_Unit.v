module Branch_Prediction_Unit(
  input clk,
  input rst,
  input update,               // When actual outcome is available
  input branch_taken_actual,  // 1 if branch was taken
  input [7:0] branch_addr,     // Branch index
  output reg predict_taken    // 1 = predict taken, 0 = predict not taken
);

 // Define FSM states manually
parameter STRONGLY_NOT_TAKEN = 2'b00;
parameter WEAKLY_NOT_TAKEN   = 2'b01;
parameter WEAKLY_TAKEN       = 2'b10;
parameter STRONGLY_TAKEN     = 2'b11;

// Predictor table
reg [1:0] predictor_table [0:255];
reg [1:0] current_state;

integer i;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        for (i = 0; i < 256; i = i + 1)
            predictor_table[i] <= WEAKLY_NOT_TAKEN; // Initialize to weakly not taken
    end
    else if (update) begin
        current_state = predictor_table[branch_addr];
        case (current_state)
            STRONGLY_NOT_TAKEN: begin
                if (branch_taken_actual)
                    predictor_table[branch_addr] <= WEAKLY_NOT_TAKEN;
                else
                    predictor_table[branch_addr] <= STRONGLY_NOT_TAKEN;
            end

            WEAKLY_NOT_TAKEN: begin
                if (branch_taken_actual)
                    predictor_table[branch_addr] <= WEAKLY_TAKEN;
                else
                    predictor_table[branch_addr] <= STRONGLY_NOT_TAKEN;
            end

            WEAKLY_TAKEN: begin
                if (branch_taken_actual)
                    predictor_table[branch_addr] <= STRONGLY_TAKEN;
                else
                    predictor_table[branch_addr] <= WEAKLY_NOT_TAKEN;
            end

            STRONGLY_TAKEN: begin
                if (branch_taken_actual)
                    predictor_table[branch_addr] <= STRONGLY_TAKEN;
                else
                    predictor_table[branch_addr] <= WEAKLY_TAKEN;
            end

            default: predictor_table[branch_addr] <= WEAKLY_NOT_TAKEN;
        endcase
    end
end

// Combinational prediction
always @(*) begin
    current_state = predictor_table[branch_addr];
    predict_taken = current_state[1]; // MSB decides prediction
end

endmodule