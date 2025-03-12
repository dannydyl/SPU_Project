module FX2_ALU(
  input [0:6] instr_id,
  input [0:127] ra_data,
  input [0:127] rb_data,
  input [0:127] rc_data, // rc port is also used for instructions that need rt data as an operand
  input [0:7] imme7,
  input [0:9] imme10,
  input [0:15] imme16,
  input [0:17] imme18,

  output reg [0:127] result
);

`include "opcode_package.vh"

wire [0:127] rot_result, roth_result, roti_result, rothi_result, shl_result, shlh_result, shli_result, shlhi_result;

always @(*) begin
  case (instr_id)
    `instr_ID_rot:    result = rot_result;
    `instr_ID_roth:   result = roth_result;
    `instr_ID_roti:   result = roti_result;
    `instr_ID_rothi:  result = rothi_result;
    `instr_ID_shl:    result = shl_result;
    `instr_ID_shlh:   result = shlh_result;
    `instr_ID_shli:   result = shli_result;
    `instr_ID_shlhi:  result = shlhi_result;
    default : result = 128'h0;
  endcase
end

rot rot_inst (
  .ra(ra_data),
  .rb(rb_data),
  .result(rot_result)
);

roth roth_inst (
  .ra(ra_data),
  .rb(rb_data),
  .result(roth_result)
);

rothi rothi_inst (
  .ra(ra_data),
  .imme7(imme7),
  .result(rothi_result)
);

roti roti_inst (
  .ra(ra_data),
  .imme7(imme7),
  .result(roti_result)
);

shl shl_inst (
  .ra(ra_data),
  .rb(rb_data),
  .result(shl_result)
);

shlh shlh_inst (
  .ra(ra_data),
  .rb(rb_data),
  .result(shlh_result)
);

shlhi shlhi_inst (
  .ra(ra_data),
  .imme7(imme7),
  .result(shlhi_result)
);

shli shli_inst (
  .ra(ra_data),
  .imme7(imme7),
  .result(shli_result)
);

endmodule