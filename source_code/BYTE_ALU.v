module BYTE_ALU(
  input [0:6] instr_id,
  input [0:127] ra_data,
  input [0:127] rb_data,
  input [0:127] rc_data, // rc port is also used for instructions that need rt data as an operand
  input [0:6] imme7,
  input [0:9] imme10,
  input [0:15] imme16,
  input [0:17] imme18,

  output reg [0:127] result
);

`include "opcode_package.vh"

wire [0:127] absdb_result, avgb_result, cntb_result, sumb_result;

always @(*) begin
  case (instr_id)
    `instr_ID_absdb: result = absdb_result;
    `instr_ID_avgb:  result = avgb_result;
    `instr_ID_cntb:  result = cntb_result;
    `instr_ID_sumb:  result = sumb_result;
  endcase
end
absdb absdb_inst (
  .ra(ra_data),
  .rb(rb_data),
  .result(absdb_result)
);

avgb avgb_inst (
  .ra(ra_data),
  .rb(rb_data),
  .result(avgb_result)
);

cntb cntb_inst (
  .ra(ra_data),
  .result(cntb_result)
);

sumb sumb_inst (
  .ra(ra_data),
  .rb(rb_data),
  .result(sumb_result)
);

endmodule