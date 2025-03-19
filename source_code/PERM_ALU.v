module PERM_ALU(
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

wire [0:127] rotqbi_result, rotqbii_result, rotqby_result, rotqbyi_result,
              shlqbi_result, shlqbii_result, shlqby_result, shlqbyi_result;

always @(*) begin
  case (instr_id)
    `instr_ID_rotqbi:  result = rotqbi_result;
    `instr_ID_rotqbii: result = rotqbii_result;
    `instr_ID_rotqby:  result = rotqby_result;
    `instr_ID_rotqbyi: result = rotqbyi_result;
    `instr_ID_shlqbi:  result = shlqbi_result;
    `instr_ID_shlqbii: result = shlqbii_result;
    `instr_ID_shlqby:  result = shlqby_result;
    `instr_ID_shlqbyi: result = shlqbyi_result;
    default : result = 128'h0;
  endcase
end

rotqbi rotqbi_inst (
  .ra(ra_data),
  .rb(rb_data),
  .result(rotqbi_result)
);

rotqbii rotqbii_inst (
  .ra(ra_data),
  .imme7(imme7),
  .result(rotqbii_result)
);

rotqby rotqby_inst (
  .ra(ra_data),
  .rb(rb_data),
  .result(rotqby_result)
);

rotqbyi rotqbyi_inst (
  .ra(ra_data),
  .imme7(imme7),
  .result(rotqbyi_result)
);

shlqbi shlqbi_inst (
  .ra(ra_data),
  .rb(rb_data),
  .result(shlqbi_result)
);

shlqbii shlqbii_inst (
  .ra(ra_data),
  .imme7(imme7),
  .result(shlqbii_result)
);

shlqby shlqby_inst (
  .ra(ra_data),
  .rb(rb_data),
  .result(shlqby_result)
);

shlqbyi shlqbyi_inst (
  .ra(ra_data),
  .imme7(imme7),
  .result(shlqbyi_result)
);

endmodule