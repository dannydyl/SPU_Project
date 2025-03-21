module LS_ALU(
  input [0:6] instr_id,
  input [0:127] ra_data,
  input [0:9] imme10,
  input [0:15] imme16,

  output reg [0:14] addr_result
);

`include "opcode_package.vh"

wire [0:14] lqa_result, lqd_result, stqa_result, stqd_result;

always @(*) begin
  case(instr_id)
    `instr_ID_lqa: addr_result = lqa_result;
    `instr_ID_lqd: addr_result = lqd_result;
    `instr_ID_stqa: addr_result = stqa_result;
    `instr_ID_stqd: addr_result = stqd_result;
    default: addr_result = 15'b0;
  endcase
end

lqa lqa_inst (
  .imme16(imme16),
  .addr_result(lqa_result)
);

lqd lqd_inst (
  .ra(ra_data),
  .imme10(imme10),
  .addr_result(lqd_result)
);

stqa stqa_inst (
  .imme16(imme16),
  .addr_result(stqa_result)
);

stqd stqd_inst (
  .ra(ra_data),
  .imme10(imme10),
  .addr_result(stqd_result)
);

endmodule